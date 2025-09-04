import 'package:dio/dio.dart';
import '../../models/route_polyline_dto.dart';
import '../../../core/errors/base_exception.dart';
import '../../../core/services/logger_service.dart';
// Domain failures handled by exceptions now

/// Client for Google Directions API
class GoogleDirectionsClient {
  final Dio _dio;
  final String _apiKey;
  final LoggerService _loggerService;

  GoogleDirectionsClient({
    required Dio dio,
    required String apiKey,
    required LoggerService loggerService,
  })  : _dio = dio,
        _apiKey = apiKey,
        _loggerService = loggerService;

  /// Gets a route between origin and destination
  Future<RoutePolylineDto> getRoute({
    required double originLat,
    required double originLng,
    required double destinationLat,
    required double destinationLng,
  }) async {
    try {
      final response = await _dio.get(
        'https://maps.googleapis.com/maps/api/directions/json',
        queryParameters: {
          'origin': '$originLat,$originLng',
          'destination': '$destinationLat,$destinationLng',
          'mode': 'driving',
          'avoid': 'tolls',
          'key': _apiKey,
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to get route: ${response.statusCode}');
      }

      final data = response.data as Map<String, dynamic>;

      if (data['status'] != 'OK') {
        throw BaseException(
          message: 'Directions API error: ${data['status']}',
          code: data['status'],
        );
      }

      return RoutePolylineDto.fromJson(data);
    } catch (e) {
      final exception = Exception('Failed to get route: ${e.toString()}');

      _loggerService.logHttpException(
        exception,
        method: 'GET',
        url: 'Google Directions API',
        requestData: {
          'originLat': originLat,
          'originLng': originLng,
          'destinationLat': destinationLat,
          'destinationLng': destinationLng,
        },
        stackTrace: StackTrace.current,
      );

      throw exception;
    }
  }

  /// Gets alternative routes between origin and destination
  Future<List<RoutePolylineDto>> getAlternativeRoutes({
    required double originLat,
    required double originLng,
    required double destinationLat,
    required double destinationLng,
    int maxAlternatives = 3,
  }) async {
    try {
      final response = await _dio.get(
        'https://maps.googleapis.com/maps/api/directions/json',
        queryParameters: {
          'origin': '$originLat,$originLng',
          'destination': '$destinationLat,$destinationLng',
          'mode': 'driving',
          'alternatives': 'true',
          'avoid': 'tolls',
          'key': _apiKey,
        },
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to get alternative routes: ${response.statusCode}');
      }

      final data = response.data as Map<String, dynamic>;

      if (data['status'] != 'OK') {
        throw BaseException(
          message: 'Directions API error: ${data['status']}',
          code: data['status'],
        );
      }

      final routes = data['routes'] as List<dynamic>;
      final alternativeRoutes = <RoutePolylineDto>[];

      for (int i = 0; i < routes.length && i < maxAlternatives; i++) {
        final routeData = {
          'routes': [routes[i]],
        };
        alternativeRoutes.add(RoutePolylineDto.fromJson(routeData));
      }

      return alternativeRoutes;
    } catch (e) {
      final exception =
          Exception('Failed to get alternative routes: ${e.toString()}');

      _loggerService.logHttpException(
        exception,
        method: 'GET',
        url: 'Google Directions API (alternatives)',
        requestData: {
          'originLat': originLat,
          'originLng': originLng,
          'destinationLat': destinationLat,
          'destinationLng': destinationLng,
          'maxAlternatives': maxAlternatives,
        },
        stackTrace: StackTrace.current,
      );

      throw exception;
    }
  }
}
