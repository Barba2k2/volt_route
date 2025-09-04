import 'package:result_dart/result_dart.dart';
import '../entities/route_polyline.dart';

/// Abstract repository for routing operations
abstract class RoutingRepository {
  /// Gets a route between origin and destination
  Future<Result<RoutePolyline>> getRoute({
    required double originLat,
    required double originLng,
    required double destinationLat,
    required double destinationLng,
  });

  /// Gets alternative routes between origin and destination
  Future<Result<List<RoutePolyline>>> getAlternativeRoutes({
    required double originLat,
    required double originLng,
    required double destinationLat,
    required double destinationLng,
    int maxAlternatives = 3,
  });
}
