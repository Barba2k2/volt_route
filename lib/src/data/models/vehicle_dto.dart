import 'package:isar/isar.dart';
import '../../domain/entities/vehicle.dart';

part 'vehicle_dto.g.dart';

/// Data Transfer Object for Vehicle
@collection
class VehicleDto {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String vehicleId;

  late String name;
  late String brand;
  late String model;
  late int year;
  late double usableBatteryKwh;
  late double efficiencyWhPerKm;
  late List<String> supportedConnectors;
  late double maxChargingPowerKw;
  late double maxDcChargingPowerKw;

  VehicleDto();

  VehicleDto.fromEntity(Vehicle vehicle) {
    vehicleId = vehicle.id;
    name = vehicle.name;
    brand = vehicle.brand;
    model = vehicle.model;
    year = vehicle.year;
    usableBatteryKwh = vehicle.usableBatteryKwh;
    efficiencyWhPerKm = vehicle.efficiencyWhPerKm;
    supportedConnectors =
        vehicle.supportedConnectors.map((e) => e.name).toList();
    maxChargingPowerKw = vehicle.maxChargingPowerKw;
    maxDcChargingPowerKw = vehicle.maxDcChargingPowerKw;
  }

  Vehicle toEntity() {
    return Vehicle(
      id: vehicleId,
      name: name,
      brand: brand,
      model: model,
      year: year,
      usableBatteryKwh: usableBatteryKwh,
      efficiencyWhPerKm: efficiencyWhPerKm,
      supportedConnectors: supportedConnectors
          .map((e) => ConnectorType.values.firstWhere((type) => type.name == e))
          .toList(),
      maxChargingPowerKw: maxChargingPowerKw,
      maxDcChargingPowerKw: maxDcChargingPowerKw,
    );
  }

  factory VehicleDto.fromJson(Map<String, dynamic> json) {
    return VehicleDto()
      ..vehicleId = json['id'] as String
      ..name = json['name'] as String
      ..brand = json['brand'] as String
      ..model = json['model'] as String
      ..year = json['year'] as int
      ..usableBatteryKwh = (json['usableBatteryKwh'] as num).toDouble()
      ..efficiencyWhPerKm = (json['efficiencyWhPerKm'] as num).toDouble()
      ..supportedConnectors = (json['supportedConnectors'] as List<dynamic>)
          .map((e) => e as String)
          .toList()
      ..maxChargingPowerKw = (json['maxChargingPowerKw'] as num).toDouble()
      ..maxDcChargingPowerKw = (json['maxDcChargingPowerKw'] as num).toDouble();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': vehicleId,
      'name': name,
      'brand': brand,
      'model': model,
      'year': year,
      'usableBatteryKwh': usableBatteryKwh,
      'efficiencyWhPerKm': efficiencyWhPerKm,
      'supportedConnectors': supportedConnectors,
      'maxChargingPowerKw': maxChargingPowerKw,
      'maxDcChargingPowerKw': maxDcChargingPowerKw,
    };
  }
}
