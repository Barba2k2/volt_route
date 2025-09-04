import 'dart:math';

import 'package:result_dart/result_dart.dart';

import '../../core/services/logger_service.dart';
import '../entities/charger.dart';
import '../entities/leg_estimate.dart';
import '../entities/route_polyline.dart';
import '../entities/trip.dart';
import '../entities/vehicle.dart';
import '../interfaces/usecase_interface.dart';
import '../repositories/charging_repository.dart';
import '../repositories/routing_repository.dart';

/// Use case for planning a complete EV trip with charging stops
class PlanRoute implements UseCase<Trip, PlanRouteParams> {
  final RoutingRepository _routingRepository;
  final ChargingRepository _chargingRepository;
  final LoggerService _loggerService;

  const PlanRoute({
    required RoutingRepository routingRepository,
    required ChargingRepository chargingRepository,
    required LoggerService loggerService,
  })  : _routingRepository = routingRepository,
        _chargingRepository = chargingRepository,
        _loggerService = loggerService;

  @override
  Future<Result<Trip>> call(PlanRouteParams params) async {
    try {
      // Get route from origin to destination
      final routeResult = await _routingRepository.getRoute(
        originLat: params.originLat,
        originLng: params.originLng,
        destinationLat: params.destinationLat,
        destinationLng: params.destinationLng,
      );

      if (routeResult.isError()) {
        return Failure(routeResult.exceptionOrNull()!);
      }

      final route = routeResult.getOrThrow();

      // Get charging stations along the route
      final chargersResult = await _chargingRepository.getChargersAlongRoute(
        route: route,
        vehicle: params.vehicle,
        searchRadiusKm: params.searchRadiusKm,
      );

      if (chargersResult.isError()) {
        return Failure(chargersResult.exceptionOrNull()!);
      }

      final chargers = chargersResult.getOrThrow();

      // Calculate energy estimates for each leg
      final legEstimates = await _calculateLegEstimates(
        route: route,
        chargers: chargers,
        vehicle: params.vehicle,
        assumptions: params.assumptions,
      );

      // Create trip
      final trip = Trip(
        id: _generateTripId(),
        name: params.tripName,
        origin: route.waypoints.first,
        destination: route.waypoints.last,
        vehicle: params.vehicle,
        route: route,
        legEstimates: legEstimates,
        assumptions: params.assumptions,
        createdAt: DateTime.now(),
        isSaved: false,
        userId: params.userId,
      );

      return Success(trip);
    } catch (e) {
      final exception = Exception('Failed to plan route: ${e.toString()}');

      _loggerService.logException(
        exception,
        context: 'PlanRoute UseCase',
        additionalData: {
          'originLat': params.originLat,
          'originLng': params.originLng,
          'destinationLat': params.destinationLat,
          'destinationLng': params.destinationLng,
          'vehicleId': params.vehicle.id,
          'tripName': params.tripName,
        },
        stackTrace: StackTrace.current,
      );

      return Failure(exception);
    }
  }

  /// Calculates energy estimates for each leg of the route
  Future<List<LegEstimate>> _calculateLegEstimates({
    required RoutePolyline route,
    required List<Charger> chargers,
    required Vehicle vehicle,
    required TripAssumptions assumptions,
  }) async {
    final legEstimates = <LegEstimate>[];
    double currentSoC = 100.0; // Start with full battery

    for (int i = 0; i < route.legs.length; i++) {
      final leg = route.legs[i];

      // Calculate energy consumption for this leg
      final energyConsumed = _calculateEnergyConsumption(
        leg: leg,
        vehicle: vehicle,
        assumptions: assumptions,
      );

      // Calculate arrival SoC
      final arrivalSoC =
          currentSoC - (energyConsumed / vehicle.usableBatteryKwh * 100);

      // Check if we need to charge
      Charger? chargingStop;
      double? energyToAdd;
      int? chargingTime;
      double? chargingCost;

      if (arrivalSoC < assumptions.reserveBufferPercent) {
        // Find the best charging stop for this leg
        final nearbyChargers = _findNearbyChargers(
          leg: leg,
          chargers: chargers,
          vehicle: vehicle,
        );

        if (nearbyChargers.isNotEmpty) {
          chargingStop = nearbyChargers.first;
          energyToAdd = _calculateEnergyToAdd(
            arrivalSoC: arrivalSoC,
            targetSoC: 80.0, // Charge to 80% for optimal speed
            vehicle: vehicle,
          );
          chargingTime = _calculateChargingTime(
            energyToAdd: energyToAdd,
            charger: chargingStop,
            vehicle: vehicle,
          );
          chargingCost = energyToAdd * assumptions.chargingCostPerKwh;
        }
      }

      final departureSoC = chargingStop != null
          ? (arrivalSoC + (energyToAdd! / vehicle.usableBatteryKwh * 100))
          : arrivalSoC;

      legEstimates.add(LegEstimate(
        leg: leg,
        energyConsumedKwh: energyConsumed,
        arrivalSoCPercent: arrivalSoC,
        departureSoCPercent: departureSoC,
        chargingStop: chargingStop,
        energyToAddKwh: energyToAdd,
        chargingTimeMinutes: chargingTime,
        chargingCost: chargingCost,
        assumptions: _generateAssumptions(leg, vehicle, assumptions),
      ));

      currentSoC = departureSoC;
    }

    return legEstimates;
  }

