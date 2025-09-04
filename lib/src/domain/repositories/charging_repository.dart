import 'package:result_dart/result_dart.dart';
import '../entities/charger.dart';
import '../entities/route_polyline.dart';
import '../entities/vehicle.dart';

/// Abstract repository for charging station operations
abstract class ChargingRepository {
  /// Gets charging stations along a route for a specific vehicle
  Future<Result<List<Charger>>> getChargersAlongRoute({
    required RoutePolyline route,
    required Vehicle vehicle,
    double searchRadiusKm = 5.0,
  });

  /// Gets charging stations near a specific location
  Future<Result<List<Charger>>> getChargersNearLocation({
    required double latitude,
    required double longitude,
    required Vehicle vehicle,
    double radiusKm = 10.0,
  });

  /// Gets detailed information about a specific charger
  Future<Result<Charger>> getChargerDetails({
    required String chargerId,
    required String placeId,
  });

  /// Checks compatibility between a charger and vehicle
  ChargerCompatibility checkCompatibility({
    required Charger charger,
    required Vehicle vehicle,
  });
}
