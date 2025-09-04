import 'package:equatable/equatable.dart';
import 'vehicle.dart';

/// Represents a charging station
class Charger extends Equatable {
  final String id;
  final String name;
  final String placeId;
  final double latitude;
  final double longitude;
  final String? address;
  final String? vicinity;
  final List<ConnectorType>? availableConnectors;
  final double? maxPowerKw;
  final bool isOpenNow;
  final double? rating;
  final int? userRatingsTotal;
  final List<String>? amenities;
  final ChargerCompatibility compatibility;

  const Charger({
    required this.id,
    required this.name,
    required this.placeId,
    required this.latitude,
    required this.longitude,
    this.address,
    this.vicinity,
    this.availableConnectors,
    this.maxPowerKw,
    required this.isOpenNow,
    this.rating,
    this.userRatingsTotal,
    this.amenities,
    required this.compatibility,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        placeId,
        latitude,
        longitude,
        address,
        vicinity,
        availableConnectors,
        maxPowerKw,
        isOpenNow,
        rating,
        userRatingsTotal,
        amenities,
        compatibility,
      ];

  Charger copyWith({
    String? id,
    String? name,
    String? placeId,
    double? latitude,
    double? longitude,
    String? address,
    String? vicinity,
    List<ConnectorType>? availableConnectors,
    double? maxPowerKw,
    bool? isOpenNow,
    double? rating,
    int? userRatingsTotal,
    List<String>? amenities,
    ChargerCompatibility? compatibility,
  }) {
    return Charger(
      id: id ?? this.id,
      name: name ?? this.name,
      placeId: placeId ?? this.placeId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      vicinity: vicinity ?? this.vicinity,
      availableConnectors: availableConnectors ?? this.availableConnectors,
      maxPowerKw: maxPowerKw ?? this.maxPowerKw,
      isOpenNow: isOpenNow ?? this.isOpenNow,
      rating: rating ?? this.rating,
      userRatingsTotal: userRatingsTotal ?? this.userRatingsTotal,
      amenities: amenities ?? this.amenities,
      compatibility: compatibility ?? this.compatibility,
    );
  }
}

/// Indicates how compatible a charger is with a specific vehicle
enum ChargerCompatibility {
  compatible,
  assumedCompatible,
  incompatible,
  unknown,
}

extension ChargerCompatibilityExtension on ChargerCompatibility {
  String get displayName {
    switch (this) {
      case ChargerCompatibility.compatible:
        return 'Compatible';
      case ChargerCompatibility.assumedCompatible:
        return 'Likely Compatible';
      case ChargerCompatibility.incompatible:
        return 'Incompatible';
      case ChargerCompatibility.unknown:
        return 'Unknown';
    }
  }

  String get description {
    switch (this) {
      case ChargerCompatibility.compatible:
        return 'Confirmed connector compatibility';
      case ChargerCompatibility.assumedCompatible:
        return 'Compatibility assumed based on brand/location';
      case ChargerCompatibility.incompatible:
        return 'No compatible connectors available';
      case ChargerCompatibility.unknown:
        return 'Connector information not available';
    }
  }
}