  /// Calculates energy consumption for a route leg
  double _calculateEnergyConsumption({
    required RouteLeg leg,
    required Vehicle vehicle,
    required TripAssumptions assumptions,
  }) {
    // Base consumption
    double baseConsumption = leg.distanceKm * vehicle.efficiencyWhPerKm / 1000;

    // Speed factor (higher speeds increase consumption)
    final speedFactor = _calculateSpeedFactor(
      leg.averageSpeedKmh ?? assumptions.averageSpeedKmh,
    );

    // Elevation factor
    final elevationFactor = _calculateElevationFactor(
      leg.elevationGainMeters ?? 0,
      leg.distanceKm,
    );

    // HVAC factor
    final hvacFactor = assumptions.useHvac
        ? (1 + assumptions.hvacConsumptionPercent / 100)
        : 1.0;

    return baseConsumption * speedFactor * elevationFactor * hvacFactor;
  }

  /// Calculates speed factor for energy consumption
  double _calculateSpeedFactor(double speedKmh) {
    if (speedKmh <= 80) return 1.0;
    if (speedKmh <= 100) return 1.1;
    if (speedKmh <= 120) return 1.3;
    return 1.5; // Very high speeds
  }

  /// Calculates elevation factor for energy consumption
  double _calculateElevationFactor(
      double elevationGainMeters, double distanceKm) {
    if (elevationGainMeters <= 0) return 1.0;

    // Rough estimate: 1% increase per 10m elevation gain per km
    final elevationGainPerKm = elevationGainMeters / distanceKm;
    return 1 + (elevationGainPerKm / 10 * 0.01);
  }

  /// Finds nearby chargers for a route leg
  List<Charger> _findNearbyChargers({
    required RouteLeg leg,
    required List<Charger> chargers,
    required Vehicle vehicle,
  }) {
    final nearbyChargers = <Charger>[];

    for (final charger in chargers) {
      // Check if charger is near the leg
      final distance = _calculateDistance(
        leg.endLocation.latitude,
        leg.endLocation.longitude,
        charger.latitude,
        charger.longitude,
      );

      if (distance <= 5.0) {
        // Within 5km
        nearbyChargers.add(charger);
      }
    }

    // Sort by distance and compatibility
    nearbyChargers.sort((a, b) {
      final distanceA = _calculateDistance(
        leg.endLocation.latitude,
        leg.endLocation.longitude,
        a.latitude,
        a.longitude,
      );
      final distanceB = _calculateDistance(
        leg.endLocation.latitude,
        leg.endLocation.longitude,
        b.latitude,
        b.longitude,
      );

      return distanceA.compareTo(distanceB);
    });

    return nearbyChargers;
  }

  /// Calculates distance between two points in kilometers
  double _calculateDistance(
      double lat1, double lng1, double lat2, double lng2) {
    const double earthRadius = 6371; // Earth's radius in kilometers

    final dLat = _degreesToRadians(lat2 - lat1);
    final dLng = _degreesToRadians(lng2 - lng1);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1 * pi / 180) *
            cos(lat2 * pi / 180) *
            sin(dLng / 2) *
            sin(dLng / 2);

    final c = 2 * asin(sqrt(a));

    return earthRadius * c;
  }

  /// Converts degrees to radians
  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  /// Calculates energy to add during charging
  double _calculateEnergyToAdd({
    required double arrivalSoC,
    required double targetSoC,
    required Vehicle vehicle,
  }) {
    final energyNeeded =
        (targetSoC - arrivalSoC) / 100 * vehicle.usableBatteryKwh;
    return energyNeeded > 0 ? energyNeeded : 0;
  }

  /// Calculates charging time in minutes
  int _calculateChargingTime({
    required double energyToAdd,
    required Charger charger,
    required Vehicle vehicle,
  }) {
    final maxPower = charger.maxPowerKw ?? vehicle.maxDcChargingPowerKw;
    if (maxPower <= 0) return 0;

    // Simple calculation: energy / power = time
    final timeHours = energyToAdd / maxPower;
    return (timeHours * 60).round();
  }

  /// Generates assumptions for a leg estimate
  List<String> _generateAssumptions(
    RouteLeg leg,
    Vehicle vehicle,
    TripAssumptions assumptions,
  ) {
    final assumptionsList = <String>[];

    if (leg.averageSpeedKmh == null) {
      assumptionsList.add(
          'Using assumed average speed: ${assumptions.averageSpeedKmh} km/h');
    }

    if (leg.elevationGainMeters == null) {
      assumptionsList
          .add('Elevation data not available, using flat terrain assumption');
    }

    if (assumptions.useHvac) {
      assumptionsList.add(
          'HVAC consumption included: ${assumptions.hvacConsumptionPercent}%');
    }

    return assumptionsList;
  }

  /// Generates a unique trip ID
  String _generateTripId() {
    return 'trip_${DateTime.now().millisecondsSinceEpoch}';
  }
}

/// Parameters for planning a route
class PlanRouteParams {
  final double originLat;
  final double originLng;
  final double destinationLat;
  final double destinationLng;
  final Vehicle vehicle;
  final TripAssumptions assumptions;
  final String tripName;
  final String? userId;
  final double searchRadiusKm;

  const PlanRouteParams({
    required this.originLat,
    required this.originLng,
    required this.destinationLat,
    required this.destinationLng,
    required this.vehicle,
    required this.assumptions,
    required this.tripName,
    this.userId,
    this.searchRadiusKm = 5.0,
  });
}
