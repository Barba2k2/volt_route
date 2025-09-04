import 'package:result_dart/result_dart.dart';

import '../../core/services/logger_service.dart';
import '../entities/charger.dart';
import '../entities/route_polyline.dart';
import '../entities/vehicle.dart';
import '../interfaces/usecase_interface.dart';
import '../repositories/charging_repository.dart';

/// Use case for getting compatible chargers along a route
class GetCompatibleChargers
    implements UseCase<List<Charger>, GetCompatibleChargersParams> {
  final ChargingRepository _chargingRepository;
  final LoggerService _loggerService;

  const GetCompatibleChargers({
    required ChargingRepository chargingRepository,
    required LoggerService loggerService,
  })  : _chargingRepository = chargingRepository,
        _loggerService = loggerService;

  @override
  Future<Result<List<Charger>>> call(GetCompatibleChargersParams params) async {
    try {
      final chargersResult = await _chargingRepository.getChargersAlongRoute(
        route: params.route,
        vehicle: params.vehicle,
        searchRadiusKm: params.searchRadiusKm,
      );

      if (chargersResult.isError()) {
        return Failure(chargersResult.exceptionOrNull()!);
      }

      final allChargers = chargersResult.getOrThrow();

      // Filter and sort chargers by compatibility
      final compatibleChargers = _filterAndSortChargers(
        chargers: allChargers,
        vehicle: params.vehicle,
      );

      return Success(compatibleChargers);
    } catch (e) {
      final exception = Exception(
        'Failed to get compatible chargers: ${e.toString()}',
      );

      _loggerService.logException(
        exception,
        context: 'GetCompatibleChargers UseCase',
        additionalData: {
          'routeDistanceKm': params.route.totalDistanceKm,
          'vehicleId': params.vehicle.id,
          'searchRadiusKm': params.searchRadiusKm,
        },
        stackTrace: StackTrace.current,
      );

      return Failure(exception);
    }
  }

  /// Filters and sorts chargers by compatibility with the vehicle
  List<Charger> _filterAndSortChargers({
    required List<Charger> chargers,
    required Vehicle vehicle,
  }) {
    final compatibleChargers = <Charger>[];
    final assumedCompatibleChargers = <Charger>[];
    final unknownChargers = <Charger>[];

    for (final charger in chargers) {
      final compatibility = _chargingRepository.checkCompatibility(
        charger: charger,
        vehicle: vehicle,
      );

      switch (compatibility) {
        case ChargerCompatibility.compatible:
          compatibleChargers.add(charger);
          break;
        case ChargerCompatibility.assumedCompatible:
          assumedCompatibleChargers.add(charger);
          break;
        case ChargerCompatibility.unknown:
          unknownChargers.add(charger);
          break;
        case ChargerCompatibility.incompatible:
          // Skip incompatible chargers
          break;
      }
    }

    // Sort each group by rating and distance
    compatibleChargers.sort(_compareChargers);
    assumedCompatibleChargers.sort(_compareChargers);
    unknownChargers.sort(_compareChargers);

    // Return in order of preference: compatible, assumed compatible, unknown
    return [
      ...compatibleChargers,
      ...assumedCompatibleChargers,
      ...unknownChargers,
    ];
  }

  /// Compares two chargers for sorting
  int _compareChargers(Charger a, Charger b) {
    // First, sort by rating (higher is better)
    final ratingA = a.rating ?? 0;
    final ratingB = b.rating ?? 0;

    if (ratingA != ratingB) {
      return ratingB.compareTo(ratingA);
    }

    // Then, sort by number of ratings (more ratings = more reliable)
    final ratingsCountA = a.userRatingsTotal ?? 0;
    final ratingsCountB = b.userRatingsTotal ?? 0;

    if (ratingsCountA != ratingsCountB) {
      return ratingsCountB.compareTo(ratingsCountA);
    }

    // Finally, sort by power (higher is better)
    final powerA = a.maxPowerKw ?? 0;
    final powerB = b.maxPowerKw ?? 0;

    return powerB.compareTo(powerA);
  }
}

/// Parameters for getting compatible chargers
class GetCompatibleChargersParams {
  final RoutePolyline route;
  final Vehicle vehicle;
  final double searchRadiusKm;

  const GetCompatibleChargersParams({
    required this.route,
    required this.vehicle,
    this.searchRadiusKm = 5.0,
  });
}
