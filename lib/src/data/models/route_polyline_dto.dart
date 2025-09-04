import '../../domain/entities/route_polyline.dart';

/// Data Transfer Object for RoutePolyline
class RoutePolylineDto {
  final String encodedPolyline;
  final List<LatLngDto> waypoints;
  final double totalDistanceKm;
  final int totalDurationMinutes;
  final List<RouteLegDto> legs;

  RoutePolylineDto({
    required this.encodedPolyline,
    required this.waypoints,
    required this.totalDistanceKm,
    required this.totalDurationMinutes,
    required this.legs,
  });

  RoutePolylineDto.fromEntity(RoutePolyline route)
      : encodedPolyline = route.encodedPolyline,
        waypoints =
            route.waypoints.map((e) => LatLngDto.fromEntity(e)).toList(),
        totalDistanceKm = route.totalDistanceKm,
        totalDurationMinutes = route.totalDurationMinutes,
        legs = route.legs.map((e) => RouteLegDto.fromEntity(e)).toList();

  RoutePolyline toEntity() {
    return RoutePolyline(
      encodedPolyline: encodedPolyline,
      waypoints: waypoints.map((e) => e.toEntity()).toList(),
      totalDistanceKm: totalDistanceKm,
      totalDurationMinutes: totalDurationMinutes,
      legs: legs.map((e) => e.toEntity()).toList(),
    );
  }

  factory RoutePolylineDto.fromJson(Map<String, dynamic> json) {
    final routes = json['routes'] as List<dynamic>;
    if (routes.isEmpty) {
      throw Exception('No routes found in response');
    }

    final route = routes.first as Map<String, dynamic>;
    final legs = route['legs'] as List<dynamic>;
    final overviewPolyline = route['overview_polyline'] as Map<String, dynamic>;

    return RoutePolylineDto(
      encodedPolyline: overviewPolyline['points'] as String,
      waypoints: _parseWaypoints(route),
      totalDistanceKm: _calculateTotalDistance(legs),
      totalDurationMinutes: _calculateTotalDuration(legs),
      legs: legs.map((e) => RouteLegDto.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'encodedPolyline': encodedPolyline,
      'waypoints': waypoints.map((e) => e.toJson()).toList(),
      'totalDistanceKm': totalDistanceKm,
      'totalDurationMinutes': totalDurationMinutes,
      'legs': legs.map((e) => e.toJson()).toList(),
    };
  }

  static List<LatLngDto> _parseWaypoints(Map<String, dynamic> route) {
    final waypoints = <LatLngDto>[];

    // Add start location
    final startLocation =
        route['legs'][0]['start_location'] as Map<String, dynamic>;
    waypoints.add(LatLngDto(
      latitude: (startLocation['lat'] as num).toDouble(),
      longitude: (startLocation['lng'] as num).toDouble(),
    ));

    // Add end location
    final legs = route['legs'] as List<dynamic>;
    final endLocation = legs.last['end_location'] as Map<String, dynamic>;
    waypoints.add(LatLngDto(
      latitude: (endLocation['lat'] as num).toDouble(),
      longitude: (endLocation['lng'] as num).toDouble(),
    ));

    return waypoints;
  }

  static double _calculateTotalDistance(List<dynamic> legs) {
    double totalDistance = 0;
    for (final leg in legs) {
      final distance = leg['distance'] as Map<String, dynamic>;
      totalDistance +=
          (distance['value'] as num).toDouble() / 1000; // Convert meters to km
    }
    return totalDistance;
  }

  static int _calculateTotalDuration(List<dynamic> legs) {
    int totalDuration = 0;
    for (final leg in legs) {
      final duration = leg['duration'] as Map<String, dynamic>;
      totalDuration += duration['value'] as int; // Duration in seconds
    }
    return totalDuration ~/ 60; // Convert seconds to minutes
  }
}

/// Data Transfer Object for LatLng
class LatLngDto {
  final double latitude;
  final double longitude;

  LatLngDto({
    required this.latitude,
    required this.longitude,
  });

  LatLngDto.fromEntity(LatLng latLng)
      : latitude = latLng.latitude,
        longitude = latLng.longitude;

