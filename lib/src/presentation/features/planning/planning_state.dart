part of 'planning_bloc.dart';

/// Base class for planning states
abstract class PlanningState extends Equatable {
  const PlanningState();

  @override
  List<Object?> get props => [];
}

/// Initial state when planning starts
class PlanningInitial extends PlanningState {
  final double? originLat;
  final double? originLng;
  final double? destinationLat;
  final double? destinationLng;
  final Vehicle? vehicle;
  final TripAssumptions assumptions;
  final String tripName;

  const PlanningInitial({
    this.originLat,
    this.originLng,
    this.destinationLat,
    this.destinationLng,
    this.vehicle,
    this.assumptions = TripAssumptions.defaultAssumptions,
    this.tripName = 'New Trip',
  });

  @override
  List<Object?> get props => [
        originLat,
        originLng,
        destinationLat,
        destinationLng,
        vehicle,
        assumptions,
        tripName,
      ];
}

/// State when planning is in progress
class PlanningLoading extends PlanningState {
  final double originLat;
  final double originLng;
  final double destinationLat;
  final double destinationLng;
  final Vehicle vehicle;
  final TripAssumptions assumptions;
  final String tripName;

  const PlanningLoading({
    required this.originLat,
    required this.originLng,
    required this.destinationLat,
    required this.destinationLng,
    required this.vehicle,
    required this.assumptions,
    required this.tripName,
  });

  @override
  List<Object?> get props => [
        originLat,
        originLng,
        destinationLat,
        destinationLng,
        vehicle,
        assumptions,
        tripName,
      ];
}

/// State when planning is complete and ready
class PlanningReady extends PlanningState {
  final double originLat;
  final double originLng;
  final double destinationLat;
  final double destinationLng;
  final Vehicle vehicle;
  final TripAssumptions assumptions;
  final String tripName;
  final Trip trip;
  final List<String> notices;

  const PlanningReady({
    required this.originLat,
    required this.originLng,
    required this.destinationLat,
    required this.destinationLng,
    required this.vehicle,
    required this.assumptions,
    required this.tripName,
    required this.trip,
    required this.notices,
  });

  @override
  List<Object?> get props => [
        originLat,
        originLng,
        destinationLat,
        destinationLng,
        vehicle,
        assumptions,
        tripName,
        trip,
        notices,
      ];
}

/// State when planning encounters an error
class PlanningError extends PlanningState {
  final String message;

  const PlanningError(this.message);

  @override
  List<Object?> get props => [message];
}
