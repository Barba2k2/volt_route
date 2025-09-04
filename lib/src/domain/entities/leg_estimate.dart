import 'package:equatable/equatable.dart';
import 'route_polyline.dart';
import 'charger.dart';

/// Represents energy and SoC estimates for a route leg
class LegEstimate extends Equatable {
  final RouteLeg leg;
  final double energyConsumedKwh;
  final double arrivalSoCPercent;
  final double departureSoCPercent;
  final Charger? chargingStop;
  final double? energyToAddKwh;
  final int? chargingTimeMinutes;
  final double? chargingCost;
  final List<String> assumptions;

  const LegEstimate({
    required this.leg,
    required this.energyConsumedKwh,
    required this.arrivalSoCPercent,
    required this.departureSoCPercent,
    this.chargingStop,
    this.energyToAddKwh,
    this.chargingTimeMinutes,
    this.chargingCost,
    required this.assumptions,
  });

  @override
  List<Object?> get props => [
        leg,
        energyConsumedKwh,
        arrivalSoCPercent,
        departureSoCPercent,
        chargingStop,
        energyToAddKwh,
        chargingTimeMinutes,
        chargingCost,
        assumptions,
      ];

  LegEstimate copyWith({
    RouteLeg? leg,
    double? energyConsumedKwh,
    double? arrivalSoCPercent,
    double? departureSoCPercent,
    Charger? chargingStop,
    double? energyToAddKwh,
    int? chargingTimeMinutes,
    double? chargingCost,
    List<String>? assumptions,
  }) {
    return LegEstimate(
      leg: leg ?? this.leg,
      energyConsumedKwh: energyConsumedKwh ?? this.energyConsumedKwh,
      arrivalSoCPercent: arrivalSoCPercent ?? this.arrivalSoCPercent,
      departureSoCPercent: departureSoCPercent ?? this.departureSoCPercent,
      chargingStop: chargingStop ?? this.chargingStop,
      energyToAddKwh: energyToAddKwh ?? this.energyToAddKwh,
      chargingTimeMinutes: chargingTimeMinutes ?? this.chargingTimeMinutes,
      chargingCost: chargingCost ?? this.chargingCost,
      assumptions: assumptions ?? this.assumptions,
    );
  }
}
