import 'package:result_dart/result_dart.dart';

import '../../domain/entities/charger.dart';
import '../../domain/entities/route_polyline.dart';
import '../../domain/entities/vehicle.dart';
import '../../domain/repositories/charging_repository.dart';
import '../datasources/remote/google_places_client.dart';
import '../../core/errors/base_exception.dart';
import '../../core/services/logger_service.dart';

/// Implementation of ChargingRepository using Google Places API
class ChargingRepositoryImpl implements ChargingRepository {
  final GooglePlacesClient _placesClient;
  final LoggerService _loggerService;

  const ChargingRepositoryImpl({
    required GooglePlacesClient placesClient,
    required LoggerService loggerService,
  })  : _placesClient = placesClient,
        _loggerService = loggerService;

  @override
  Future<Result<List<Charger>>> getChargersAlongRoute({
    required RoutePolyline route,
    required Vehicle vehicle,
    double searchRadiusKm = 5.0,
  }) async {
    try {
      final chargerDtos = await _placesClient.getChargersAlongRoute(
        route: route,
        vehicle: vehicle,
        searchRadiusKm: searchRadiusKm,
      );

      final chargers = chargerDtos.map((dto) => dto.toEntity()).toList();

      // Check compatibility for each charger
      final compatibleChargers = chargers.map((charger) {
        final compatibility = checkCompatibility(
          charger: charger,
          vehicle: vehicle,
        );

        return charger.copyWith(compatibility: compatibility);
      }).toList();

      return Success(compatibleChargers);
    } on Exception catch (e) {
      _loggerService.logHttpException(
        e,
        method: 'GET',
        url: 'Google Places API (chargers along route)',
        requestData: {
          'routeDistanceKm': route.totalDistanceKm,
          'vehicleId': vehicle.id,
          'searchRadiusKm': searchRadiusKm,
        },
        stackTrace: StackTrace.current,
      );
      return Failure(e);
    } catch (e) {
      final exception = Exception(
        'Failed to get chargers along route: ${e.toString()}',
      );

      _loggerService.logHttpException(
        exception,
        method: 'GET',
        url: 'Google Places API (chargers along route)',
        requestData: {
          'routeDistanceKm': route.totalDistanceKm,
          'vehicleId': vehicle.id,
          'searchRadiusKm': searchRadiusKm,
        },
        stackTrace: StackTrace.current,
      );

      return Failure(exception);
    }
  }

  @override
  Future<Result<List<Charger>>> getChargersNearLocation({
    required double latitude,
    required double longitude,
    required Vehicle vehicle,
    double radiusKm = 10.0,
  }) async {
    try {
      final chargerDtos = await _placesClient.getChargersNearLocation(
        latitude: latitude,
        longitude: longitude,
        radiusKm: radiusKm,
      );

      final chargers = chargerDtos.map((dto) => dto.toEntity()).toList();

      // Check compatibility for each charger
      final compatibleChargers = chargers.map((charger) {
        final compatibility = checkCompatibility(
          charger: charger,
          vehicle: vehicle,
        );

        return charger.copyWith(compatibility: compatibility);
      }).toList();

      return Success(compatibleChargers);
    } on Exception catch (e) {
      _loggerService.logHttpException(
        e,
        method: 'GET',
        url: 'Google Places API (chargers near location)',
        requestData: {
          'latitude': latitude,
          'longitude': longitude,
          'vehicleId': vehicle.id,
          'radiusKm': radiusKm,
        },
        stackTrace: StackTrace.current,
      );
      return Failure(e);
    } catch (e) {
      final exception = Exception(
        'Failed to get chargers near location: ${e.toString()}',
      );

      _loggerService.logHttpException(
        exception,
        method: 'GET',
        url: 'Google Places API (chargers near location)',
        requestData: {
          'latitude': latitude,
          'longitude': longitude,
          'vehicleId': vehicle.id,
          'radiusKm': radiusKm,
        },
        stackTrace: StackTrace.current,
      );

      return Failure(exception);
    }
  }

