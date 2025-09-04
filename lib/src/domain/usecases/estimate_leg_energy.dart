import 'dart:math';

import 'package:result_dart/result_dart.dart';

import '../entities/charger.dart';
import '../entities/leg_estimate.dart';
import '../entities/route_polyline.dart';
import '../entities/trip.dart';
import '../entities/vehicle.dart';
import '../interfaces/usecase_interface.dart';

/// Use case for estimating energy consumption for a specific route leg
class EstimateLegEnergy
    implements UseCase<LegEstimate, EstimateLegEnergyParams> {
  @override
  Future<Result<LegEstimate>> call(EstimateLegEnergyParams params) async {
    try {
      final leg = params.leg;
      final vehicle = params.vehicle;
      final assumptions = params.assumptions;
      final currentSoC = params.currentSoC;

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
          chargers: params.availableChargers,
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

      final legEstimate = LegEstimate(
        leg: leg,
        energyConsumedKwh: energyConsumed,
        arrivalSoCPercent: arrivalSoC,
        departureSoCPercent: departureSoC,
        chargingStop: chargingStop,
        energyToAddKwh: energyToAdd,
        chargingTimeMinutes: chargingTime,
        chargingCost: chargingCost,
        assumptions: _generateAssumptions(leg, vehicle, assumptions),
      );

      return Success(legEstimate);
    } catch (e) {
      return Failure(
        Exception('Failed to estimate leg energy: ${e.toString()}'),
      );
    }
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
        cos(lat1) * cos(lat2) * sin(dLng / 2) * sin(dLng / 2);

    final c = 2 * asin(sqrt(a));

    return earthRadius * c;
  }

  /// Converts degrees to radians
  double _degreesToRadians(double degrees) {
    return degrees * (3.14159265359 / 180);
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
}

/// Parameters for estimating leg energy
class EstimateLegEnergyParams {
  final RouteLeg leg;
  final Vehicle vehicle;
  final TripAssumptions assumptions;
  final double currentSoC;
  final List<Charger> availableChargers;

  const EstimateLegEnergyParams({
    required this.leg,
    required this.vehicle,
    required this.assumptions,
    required this.currentSoC,
    required this.availableChargers,
  });
}
