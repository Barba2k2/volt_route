import 'package:result_dart/result_dart.dart';
import '../../domain/repositories/routing_repository.dart';
import '../../domain/entities/route_polyline.dart';
import '../datasources/remote/google_directions_client.dart';
import '../../core/errors/base_exception.dart';
import '../../core/services/logger_service.dart';

/// Implementation of RoutingRepository using Google Directions API
class RoutingRepositoryImpl implements RoutingRepository {
  final GoogleDirectionsClient _directionsClient;
  final LoggerService _loggerService;

  const RoutingRepositoryImpl({
    required GoogleDirectionsClient directionsClient,
    required LoggerService loggerService,
  })  : _directionsClient = directionsClient,
        _loggerService = loggerService;

  @override
  Future<Result<RoutePolyline>> getRoute({
    required double originLat,
    required double originLng,
    required double destinationLat,
    required double destinationLng,
  }) async {
    try {
      final routeDto = await _directionsClient.getRoute(
        originLat: originLat,
        originLng: originLng,
        destinationLat: destinationLat,
        destinationLng: destinationLng,
      );

      final route = routeDto.toEntity();
      return Success(route);
    } on Exception catch (e) {
      _loggerService.logHttpException(
        e,
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
      return Failure(e);
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

      return Failure(exception);
    }
  }

  @override
  Future<Result<List<RoutePolyline>>> getAlternativeRoutes({
    required double originLat,
    required double originLng,
    required double destinationLat,
    required double destinationLng,
    int maxAlternatives = 3,
  }) async {
    try {
      final routeDtos = await _directionsClient.getAlternativeRoutes(
        originLat: originLat,
        originLng: originLng,
        destinationLat: destinationLat,
        destinationLng: destinationLng,
        maxAlternatives: maxAlternatives,
      );

      final routes = routeDtos.map((dto) => dto.toEntity()).toList();
      return Success(routes);
    } on Exception catch (e) {
      _loggerService.logHttpException(
        e,
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
      return Failure(e);
    } catch (e) {
      final exception = BaseException(
        message: 'Failed to get alternative routes: ${e.toString()}',
        data: e,
      );

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

      return Failure(exception);
    }
  }
}
