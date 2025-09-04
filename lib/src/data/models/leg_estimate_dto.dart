import 'package:isar/isar.dart';
import '../../domain/entities/leg_estimate.dart';
import 'route_polyline_dto.dart';
import 'charger_dto.dart';

part 'leg_estimate_dto.g.dart';

/// Data Transfer Object for LegEstimate
@collection
class LegEstimateDto {
  Id id = Isar.autoIncrement;

  @ignore
  late RouteLegDto leg;
  late double energyConsumedKwh;
  late double arrivalSoCPercent;
  late double departureSoCPercent;
  @ignore
  late ChargerDto? chargingStop;
  late double? energyToAddKwh;
  late int? chargingTimeMinutes;
  late double? chargingCost;
  late List<String> assumptions;

  LegEstimateDto();

  LegEstimateDto.fromEntity(LegEstimate legEstimate) {
    leg = RouteLegDto.fromEntity(legEstimate.leg);
    energyConsumedKwh = legEstimate.energyConsumedKwh;
    arrivalSoCPercent = legEstimate.arrivalSoCPercent;
    departureSoCPercent = legEstimate.departureSoCPercent;
    chargingStop = legEstimate.chargingStop != null
        ? ChargerDto.fromEntity(legEstimate.chargingStop!)
        : null;
    energyToAddKwh = legEstimate.energyToAddKwh;
    chargingTimeMinutes = legEstimate.chargingTimeMinutes;
    chargingCost = legEstimate.chargingCost;
    assumptions = legEstimate.assumptions;
  }

  LegEstimate toEntity() {
    return LegEstimate(
      leg: leg.toEntity(),
      energyConsumedKwh: energyConsumedKwh,
      arrivalSoCPercent: arrivalSoCPercent,
      departureSoCPercent: departureSoCPercent,
      chargingStop: chargingStop?.toEntity(),
      energyToAddKwh: energyToAddKwh,
      chargingTimeMinutes: chargingTimeMinutes,
      chargingCost: chargingCost,
      assumptions: assumptions,
    );
  }

  factory LegEstimateDto.fromJson(Map<String, dynamic> json) {
    return LegEstimateDto()
      ..leg = RouteLegDto.fromJson(json['leg'] as Map<String, dynamic>)
      ..energyConsumedKwh = (json['energyConsumedKwh'] as num).toDouble()
      ..arrivalSoCPercent = (json['arrivalSoCPercent'] as num).toDouble()
      ..departureSoCPercent = (json['departureSoCPercent'] as num).toDouble()
      ..chargingStop = json['chargingStop'] != null
          ? ChargerDto.fromJson(json['chargingStop'] as Map<String, dynamic>)
          : null
      ..energyToAddKwh = (json['energyToAddKwh'] as num?)?.toDouble()
      ..chargingTimeMinutes = json['chargingTimeMinutes'] as int?
      ..chargingCost = (json['chargingCost'] as num?)?.toDouble()
      ..assumptions = (json['assumptions'] as List<dynamic>)
          .map((e) => e as String)
          .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'leg': leg.toJson(),
      'energyConsumedKwh': energyConsumedKwh,
      'arrivalSoCPercent': arrivalSoCPercent,
      'departureSoCPercent': departureSoCPercent,
      'chargingStop': chargingStop?.toJson(),
      'energyToAddKwh': energyToAddKwh,
      'chargingTimeMinutes': chargingTimeMinutes,
      'chargingCost': chargingCost,
      'assumptions': assumptions,
    };
  }
}