  @override
  Future<Result<Charger>> getChargerDetails({
    required String chargerId,
    required String placeId,
  }) async {
    try {
      final chargerDto = await _placesClient.getChargerDetails(
        placeId: placeId,
      );

      final charger = chargerDto.toEntity();
      return Success(charger);
    } on Exception catch (e) {
      _loggerService.logHttpException(
        e,
        method: 'GET',
        url: 'Google Places API (charger details)',
        requestData: {
          'chargerId': chargerId,
          'placeId': placeId,
        },
        stackTrace: StackTrace.current,
      );
      return Failure(e);
    } catch (e) {
      final exception = BaseException(
        message: 'Failed to get charger details: ${e.toString()}',
        data: e,
      );

      _loggerService.logHttpException(
        exception,
        method: 'GET',
        url: 'Google Places API (charger details)',
        requestData: {
          'chargerId': chargerId,
          'placeId': placeId,
        },
        stackTrace: StackTrace.current,
      );

      return Failure(exception);
    }
  }

  @override
  ChargerCompatibility checkCompatibility({
    required Charger charger,
    required Vehicle vehicle,
  }) {
    // If charger has explicit connector information
    if (charger.availableConnectors != null &&
        charger.availableConnectors!.isNotEmpty) {
      for (final chargerConnector in charger.availableConnectors!) {
        if (vehicle.supportedConnectors.contains(chargerConnector)) {
          return ChargerCompatibility.compatible;
        }
      }
      return ChargerCompatibility.incompatible;
    }

    // If no connector information is available, use heuristics
    return _assessCompatibilityByHeuristics(charger, vehicle);
  }

  /// Assesses compatibility using heuristics when explicit connector data is not available
  ChargerCompatibility _assessCompatibilityByHeuristics(
    Charger charger,
    Vehicle vehicle,
  ) {
    // Check if charger name contains brand information
    final chargerName = charger.name.toLowerCase();
    final vehicleBrand = vehicle.brand.toLowerCase();

    // Tesla-specific logic
    if (vehicleBrand.contains('tesla')) {
      if (chargerName.contains('tesla') ||
          chargerName.contains('supercharger')) {
        return ChargerCompatibility.assumedCompatible;
      }
    }

    // European brands (Volvo, BMW, Mercedes, etc.) typically use CCS2/Type2
    if (_isEuropeanBrand(vehicleBrand)) {
      if (chargerName.contains('ccs') || chargerName.contains('type 2')) {
        return ChargerCompatibility.assumedCompatible;
      }
    }

    // Asian brands (BYD, Hyundai, Kia, etc.) may use different standards
    if (_isAsianBrand(vehicleBrand)) {
      if (chargerName.contains('ccs') || chargerName.contains('chademo')) {
        return ChargerCompatibility.assumedCompatible;
      }
    }

    // Generic charging stations - assume compatible but warn user
    if (chargerName.contains('charging') || chargerName.contains('ev')) {
      return ChargerCompatibility.assumedCompatible;
    }

    return ChargerCompatibility.unknown;
  }

  /// Checks if a brand is European
  bool _isEuropeanBrand(String brand) {
    const europeanBrands = [
      'volvo',
      'bmw',
      'mercedes',
      'audi',
      'volkswagen',
      'porsche',
      'renault',
      'peugeot',
      'citroen',
      'fiat',
      'alfa romeo',
      'jaguar',
      'land rover',
      'mini',
      'smart',
      'seat',
      'skoda'
    ];

    return europeanBrands.any((europeanBrand) => brand.contains(europeanBrand));
  }

  /// Checks if a brand is Asian
  bool _isAsianBrand(String brand) {
    const asianBrands = [
      'byd',
      'hyundai',
      'kia',
      'nissan',
      'toyota',
      'honda',
      'mazda',
      'subaru',
      'mitsubishi',
      'suzuki',
      'lexus',
      'infiniti',
      'acura'
    ];

    return asianBrands.any((asianBrand) => brand.contains(asianBrand));
  }
}
