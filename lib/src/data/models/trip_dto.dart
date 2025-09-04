import 'package:isar/isar.dart';
import '../../domain/entities/trip.dart';
import '../../domain/entities/route_polyline.dart';
import 'vehicle_dto.dart';
import 'route_polyline_dto.dart';
import 'leg_estimate_dto.dart';

part 'trip_dto.g.dart';

/// Data Transfer Object for Trip
@collection
class TripDto {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String tripId;

  late String name;
  late double originLat;
  late double originLng;
  late double destinationLat;
  late double destinationLng;
  @ignore
  late VehicleDto vehicle;
  @ignore
  late RoutePolylineDto route;
  @ignore
  late List<LegEstimateDto> legEstimates;
  @ignore
  late TripAssumptionsDto assumptions;
  late DateTime createdAt;
  late DateTime? lastModified;
  late bool isSaved;
  late String? userId;

  TripDto();

  TripDto.fromEntity(Trip trip) {
    tripId = trip.id;
    name = trip.name;
    originLat = trip.origin.latitude;
    originLng = trip.origin.longitude;
    destinationLat = trip.destination.latitude;
    destinationLng = trip.destination.longitude;
    vehicle = VehicleDto.fromEntity(trip.vehicle);
    route = RoutePolylineDto.fromEntity(trip.route);
    legEstimates =
        trip.legEstimates.map((e) => LegEstimateDto.fromEntity(e)).toList();
    assumptions = TripAssumptionsDto.fromEntity(trip.assumptions);
    createdAt = trip.createdAt;
    lastModified = trip.lastModified;
    isSaved = trip.isSaved;
    userId = trip.userId;
  }

  Trip toEntity() {
    return Trip(
      id: tripId,
      name: name,
      origin: LatLng(latitude: originLat, longitude: originLng),
      destination: LatLng(latitude: destinationLat, longitude: destinationLng),
      vehicle: vehicle.toEntity(),
      route: route.toEntity(),
      legEstimates: legEstimates.map((e) => e.toEntity()).toList(),
      assumptions: assumptions.toEntity(),
      createdAt: createdAt,
      lastModified: lastModified,
      isSaved: isSaved,
      userId: userId,
    );
  }

  factory TripDto.fromJson(Map<String, dynamic> json) {
    return TripDto()
      ..tripId = json['id'] as String
      ..name = json['name'] as String
      ..originLat = (json['origin']['latitude'] as num).toDouble()
      ..originLng = (json['origin']['longitude'] as num).toDouble()
      ..destinationLat = (json['destination']['latitude'] as num).toDouble()
      ..destinationLng = (json['destination']['longitude'] as num).toDouble()
      ..vehicle = VehicleDto.fromJson(json['vehicle'] as Map<String, dynamic>)
      ..route = RoutePolylineDto.fromJson(json['route'] as Map<String, dynamic>)
      ..legEstimates = (json['legEstimates'] as List<dynamic>)
          .map((e) => LegEstimateDto.fromJson(e as Map<String, dynamic>))
          .toList()
      ..assumptions = TripAssumptionsDto.fromJson(
          json['assumptions'] as Map<String, dynamic>)
      ..createdAt = DateTime.parse(json['createdAt'] as String)
      ..lastModified = json['lastModified'] != null
          ? DateTime.parse(json['lastModified'] as String)
          : null
      ..isSaved = json['isSaved'] as bool
      ..userId = json['userId'] as String?;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': tripId,
      'name': name,
      'origin': {
        'latitude': originLat,
        'longitude': originLng,
      },
      'destination': {
        'latitude': destinationLat,
        'longitude': destinationLng,
      },
      'vehicle': vehicle.toJson(),
      'route': route.toJson(),
      'legEstimates': legEstimates.map((e) => e.toJson()).toList(),
      'assumptions': assumptions.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'lastModified': lastModified?.toIso8601String(),
      'isSaved': isSaved,
      'userId': userId,
    };
  }
}

/// Data Transfer Object for TripAssumptions
@embedded
class TripAssumptionsDto {
  late double averageSpeedKmh;
  late double reserveBufferPercent;
  late double ambientTemperatureCelsius;
  late bool useHvac;
  late double hvacConsumptionPercent;
  late double chargingCostPerKwh;
  late int maxChargingSessionMinutes;

  TripAssumptionsDto();

  TripAssumptionsDto.fromEntity(TripAssumptions assumptions) {
    averageSpeedKmh = assumptions.averageSpeedKmh;
    reserveBufferPercent = assumptions.reserveBufferPercent;
    ambientTemperatureCelsius = assumptions.ambientTemperatureCelsius;
    useHvac = assumptions.useHvac;
    hvacConsumptionPercent = assumptions.hvacConsumptionPercent;
    chargingCostPerKwh = assumptions.chargingCostPerKwh;
    maxChargingSessionMinutes = assumptions.maxChargingSessionMinutes;
  }

  TripAssumptions toEntity() {
    return TripAssumptions(
      averageSpeedKmh: averageSpeedKmh,
      reserveBufferPercent: reserveBufferPercent,
      ambientTemperatureCelsius: ambientTemperatureCelsius,
      useHvac: useHvac,
      hvacConsumptionPercent: hvacConsumptionPercent,
      chargingCostPerKwh: chargingCostPerKwh,
      maxChargingSessionMinutes: maxChargingSessionMinutes,
    );
  }

  factory TripAssumptionsDto.fromJson(Map<String, dynamic> json) {
    return TripAssumptionsDto()
      ..averageSpeedKmh = (json['averageSpeedKmh'] as num).toDouble()
      ..reserveBufferPercent = (json['reserveBufferPercent'] as num).toDouble()
      ..ambientTemperatureCelsius =
          (json['ambientTemperatureCelsius'] as num).toDouble()
      ..useHvac = json['useHvac'] as bool
      ..hvacConsumptionPercent =
          (json['hvacConsumptionPercent'] as num).toDouble()
      ..chargingCostPerKwh = (json['chargingCostPerKwh'] as num).toDouble()
      ..maxChargingSessionMinutes = json['maxChargingSessionMinutes'] as int;
  }

  Map<String, dynamic> toJson() {
    return {
      'averageSpeedKmh': averageSpeedKmh,
      'reserveBufferPercent': reserveBufferPercent,
      'ambientTemperatureCelsius': ambientTemperatureCelsius,
      'useHvac': useHvac,
      'hvacConsumptionPercent': hvacConsumptionPercent,
      'chargingCostPerKwh': chargingCostPerKwh,
      'maxChargingSessionMinutes': maxChargingSessionMinutes,
    };
  }
}