  LatLng toEntity() {
    return LatLng(
      latitude: latitude,
      longitude: longitude,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory LatLngDto.fromJson(Map<String, dynamic> json) {
    return LatLngDto(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }
}

/// Data Transfer Object for RouteLeg
class RouteLegDto {
  final LatLngDto startLocation;
  final LatLngDto endLocation;
  final double distanceKm;
  final int durationMinutes;
  final double? elevationGainMeters;
  final double? averageSpeedKmh;
  final String? instructions;

  RouteLegDto({
    required this.startLocation,
    required this.endLocation,
    required this.distanceKm,
    required this.durationMinutes,
    this.elevationGainMeters,
    this.averageSpeedKmh,
    this.instructions,
  });

  RouteLegDto.fromEntity(RouteLeg leg)
      : startLocation = LatLngDto.fromEntity(leg.startLocation),
        endLocation = LatLngDto.fromEntity(leg.endLocation),
        distanceKm = leg.distanceKm,
        durationMinutes = leg.durationMinutes,
        elevationGainMeters = leg.elevationGainMeters,
        averageSpeedKmh = leg.averageSpeedKmh,
        instructions = leg.instructions;

  RouteLeg toEntity() {
    return RouteLeg(
      startLocation: startLocation.toEntity(),
      endLocation: endLocation.toEntity(),
      distanceKm: distanceKm,
      durationMinutes: durationMinutes,
      elevationGainMeters: elevationGainMeters,
      averageSpeedKmh: averageSpeedKmh,
      instructions: instructions,
    );
  }

  factory RouteLegDto.fromJson(Map<String, dynamic> json) {
    final startLocation = json['start_location'] as Map<String, dynamic>;
    final endLocation = json['end_location'] as Map<String, dynamic>;
    final distance = json['distance'] as Map<String, dynamic>;
    final duration = json['duration'] as Map<String, dynamic>;

    return RouteLegDto(
      startLocation: LatLngDto(
        latitude: (startLocation['lat'] as num).toDouble(),
        longitude: (startLocation['lng'] as num).toDouble(),
      ),
      endLocation: LatLngDto(
        latitude: (endLocation['lat'] as num).toDouble(),
        longitude: (endLocation['lng'] as num).toDouble(),
      ),
      distanceKm:
          (distance['value'] as num).toDouble() / 1000, // Convert meters to km
      durationMinutes:
          (duration['value'] as int) ~/ 60, // Convert seconds to minutes
      elevationGainMeters: _parseElevationGain(json),
      averageSpeedKmh: _calculateAverageSpeed(json),
      instructions: _parseInstructions(json),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start_location': {
        'lat': startLocation.latitude,
        'lng': startLocation.longitude,
      },
      'end_location': {
        'lat': endLocation.latitude,
        'lng': endLocation.longitude,
      },
      'distance': {
        'value': (distanceKm * 1000).round(), // Convert km to meters
      },
      'duration': {
        'value': durationMinutes * 60, // Convert minutes to seconds
      },
      'elevation_gain_meters': elevationGainMeters,
      'average_speed_kmh': averageSpeedKmh,
      'instructions': instructions,
    };
  }

  static double? _parseElevationGain(Map<String, dynamic> json) {
    // Google Directions API doesn't provide elevation data by default
    // This would need to be obtained from a separate elevation service
    return null;
  }

  static double? _calculateAverageSpeed(Map<String, dynamic> json) {
    final distance = json['distance'] as Map<String, dynamic>;
    final duration = json['duration'] as Map<String, dynamic>;

    final distanceKm = (distance['value'] as num).toDouble() / 1000;
    final durationHours = (duration['value'] as int) / 3600;

    if (durationHours > 0) {
      return distanceKm / durationHours;
    }

    return null;
  }

  static String? _parseInstructions(Map<String, dynamic> json) {
    final steps = json['steps'] as List<dynamic>?;
    if (steps != null && steps.isNotEmpty) {
      final firstStep = steps.first as Map<String, dynamic>;
      return firstStep['html_instructions'] as String?;
    }
    return null;
  }
}
