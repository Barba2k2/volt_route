import 'package:result_dart/result_dart.dart';

import '../../core/services/logger_service.dart';
import '../entities/trip.dart';
import '../interfaces/usecase_interface.dart';
import '../repositories/trips_repository.dart';

/// Use case for getting saved trips
class GetSavedTrips implements UseCase<List<Trip>, GetSavedTripsParams> {
  final TripsRepository _tripsRepository;
  final LoggerService _loggerService;

  const GetSavedTrips({
    required TripsRepository tripsRepository,
    required LoggerService loggerService,
  })  : _tripsRepository = tripsRepository,
        _loggerService = loggerService;

  @override
  Future<Result<List<Trip>>> call(GetSavedTripsParams params) async {
    try {
      final result = await _tripsRepository.getSavedTrips(
        userId: params.userId,
      );

      if (result.isError()) {
        return Failure(result.exceptionOrNull()!);
      }

      final trips = result.getOrThrow();

      // Sort trips by creation date (newest first)
      trips.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return Success(trips);
    } catch (e) {
      final exception = Exception('Failed to get saved trips: ${e.toString()}');

      _loggerService.logException(
        exception,
        context: 'GetSavedTrips UseCase',
        additionalData: {
          'userId': params.userId,
        },
        stackTrace: StackTrace.current,
      );

      return Failure(exception);
    }
  }
}

/// Parameters for getting saved trips
class GetSavedTripsParams {
  final String? userId;

  const GetSavedTripsParams({
    this.userId,
  });
}
