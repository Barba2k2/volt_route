part of 'trips_bloc.dart';

/// Base class for trips states
abstract class TripsState extends Equatable {
  const TripsState();

  @override
  List<Object?> get props => [];
}

/// Initial state for trips
class TripsInitial extends TripsState {
  const TripsInitial();
}

/// State when trips are loading
class TripsLoading extends TripsState {
  const TripsLoading();
}

/// State when trips are loaded
class TripsLoaded extends TripsState {
  final List<Trip> trips;

  const TripsLoaded({
    required this.trips,
  });

  @override
  List<Object?> get props => [trips];
}

/// State when trips encounter an error
class TripsError extends TripsState {
  final String message;

  const TripsError(this.message);

  @override
  List<Object?> get props => [message];
}
