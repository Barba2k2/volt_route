part of 'planning_bloc.dart';

/// Base class for planning events
abstract class PlanningEvent extends Equatable {
  const PlanningEvent();

  @override
  List<Object?> get props => [];
}

/// Event when origin location is changed
class OriginChanged extends PlanningEvent {
  final double latitude;
  final double longitude;

  const OriginChanged({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [latitude, longitude];
}

/// Event when destination location is changed
class DestinationChanged extends PlanningEvent {
  final double latitude;
  final double longitude;

  const DestinationChanged({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [latitude, longitude];
}

/// Event when a vehicle is selected
class VehicleSelected extends PlanningEvent {
  final Vehicle vehicle;

  const VehicleSelected({
    required this.vehicle,
  });

  @override
  List<Object?> get props => [vehicle];
}

/// Event when trip assumptions are edited
class AssumptionsEdited extends PlanningEvent {
  final TripAssumptions assumptions;

  const AssumptionsEdited({
    required this.assumptions,
  });

  @override
  List<Object?> get props => [assumptions];
}

/// Event when trip name is changed
class TripNameChanged extends PlanningEvent {
  final String tripName;

  const TripNameChanged({
    required this.tripName,
  });

  @override
  List<Object?> get props => [tripName];
}

/// Event when trip planning is requested
class PlanRequested extends PlanningEvent {
  final String? userId;

  const PlanRequested({
    this.userId,
  });

  @override
  List<Object?> get props => [userId];
}

/// Event when trip replanning is requested
class ReplanRequested extends PlanningEvent {
  final String? userId;

  const ReplanRequested({
    this.userId,
  });

  @override
  List<Object?> get props => [userId];
}
