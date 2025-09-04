part of 'trips_bloc.dart';

/// Base class for trips events
abstract class TripsEvent extends Equatable {
  const TripsEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load saved trips
class LoadSavedTrips extends TripsEvent {
  final String? userId;

  const LoadSavedTrips({
    this.userId,
  });

  @override
  List<Object?> get props => [userId];
}

/// Event to save a trip
class SaveTripRequested extends TripsEvent {
  final Trip trip;

  const SaveTripRequested({
    required this.trip,
  });

  @override
  List<Object?> get props => [trip];
}

/// Event to delete a trip
class DeleteTripRequested extends TripsEvent {
  final String tripId;

  const DeleteTripRequested({
    required this.tripId,
  });

  @override
  List<Object?> get props => [tripId];
}

/// Event to duplicate a trip
class DuplicateTripRequested extends TripsEvent {
  final String tripId;

  const DuplicateTripRequested({
    required this.tripId,
  });

  @override
  List<Object?> get props => [tripId];
}
