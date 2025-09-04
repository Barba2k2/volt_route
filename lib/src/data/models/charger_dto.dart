import '../../domain/entities/charger.dart';
import '../../domain/entities/vehicle.dart';

/// Data Transfer Object for Charger
class ChargerDto {
  final String id;
  final String name;
  final String placeId;
  final double latitude;
  final double longitude;
  final String? address;
  final String? vicinity;
  final List<String>? availableConnectors;
  final double? maxPowerKw;
  final bool isOpenNow;
  final double? rating;
  final int? userRatingsTotal;
  final List<String>? amenities;
  final String compatibility;

  ChargerDto({
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

  ChargerDto.fromEntity(Charger charger)
      : id = charger.id,
        name = charger.name,
        placeId = charger.placeId,
        latitude = charger.latitude,
        longitude = charger.longitude,
        address = charger.address,
        vicinity = charger.vicinity,
        availableConnectors =
            charger.availableConnectors?.map((e) => e.name).toList(),
        maxPowerKw = charger.maxPowerKw,
        isOpenNow = charger.isOpenNow,
        rating = charger.rating,
        userRatingsTotal = charger.userRatingsTotal,
        amenities = charger.amenities,
        compatibility = charger.compatibility.name;

  Charger toEntity() {
    return Charger(
      id: id,
      name: name,
      placeId: placeId,
      latitude: latitude,
      longitude: longitude,
      address: address,
      vicinity: vicinity,
      availableConnectors: availableConnectors
          ?.map(
              (e) => ConnectorType.values.firstWhere((type) => type.name == e))
          .toList(),
      maxPowerKw: maxPowerKw,
      isOpenNow: isOpenNow,
      rating: rating,
      userRatingsTotal: userRatingsTotal,
      amenities: amenities,
      compatibility: ChargerCompatibility.values.firstWhere(
        (type) => type.name == compatibility,
      ),
    );
  }

  factory ChargerDto.fromJson(Map<String, dynamic> json) {
    return ChargerDto(
      id: json['place_id'] as String,
      name: json['name'] as String,
      placeId: json['place_id'] as String,
      latitude: (json['geometry']['location']['lat'] as num).toDouble(),
      longitude: (json['geometry']['location']['lng'] as num).toDouble(),
      address: json['formatted_address'] as String?,
      vicinity: json['vicinity'] as String?,
      availableConnectors: _parseConnectors(json),
      maxPowerKw: _parseMaxPower(json),
      isOpenNow: json['opening_hours']?['open_now'] as bool? ?? false,
      rating: (json['rating'] as num?)?.toDouble(),
      userRatingsTotal: json['user_ratings_total'] as int?,
      amenities: _parseAmenities(json),
      compatibility: 'unknown',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'place_id': placeId,
      'geometry': {
        'location': {
          'lat': latitude,
          'lng': longitude,
        },
      },
      'formatted_address': address,
      'vicinity': vicinity,
      'availableConnectors': availableConnectors,
      'maxPowerKw': maxPowerKw,
      'opening_hours': {
        'open_now': isOpenNow,
      },
      'rating': rating,
      'user_ratings_total': userRatingsTotal,
      'amenities': amenities,
      'compatibility': compatibility,
    };
  }

  static List<String>? _parseConnectors(Map<String, dynamic> json) {
    // Google Places API doesn't always provide connector information
    // This would need to be inferred from other data or external sources
    return null;
  }

  static double? _parseMaxPower(Map<String, dynamic> json) {
    // Google Places API doesn't always provide power information
    // This would need to be inferred from other data or external sources
    return null;
  }

  static List<String>? _parseAmenities(Map<String, dynamic> json) {
    // Parse amenities from Google Places API response
    final amenities = <String>[];

    if (json['types'] != null) {
      final types = json['types'] as List<dynamic>;
      for (final type in types) {
        switch (type) {
          case 'restaurant':
            amenities.add('Restaurant');
            break;
          case 'gas_station':
            amenities.add('Gas Station');
            break;
          case 'shopping_mall':
            amenities.add('Shopping');
            break;
          case 'lodging':
            amenities.add('Hotel');
            break;
        }
      }
    }

    return amenities.isNotEmpty ? amenities : null;
  }
}
