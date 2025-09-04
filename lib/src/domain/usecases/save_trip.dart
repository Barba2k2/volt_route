import 'package:result_dart/result_dart.dart';

import '../../core/services/logger_service.dart';
import '../entities/trip.dart';
import '../interfaces/usecase_interface.dart';
import '../repositories/trips_repository.dart';

/// Use case for saving a trip
class SaveTrip implements UseCase<Trip, SaveTripParams> {
  final TripsRepository _tripsRepository;
  final LoggerService _loggerService;

  const SaveTrip({
    required TripsRepository tripsRepository,
    required LoggerService loggerService,
  })  : _tripsRepository = tripsRepository,
        _loggerService = loggerService;

  @override
  Future<Result<Trip>> call(SaveTripParams params) async {
    try {
      final tripToSave = params.trip.copyWith(
        isSaved: true,
        lastModified: DateTime.now(),
      );

      final result = await _tripsRepository.saveTrip(tripToSave);

      if (result.isError()) {
        return Failure(result.exceptionOrNull()!);
      }

      return Success(result.getOrThrow());
    } catch (e) {
      final exception = Exception('Failed to save trip: ${e.toString()}');

      _loggerService.logException(
        exception,
        context: 'SaveTrip UseCase',
        additionalData: {
          'tripId': params.trip.id,
          'tripName': params.trip.name,
          'userId': params.trip.userId,
        },
        stackTrace: StackTrace.current,
      );

      return Failure(exception);
    }
  }
}

/// Parameters for saving a trip
class SaveTripParams {
  final Trip trip;

  const SaveTripParams({
    required this.trip,
  });
}
