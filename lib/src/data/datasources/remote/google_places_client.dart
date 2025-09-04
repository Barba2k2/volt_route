import 'package:dio/dio.dart';
import '../../../domain/entities/route_polyline.dart';
import '../../models/charger_dto.dart';
import '../../../domain/entities/vehicle.dart';
import '../../../core/services/logger_service.dart';

/// Client for Google Places API
class GooglePlacesClient {
  final Dio _dio;
  final String _apiKey;
  final LoggerService _loggerService;

  GooglePlacesClient({
    required Dio dio,
    required String apiKey,
    required LoggerService loggerService,
  })  : _dio = dio,
        _apiKey = apiKey,
        _loggerService = loggerService;

  /// Gets charging stations along a route
  Future<List<ChargerDto>> getChargersAlongRoute({
    required RoutePolyline route,
    required Vehicle vehicle,
    double searchRadiusKm = 5.0,
  }) async {
    try {
      final allChargers = <ChargerDto>[];
      final processedPlaceIds = <String>{};

      // Segment the route into windows for searching
      final searchWindows = _segmentRouteIntoWindows(route, searchRadiusKm);

      for (final window in searchWindows) {
        final chargers = await _searchChargersInWindow(
          latitude: window.latitude,
          longitude: window.longitude,
          radius: (searchRadiusKm * 1000).round(), // Convert km to meters
        );

        // Filter out duplicates by place_id
        for (final charger in chargers) {
          if (!processedPlaceIds.contains(charger.placeId)) {
            processedPlaceIds.add(charger.placeId);
            allChargers.add(charger);
          }
        }
      }

      return allChargers;
    } catch (e) {
      final exception =
          Exception('Failed to get chargers along route: ${e.toString()}');

      _loggerService.logHttpException(
        exception,
        method: 'GET',
        url: 'Google Places API',
        requestData: {
          'routeDistanceKm': route.totalDistanceKm,
          'vehicleId': vehicle.id,
          'searchRadiusKm': searchRadiusKm,
        },
        stackTrace: StackTrace.current,
      );

      throw exception;
    }
  }

  /// Gets charging stations near a specific location
  Future<List<ChargerDto>> getChargersNearLocation({
    required double latitude,
    required double longitude,
    double radiusKm = 10.0,
  }) async {
    try {
      return await _searchChargersInWindow(
        latitude: latitude,
        longitude: longitude,
        radius: (radiusKm * 1000).round(), // Convert km to meters
      );
    } catch (e) {
      final exception =
          Exception('Failed to get chargers near location: ${e.toString()}');

      _loggerService.logHttpException(
        exception,
        method: 'GET',
        url: 'Google Places API (near location)',
        requestData: {
          'latitude': latitude,
          'longitude': longitude,
          'radiusKm': radiusKm,
        },
        stackTrace: StackTrace.current,
      );

      throw exception;
    }
  }

  /// Gets detailed information about a specific charger
  Future<ChargerDto> getChargerDetails({
    required String placeId,
  }) async {
    try {
      final response = await _dio.get(
        'https://maps.googleapis.com/maps/api/place/details/json',
        queryParameters: {
          'place_id': placeId,
          'fields':
              'place_id,name,formatted_address,geometry,opening_hours,rating,user_ratings_total,types',
          'key': _apiKey,
        },
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to get charger details: ${response.statusCode}');
      }

      final data = response.data as Map<String, dynamic>;
      final result = data['result'] as Map<String, dynamic>;

      return ChargerDto.fromJson(result);
    } catch (e) {
      throw Exception('Failed to get charger details: ${e.toString()}');
    }
  }

  /// Searches for charging stations in a specific window
  Future<List<ChargerDto>> _searchChargersInWindow({
    required double latitude,
    required double longitude,
    required int radius,
  }) async {
    try {
      final response = await _dio.get(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json',
        queryParameters: {
          'location': '$latitude,$longitude',
          'radius': radius,
          'type': 'electric_vehicle_charging_station',
          'key': _apiKey,
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to search chargers: ${response.statusCode}');
      }

      final data = response.data as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>;

      return results
          .map((result) => ChargerDto.fromJson(result as Map<String, dynamic>))
          .toList();
    } catch (e) {
      final exception = Exception('Failed to search chargers: ${e.toString()}');

      _loggerService.logHttpException(
        exception,
        method: 'GET',
        url: 'Google Places API (search)',
        requestData: {
          'latitude': latitude,
          'longitude': longitude,
          'radius': radius,
        },
        stackTrace: StackTrace.current,
      );

      throw exception;
    }
  }

  /// Segments a route into search windows
  List<LatLng> _segmentRouteIntoWindows(
    RoutePolyline route,
    double searchRadiusKm,
  ) {
    final windows = <LatLng>[];
    final windowDistance = searchRadiusKm * 2; // Overlap windows by 50%

    // Add start and end points
    windows.add(LatLng(
      latitude: route.waypoints.first.latitude,
      longitude: route.waypoints.first.longitude,
    ));
    windows.add(LatLng(
      latitude: route.waypoints.last.latitude,
      longitude: route.waypoints.last.longitude,
    ));

    // Add intermediate points along the route
    double accumulatedDistance = 0;
    for (final leg in route.legs) {
      accumulatedDistance += leg.distanceKm;

      if (accumulatedDistance >= windowDistance) {
        windows.add(LatLng(
          latitude: leg.endLocation.latitude,
          longitude: leg.endLocation.longitude,
        ));
        accumulatedDistance = 0;
      }
    }

    return windows;
  }
}

/// Simple LatLng class for internal use
class LatLng {
  final double latitude;
  final double longitude;

  LatLng({
    required this.latitude,
    required this.longitude,
  });
}
