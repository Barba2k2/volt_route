import 'package:equatable/equatable.dart';
import 'route_polyline.dart';
import 'leg_estimate.dart';
import 'vehicle.dart';

/// Represents a complete trip with route and energy estimates
class Trip extends Equatable {
  final String id;
  final String name;
  final LatLng origin;
  final LatLng destination;
  final Vehicle vehicle;
  final RoutePolyline route;
  final List<LegEstimate> legEstimates;
  final TripAssumptions assumptions;
  final DateTime createdAt;
  final DateTime? lastModified;
  final bool isSaved;
  final String? userId;

  const Trip({
    required this.id,
    required this.name,
    required this.origin,
    required this.destination,
    required this.vehicle,
    required this.route,
    required this.legEstimates,
    required this.assumptions,
    required this.createdAt,
    this.lastModified,
    required this.isSaved,
    this.userId,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        origin,
        destination,
        vehicle,
        route,
        legEstimates,
        assumptions,
        createdAt,
        lastModified,
        isSaved,
        userId,
      ];

  Trip copyWith({
    String? id,
    String? name,
    LatLng? origin,
    LatLng? destination,
    Vehicle? vehicle,
    RoutePolyline? route,
    List<LegEstimate>? legEstimates,
    TripAssumptions? assumptions,
    DateTime? createdAt,
    DateTime? lastModified,
    bool? isSaved,
    String? userId,
  }) {
    return Trip(
      id: id ?? this.id,
      name: name ?? this.name,
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      vehicle: vehicle ?? this.vehicle,
      route: route ?? this.route,
      legEstimates: legEstimates ?? this.legEstimates,
      assumptions: assumptions ?? this.assumptions,
      createdAt: createdAt ?? this.createdAt,
      lastModified: lastModified ?? this.lastModified,
      isSaved: isSaved ?? this.isSaved,
      userId: userId ?? this.userId,
    );
  }

  /// Get total energy consumption for the trip
  double get totalEnergyConsumedKwh {
    return legEstimates.fold(0.0, (sum, leg) => sum + leg.energyConsumedKwh);
  }

  /// Get total charging time in minutes
  int get totalChargingTimeMinutes {
    return legEstimates.fold(
        0, (sum, leg) => sum + (leg.chargingTimeMinutes ?? 0));
  }

  /// Get total driving time in minutes
  int get totalDrivingTimeMinutes {
    return route.totalDurationMinutes;
  }

  /// Get total trip time including charging
  int get totalTripTimeMinutes {
    return totalDrivingTimeMinutes + totalChargingTimeMinutes;
  }

  /// Get estimated total cost
  double get estimatedTotalCost {
    return legEstimates.fold(
        0.0, (sum, leg) => sum + (leg.chargingCost ?? 0.0));
  }

  /// Get number of charging stops
  int get numberOfChargingStops {
    return legEstimates.where((leg) => leg.chargingStop != null).length;
  }
}

/// Represents the assumptions used for trip planning
class TripAssumptions extends Equatable {
  final double averageSpeedKmh;
  final double reserveBufferPercent;
  final double ambientTemperatureCelsius;
  final bool useHvac;
  final double hvacConsumptionPercent;
  final double chargingCostPerKwh;
  final int maxChargingSessionMinutes;

  const TripAssumptions({
    required this.averageSpeedKmh,
    required this.reserveBufferPercent,
    required this.ambientTemperatureCelsius,
    required this.useHvac,
    required this.hvacConsumptionPercent,
    required this.chargingCostPerKwh,
    required this.maxChargingSessionMinutes,
  });

  @override
  List<Object?> get props => [
        averageSpeedKmh,
        reserveBufferPercent,
        ambientTemperatureCelsius,
        useHvac,
        hvacConsumptionPercent,
        chargingCostPerKwh,
        maxChargingSessionMinutes,
      ];

  TripAssumptions copyWith({
    double? averageSpeedKmh,
    double? reserveBufferPercent,
    double? ambientTemperatureCelsius,
    bool? useHvac,
    double? hvacConsumptionPercent,
    double? chargingCostPerKwh,
    int? maxChargingSessionMinutes,
  }) {
    return TripAssumptions(
      averageSpeedKmh: averageSpeedKmh ?? this.averageSpeedKmh,
      reserveBufferPercent: reserveBufferPercent ?? this.reserveBufferPercent,
      ambientTemperatureCelsius:
          ambientTemperatureCelsius ?? this.ambientTemperatureCelsius,
      useHvac: useHvac ?? this.useHvac,
      hvacConsumptionPercent:
          hvacConsumptionPercent ?? this.hvacConsumptionPercent,
      chargingCostPerKwh: chargingCostPerKwh ?? this.chargingCostPerKwh,
      maxChargingSessionMinutes:
          maxChargingSessionMinutes ?? this.maxChargingSessionMinutes,
    );
  }

  /// Default assumptions for trip planning
  static const TripAssumptions defaultAssumptions = TripAssumptions(
    averageSpeedKmh: 100.0,
    reserveBufferPercent: 15.0,
    ambientTemperatureCelsius: 20.0,
    useHvac: true,
    hvacConsumptionPercent: 10.0,
    chargingCostPerKwh: 0.30,
    maxChargingSessionMinutes: 60,
  );
}
