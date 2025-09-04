import 'package:equatable/equatable.dart';

/// Trip statistics for a user
class TripStatistics extends Equatable {
  final int totalTrips;
  final double totalDistanceKm;
  final double totalEnergyConsumedKwh;
  final int totalChargingTimeMinutes;
  final double totalCost;
  final double averageTripDistanceKm;
  final double averageEnergyEfficiencyKwhPer100km;

  const TripStatistics({
    required this.totalTrips,
    required this.totalDistanceKm,
    required this.totalEnergyConsumedKwh,
    required this.totalChargingTimeMinutes,
    required this.totalCost,
    required this.averageTripDistanceKm,
    required this.averageEnergyEfficiencyKwhPer100km,
  });

  @override
  List<Object?> get props => [
        totalTrips,
        totalDistanceKm,
        totalEnergyConsumedKwh,
        totalChargingTimeMinutes,
        totalCost,
        averageTripDistanceKm,
        averageEnergyEfficiencyKwhPer100km,
      ];
}
