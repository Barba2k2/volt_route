import 'package:equatable/equatable.dart';

/// Represents an electric vehicle with its specifications
class Vehicle extends Equatable {
  final String id;
  final String name;
  final String brand;
  final String model;
  final int year;
  final double usableBatteryKwh;
  final double efficiencyWhPerKm;
  final List<ConnectorType> supportedConnectors;
  final double maxChargingPowerKw;
  final double maxDcChargingPowerKw;

  const Vehicle({
    required this.id,
    required this.name,
    required this.brand,
    required this.model,
    required this.year,
    required this.usableBatteryKwh,
    required this.efficiencyWhPerKm,
    required this.supportedConnectors,
    required this.maxChargingPowerKw,
    required this.maxDcChargingPowerKw,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        brand,
        model,
        year,
        usableBatteryKwh,
        efficiencyWhPerKm,
        supportedConnectors,
        maxChargingPowerKw,
        maxDcChargingPowerKw,
      ];

  Vehicle copyWith({
    String? id,
    String? name,
    String? brand,
    String? model,
    int? year,
    double? usableBatteryKwh,
    double? efficiencyWhPerKm,
    List<ConnectorType>? supportedConnectors,
    double? maxChargingPowerKw,
    double? maxDcChargingPowerKw,
  }) {
    return Vehicle(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      year: year ?? this.year,
      usableBatteryKwh: usableBatteryKwh ?? this.usableBatteryKwh,
      efficiencyWhPerKm: efficiencyWhPerKm ?? this.efficiencyWhPerKm,
      supportedConnectors: supportedConnectors ?? this.supportedConnectors,
      maxChargingPowerKw: maxChargingPowerKw ?? this.maxChargingPowerKw,
      maxDcChargingPowerKw: maxDcChargingPowerKw ?? this.maxDcChargingPowerKw,
    );
  }
}

/// Types of charging connectors
enum ConnectorType {
  ccs2,
  type2,
  chademo,
  tesla,
  type1,
  gbt,
}

extension ConnectorTypeExtension on ConnectorType {
  String get displayName {
    switch (this) {
      case ConnectorType.ccs2:
        return 'CCS2';
      case ConnectorType.type2:
        return 'Type 2';
      case ConnectorType.chademo:
        return 'CHAdeMO';
      case ConnectorType.tesla:
        return 'Tesla';
      case ConnectorType.type1:
        return 'Type 1';
      case ConnectorType.gbt:
        return 'GB/T';
    }
  }

  String get description {
    switch (this) {
      case ConnectorType.ccs2:
        return 'Combined Charging System 2 (DC Fast)';
      case ConnectorType.type2:
        return 'Type 2 (AC)';
      case ConnectorType.chademo:
        return 'CHAdeMO (DC Fast)';
      case ConnectorType.tesla:
        return 'Tesla Supercharger';
      case ConnectorType.type1:
        return 'Type 1 (AC)';
      case ConnectorType.gbt:
        return 'GB/T (Chinese Standard)';
    }
  }
}
