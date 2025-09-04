import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/trip.dart';
import '../../../domain/usecases/get_saved_trips.dart';
import '../../../domain/usecases/save_trip.dart';

part 'trips_event.dart';
part 'trips_state.dart';

/// BLoC for managing saved trips
class TripsBloc extends Bloc<TripsEvent, TripsState> {
  final GetSavedTrips _getSavedTrips;
  final SaveTrip _saveTrip;

  TripsBloc({
    required GetSavedTrips getSavedTrips,
    required SaveTrip saveTrip,
  })  : _getSavedTrips = getSavedTrips,
        _saveTrip = saveTrip,
        super(const TripsInitial()) {
    on<LoadSavedTrips>(_onLoadSavedTrips);
    on<SaveTripRequested>(_onSaveTripRequested);
    on<DeleteTripRequested>(_onDeleteTripRequested);
    on<DuplicateTripRequested>(_onDuplicateTripRequested);
  }

  Future<void> _onLoadSavedTrips(
      LoadSavedTrips event, Emitter<TripsState> emit) async {
    emit(const TripsLoading());

    try {
      final result = await _getSavedTrips(GetSavedTripsParams(
        userId: event.userId,
      ));

      if (result.isError()) {
        emit(
          TripsError(result.exceptionOrNull()?.toString() ?? 'Unknown error'),
        );
        return;
      }

      final trips = result.getOrThrow();
      emit(
        TripsLoaded(trips: trips),
      );
    } catch (e) {
      emit(
        TripsError('An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  Future<void> _onSaveTripRequested(
      SaveTripRequested event, Emitter<TripsState> emit) async {
    if (state is! TripsLoaded) return;

    try {
      final result = await _saveTrip(
        SaveTripParams(
          trip: event.trip,
        ),
      );

      if (result.isError()) {
        emit(
          TripsError(
            result.exceptionOrNull()?.toString() ?? 'Unknown error',
          ),
        );
        return;
      }

      final savedTrip = result.getOrThrow();
      final currentTrips = (state as TripsLoaded).trips;

      // Update the trip in the list
      final updatedTrips = currentTrips.map((trip) {
        if (trip.id == savedTrip.id) {
          return savedTrip;
        }
        return trip;
      }).toList();

      // If it's a new trip, add it to the list
      if (!currentTrips.any((trip) => trip.id == savedTrip.id)) {
        updatedTrips.insert(0, savedTrip);
      }

      emit(TripsLoaded(trips: updatedTrips));
    } catch (e) {
      emit(
        TripsError('An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  Future<void> _onDeleteTripRequested(
      DeleteTripRequested event, Emitter<TripsState> emit) async {
    if (state is! TripsLoaded) return;

    try {
      // For now, just remove from the list
      // In a real implementation, this would call a delete use case
      final currentTrips = (state as TripsLoaded).trips;
      final updatedTrips = currentTrips
          .where(
            (trip) => trip.id != event.tripId,
          )
          .toList();

      emit(
        TripsLoaded(trips: updatedTrips),
      );
    } catch (e) {
      emit(
        TripsError('An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  Future<void> _onDuplicateTripRequested(
      DuplicateTripRequested event, Emitter<TripsState> emit) async {
    if (state is! TripsLoaded) return;

    try {
      final currentTrips = (state as TripsLoaded).trips;
      final originalTrip =
          currentTrips.firstWhere((trip) => trip.id == event.tripId);

      final duplicatedTrip = originalTrip.copyWith(
        id: 'trip_${DateTime.now().millisecondsSinceEpoch}',
        name: '${originalTrip.name} (Copy)',
        createdAt: DateTime.now(),
        lastModified: DateTime.now(),
        isSaved: false,
      );

      // Add the duplicated trip to the list
      final updatedTrips = [duplicatedTrip, ...currentTrips];

      emit(TripsLoaded(trips: updatedTrips));
    } catch (e) {
      emit(
        TripsError('An unexpected error occurred: ${e.toString()}'),
      );
    }
  }
}
