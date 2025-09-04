import 'package:result_dart/result_dart.dart';

import '../../core/errors/base_exception.dart';
import '../../core/services/logger_service.dart';
import '../../domain/entities/trip.dart';
import '../../domain/entities/trip_statistics.dart';
import '../../domain/repositories/trips_repository.dart';
import '../datasources/local/isar_datasource.dart';
import '../models/trip_dto.dart';

/// Implementation of TripsRepository using local storage
class TripsRepositoryImpl implements TripsRepository {
  final IsarDataSource _localDataSource;
  final LoggerService _loggerService;

  const TripsRepositoryImpl({
    required IsarDataSource localDataSource,
    required LoggerService loggerService,
  })  : _localDataSource = localDataSource,
        _loggerService = loggerService;

  @override
  Future<Result<Trip>> saveTrip(Trip trip) async {
    try {
      final tripDto = TripDto.fromEntity(trip);
      await _localDataSource.saveTrip(tripDto);
      return Success(trip);
    } catch (e) {
      final exception =
          BaseException(message: 'Failed to save trip: ${e.toString()}');

      _loggerService.logDatabaseException(
        exception,
        operation: 'saveTrip',
        table: 'trips',
        data: {'tripId': trip.id, 'userId': trip.userId},
        stackTrace: StackTrace.current,
      );

      return Failure(exception);
    }
  }

  @override
  Future<Result<List<Trip>>> getSavedTrips({
    String? userId,
  }) async {
    try {
      final tripDtos = await _localDataSource.getAllTrips(userId: userId);
      final trips = tripDtos.map((dto) => dto.toEntity()).toList();
      return Success(trips);
    } catch (e) {
      final exception = BaseException(
        message: 'Failed to get saved trips: ${e.toString()}',
        data: e,
      );

      _loggerService.logDatabaseException(
        exception,
        operation: 'getSavedTrips',
        table: 'trips',
        data: {'userId': userId},
        stackTrace: StackTrace.current,
      );

      return Failure(exception);
    }
  }

  @override
  Future<Result<Trip>> getTripById(String tripId) async {
    try {
      final tripDto = await _localDataSource.getTripById(tripId);
      if (tripDto == null) {
        return Failure(
          BaseException(
            message: 'Trip not found: $tripId',
          ),
        );
      }
      final trip = tripDto.toEntity();
      return Success(trip);
    } catch (e) {
      final exception = BaseException(
        message: 'Failed to get trip: ${e.toString()}',
        data: e,
      );

      _loggerService.logDatabaseException(
        exception,
        operation: 'getTripById',
        table: 'trips',
        data: {'tripId': tripId},
        stackTrace: StackTrace.current,
      );

      return Failure(exception);
    }
  }

  @override
  Future<Result<Trip>> updateTrip(Trip trip) async {
    try {
      final tripDto = TripDto.fromEntity(trip);
      await _localDataSource.updateTrip(tripDto);
      return Success(trip);
    } catch (e) {
      final exception = BaseException(
        message: 'Failed to update trip: ${e.toString()}',
        data: e,
      );

      _loggerService.logDatabaseException(
        exception,
        operation: 'updateTrip',
        table: 'trips',
        data: {'tripId': trip.id, 'userId': trip.userId},
        stackTrace: StackTrace.current,
      );

      return Failure(exception);
    }
  }

  @override
  Future<Result<void>> deleteTrip(String tripId) async {
    try {
      await _localDataSource.deleteTrip(tripId);
      return const Success(());
    } catch (e) {
      final exception = BaseException(
        message: 'Failed to delete trip: ${e.toString()}',
        data: e,
      );

      _loggerService.logDatabaseException(
        exception,
        operation: 'deleteTrip',
        table: 'trips',
        data: {'tripId': tripId},
        stackTrace: StackTrace.current,
      );

      return Failure(exception);
    }
  }

  @override
  Future<Result<Trip>> duplicateTrip(String tripId) async {
    try {
      final originalTripResult = await getTripById(tripId);
      if (originalTripResult.isError()) {
        return Failure(originalTripResult.exceptionOrNull()!);
      }

      final originalTrip = originalTripResult.getOrThrow();
      final duplicatedTrip = originalTrip.copyWith(
        id: _generateTripId(),
        name: '${originalTrip.name} (Copy)',
        createdAt: DateTime.now(),
        lastModified: DateTime.now(),
        isSaved: false,
      );

      final saveResult = await saveTrip(duplicatedTrip);
      if (saveResult.isError()) {
        return Failure(saveResult.exceptionOrNull()!);
      }

      return Success(saveResult.getOrThrow());
    } catch (e) {
      final exception = BaseException(
        message: 'Failed to duplicate trip: ${e.toString()}',
        data: e,
      );

      _loggerService.logDatabaseException(
        exception,
        operation: 'duplicateTrip',
        table: 'trips',
        data: {'originalTripId': tripId},
        stackTrace: StackTrace.current,
      );

      return Failure(exception);
    }
  }

  @override
  Future<Result<TripStatistics>> getTripStatistics({
    String? userId,
  }) async {
    try {
      final tripsResult = await getSavedTrips(userId: userId);
      if (tripsResult.isError()) {
        return Failure(tripsResult.exceptionOrNull()!);
      }

      final trips = tripsResult.getOrThrow();

      if (trips.isEmpty) {
        return const Success(
          TripStatistics(
            totalTrips: 0,
            totalDistanceKm: 0,
            totalEnergyConsumedKwh: 0,
            totalChargingTimeMinutes: 0,
            totalCost: 0,
            averageTripDistanceKm: 0,
            averageEnergyEfficiencyKwhPer100km: 0,
          ),
        );
      }

      final totalTrips = trips.length;
      final totalDistanceKm =
          trips.fold(0.0, (sum, trip) => sum + trip.route.totalDistanceKm);
      final totalEnergyConsumedKwh =
          trips.fold(0.0, (sum, trip) => sum + trip.totalEnergyConsumedKwh);
      final totalChargingTimeMinutes =
          trips.fold(0, (sum, trip) => sum + trip.totalChargingTimeMinutes);
      final totalCost =
          trips.fold(0.0, (sum, trip) => sum + trip.estimatedTotalCost);

      final averageTripDistanceKm = totalDistanceKm / totalTrips;
      final averageEnergyEfficiencyKwhPer100km =
          totalEnergyConsumedKwh / totalDistanceKm * 100;

      final statistics = TripStatistics(
        totalTrips: totalTrips,
        totalDistanceKm: totalDistanceKm,
        totalEnergyConsumedKwh: totalEnergyConsumedKwh,
        totalChargingTimeMinutes: totalChargingTimeMinutes,
        totalCost: totalCost,
        averageTripDistanceKm: averageTripDistanceKm,
        averageEnergyEfficiencyKwhPer100km: averageEnergyEfficiencyKwhPer100km,
      );

      return Success(statistics);
    } catch (e) {
      return Failure(
        BaseException(
          message: 'Failed to get trip statistics: ${e.toString()}',
          data: e,
        ),
      );
    }
  }

  /// Generates a unique trip ID
  String _generateTripId() {
    return 'trip_${DateTime.now().millisecondsSinceEpoch}';
  }
}
