import 'package:equatable/equatable.dart';

/// Represents a route polyline with waypoints and metadata
class RoutePolyline extends Equatable {
  final String encodedPolyline;
  final List<LatLng> waypoints;
  final double totalDistanceKm;
  final int totalDurationMinutes;
  final List<RouteLeg> legs;

  const RoutePolyline({
    required this.encodedPolyline,
    required this.waypoints,
    required this.totalDistanceKm,
    required this.totalDurationMinutes,
    required this.legs,
  });

  @override
  List<Object?> get props => [
        encodedPolyline,
        waypoints,
        totalDistanceKm,
        totalDurationMinutes,
        legs,
      ];

  RoutePolyline copyWith({
    String? encodedPolyline,
    List<LatLng>? waypoints,
    double? totalDistanceKm,
    int? totalDurationMinutes,
    List<RouteLeg>? legs,
  }) {
    return RoutePolyline(
      encodedPolyline: encodedPolyline ?? this.encodedPolyline,
      waypoints: waypoints ?? this.waypoints,
      totalDistanceKm: totalDistanceKm ?? this.totalDistanceKm,
      totalDurationMinutes: totalDurationMinutes ?? this.totalDurationMinutes,
      legs: legs ?? this.legs,
    );
  }
}

/// Represents a coordinate point
class LatLng extends Equatable {
  final double latitude;
  final double longitude;

  const LatLng({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [latitude, longitude];

  LatLng copyWith({
    double? latitude,
    double? longitude,
  }) {
    return LatLng(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}

/// Represents a segment of the route
class RouteLeg extends Equatable {
  final LatLng startLocation;
  final LatLng endLocation;
  final double distanceKm;
  final int durationMinutes;
  final double? elevationGainMeters;
  final double? averageSpeedKmh;
  final String? instructions;

  const RouteLeg({
    required this.startLocation,
    required this.endLocation,
    required this.distanceKm,
    required this.durationMinutes,
    this.elevationGainMeters,
    this.averageSpeedKmh,
    this.instructions,
  });

  @override
  List<Object?> get props => [
        startLocation,
        endLocation,
        distanceKm,
        durationMinutes,
        elevationGainMeters,
        averageSpeedKmh,
        instructions,
      ];

  RouteLeg copyWith({
    LatLng? startLocation,
    LatLng? endLocation,
    double? distanceKm,
    int? durationMinutes,
    double? elevationGainMeters,
    double? averageSpeedKmh,
    String? instructions,
  }) {
    return RouteLeg(
      startLocation: startLocation ?? this.startLocation,
      endLocation: endLocation ?? this.endLocation,
      distanceKm: distanceKm ?? this.distanceKm,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      elevationGainMeters: elevationGainMeters ?? this.elevationGainMeters,
      averageSpeedKmh: averageSpeedKmh ?? this.averageSpeedKmh,
      instructions: instructions ?? this.instructions,
    );
  }
}
