import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/trip.dart';
import '../../../domain/entities/vehicle.dart';
import '../../../domain/usecases/plan_route.dart';

part 'planning_event.dart';
part 'planning_state.dart';

/// BLoC for trip planning functionality
class PlanningBloc extends Bloc<PlanningEvent, PlanningState> {
  final PlanRoute _planRoute;

  PlanningBloc({
    required PlanRoute planRoute,
  })  : _planRoute = planRoute,
        super(const PlanningInitial()) {
    on<OriginChanged>(_onOriginChanged);
    on<DestinationChanged>(_onDestinationChanged);
    on<VehicleSelected>(_onVehicleSelected);
    on<AssumptionsEdited>(_onAssumptionsEdited);
    on<TripNameChanged>(_onTripNameChanged);
    on<CurrentLocationObtained>(_onCurrentLocationObtained);
    on<PlanRequested>(_onPlanRequested);
    on<ReplanRequested>(_onReplanRequested);
  }

  void _onOriginChanged(OriginChanged event, Emitter<PlanningState> emit) {
    if (state is PlanningInitial) {
      emit(
        PlanningInitial(
          originLat: event.latitude,
          originLng: event.longitude,
          destinationLat: (state as PlanningInitial).destinationLat,
          destinationLng: (state as PlanningInitial).destinationLng,
          vehicle: (state as PlanningInitial).vehicle,
          assumptions: (state as PlanningInitial).assumptions,
          tripName: (state as PlanningInitial).tripName,
        ),
      );
    } else if (state is PlanningReady) {
      emit(
        PlanningReady(
          originLat: event.latitude,
          originLng: event.longitude,
          destinationLat: (state as PlanningReady).destinationLat,
          destinationLng: (state as PlanningReady).destinationLng,
          vehicle: (state as PlanningReady).vehicle,
          assumptions: (state as PlanningReady).assumptions,
          tripName: (state as PlanningReady).tripName,
          trip: (state as PlanningReady).trip,
          notices: (state as PlanningReady).notices,
        ),
      );
    }
  }

  void _onDestinationChanged(
      DestinationChanged event, Emitter<PlanningState> emit) {
    if (state is PlanningInitial) {
      emit(
        PlanningInitial(
          originLat: (state as PlanningInitial).originLat,
          originLng: (state as PlanningInitial).originLng,
          destinationLat: event.latitude,
          destinationLng: event.longitude,
          vehicle: (state as PlanningInitial).vehicle,
          assumptions: (state as PlanningInitial).assumptions,
          tripName: (state as PlanningInitial).tripName,
        ),
      );
    } else if (state is PlanningReady) {
      emit(
        PlanningReady(
          originLat: (state as PlanningReady).originLat,
          originLng: (state as PlanningReady).originLng,
          destinationLat: event.latitude,
          destinationLng: event.longitude,
          vehicle: (state as PlanningReady).vehicle,
          assumptions: (state as PlanningReady).assumptions,
          tripName: (state as PlanningReady).tripName,
          trip: (state as PlanningReady).trip,
          notices: (state as PlanningReady).notices,
        ),
      );
    }
  }

  void _onVehicleSelected(VehicleSelected event, Emitter<PlanningState> emit) {
    if (state is PlanningInitial) {
      emit(
        PlanningInitial(
          originLat: (state as PlanningInitial).originLat,
          originLng: (state as PlanningInitial).originLng,
          destinationLat: (state as PlanningInitial).destinationLat,
          destinationLng: (state as PlanningInitial).destinationLng,
          vehicle: event.vehicle,
          assumptions: (state as PlanningInitial).assumptions,
          tripName: (state as PlanningInitial).tripName,
        ),
      );
    } else if (state is PlanningReady) {
      emit(
        PlanningReady(
          originLat: (state as PlanningReady).originLat,
          originLng: (state as PlanningReady).originLng,
          destinationLat: (state as PlanningReady).destinationLat,
          destinationLng: (state as PlanningReady).destinationLng,
          vehicle: event.vehicle,
          assumptions: (state as PlanningReady).assumptions,
          tripName: (state as PlanningReady).tripName,
          trip: (state as PlanningReady).trip,
          notices: (state as PlanningReady).notices,
        ),
      );
    }
  }

  void _onAssumptionsEdited(
      AssumptionsEdited event, Emitter<PlanningState> emit) {
    if (state is PlanningInitial) {
      emit(
        PlanningInitial(
          originLat: (state as PlanningInitial).originLat,
          originLng: (state as PlanningInitial).originLng,
          destinationLat: (state as PlanningInitial).destinationLat,
          destinationLng: (state as PlanningInitial).destinationLng,
          vehicle: (state as PlanningInitial).vehicle,
          assumptions: event.assumptions,
          tripName: (state as PlanningInitial).tripName,
        ),
      );
    } else if (state is PlanningReady) {
      emit(
        PlanningReady(
          originLat: (state as PlanningReady).originLat,
          originLng: (state as PlanningReady).originLng,
          destinationLat: (state as PlanningReady).destinationLat,
          destinationLng: (state as PlanningReady).destinationLng,
          vehicle: (state as PlanningReady).vehicle,
          assumptions: event.assumptions,
          tripName: (state as PlanningReady).tripName,
          trip: (state as PlanningReady).trip,
          notices: (state as PlanningReady).notices,
        ),
      );
    }
  }

  void _onTripNameChanged(TripNameChanged event, Emitter<PlanningState> emit) {
    if (state is PlanningInitial) {
      emit(
        PlanningInitial(
          originLat: (state as PlanningInitial).originLat,
          originLng: (state as PlanningInitial).originLng,
          destinationLat: (state as PlanningInitial).destinationLat,
          destinationLng: (state as PlanningInitial).destinationLng,
          vehicle: (state as PlanningInitial).vehicle,
          assumptions: (state as PlanningInitial).assumptions,
          tripName: event.tripName,
        ),
      );
    } else if (state is PlanningReady) {
      emit(
        PlanningReady(
          originLat: (state as PlanningReady).originLat,
          originLng: (state as PlanningReady).originLng,
          destinationLat: (state as PlanningReady).destinationLat,
          destinationLng: (state as PlanningReady).destinationLng,
          vehicle: (state as PlanningReady).vehicle,
          assumptions: (state as PlanningReady).assumptions,
          tripName: event.tripName,
          trip: (state as PlanningReady).trip,
          notices: (state as PlanningReady).notices,
        ),
      );
    }
  }

  void _onCurrentLocationObtained(
      CurrentLocationObtained event, Emitter<PlanningState> emit) {
    if (state is PlanningInitial) {
      emit(
        PlanningInitial(
          originLat: event.latitude,
          originLng: event.longitude,
          destinationLat: (state as PlanningInitial).destinationLat,
          destinationLng: (state as PlanningInitial).destinationLng,
          vehicle: (state as PlanningInitial).vehicle,
          assumptions: (state as PlanningInitial).assumptions,
          tripName: (state as PlanningInitial).tripName,
        ),
      );
    }
  }

  Future<void> _onPlanRequested(
      PlanRequested event, Emitter<PlanningState> emit) async {
    if (state is! PlanningInitial) return;

    final currentState = state as PlanningInitial;

    // Validate required fields
    if (currentState.originLat == null ||
        currentState.originLng == null ||
        currentState.destinationLat == null ||
        currentState.destinationLng == null ||
        currentState.vehicle == null) {
      emit(
        const PlanningError('Please fill in all required fields'),
      );
      return;
    }

    emit(
      PlanningLoading(
        originLat: currentState.originLat!,
        originLng: currentState.originLng!,
        destinationLat: currentState.destinationLat!,
        destinationLng: currentState.destinationLng!,
        vehicle: currentState.vehicle!,
        assumptions: currentState.assumptions,
        tripName: currentState.tripName,
      ),
    );

    try {
      final result = await _planRoute(
        PlanRouteParams(
          originLat: currentState.originLat!,
          originLng: currentState.originLng!,
          destinationLat: currentState.destinationLat!,
          destinationLng: currentState.destinationLng!,
          vehicle: currentState.vehicle!,
          assumptions: currentState.assumptions,
          tripName: currentState.tripName,
          userId: event.userId,
        ),
      );

      if (result.isError()) {
        emit(
          PlanningError(
              result.exceptionOrNull()?.toString() ?? 'Unknown error'),
        );
        return;
      }

      final trip = result.getOrThrow();
      final notices = _generateNotices(trip);

      emit(
        PlanningReady(
          originLat: currentState.originLat!,
          originLng: currentState.originLng!,
          destinationLat: currentState.destinationLat!,
          destinationLng: currentState.destinationLng!,
          vehicle: currentState.vehicle!,
          assumptions: currentState.assumptions,
          tripName: currentState.tripName,
          trip: trip,
          notices: notices,
        ),
      );
    } catch (e) {
      emit(
        PlanningError('An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  Future<void> _onReplanRequested(
      ReplanRequested event, Emitter<PlanningState> emit) async {
    if (state is! PlanningReady) return;

    final currentState = state as PlanningReady;

    emit(
      PlanningLoading(
        originLat: currentState.originLat,
        originLng: currentState.originLng,
        destinationLat: currentState.destinationLat,
        destinationLng: currentState.destinationLng,
        vehicle: currentState.vehicle,
        assumptions: currentState.assumptions,
        tripName: currentState.tripName,
      ),
    );

    try {
      final result = await _planRoute(
        PlanRouteParams(
          originLat: currentState.originLat,
          originLng: currentState.originLng,
          destinationLat: currentState.destinationLat,
          destinationLng: currentState.destinationLng,
          vehicle: currentState.vehicle,
          assumptions: currentState.assumptions,
          tripName: currentState.tripName,
          userId: event.userId,
        ),
      );

      if (result.isError()) {
        emit(
          PlanningError(
              result.exceptionOrNull()?.toString() ?? 'Unknown error'),
        );
        return;
      }

      final trip = result.getOrThrow();
      final notices = _generateNotices(trip);

      emit(
        PlanningReady(
          originLat: currentState.originLat,
          originLng: currentState.originLng,
          destinationLat: currentState.destinationLat,
          destinationLng: currentState.destinationLng,
          vehicle: currentState.vehicle,
          assumptions: currentState.assumptions,
          tripName: currentState.tripName,
          trip: trip,
          notices: notices,
        ),
      );
    } catch (e) {
      emit(
        PlanningError('An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  /// Generates notices for the trip
  List<String> _generateNotices(Trip trip) {
    final notices = <String>[];

    // Check for low SoC warnings
    for (final leg in trip.legEstimates) {
      if (leg.arrivalSoCPercent < 10) {
        notices.add(
          'Low battery warning: ${leg.arrivalSoCPercent.toStringAsFixed(1)}% at ${leg.leg.endLocation.latitude.toStringAsFixed(4)}, ${leg.leg.endLocation.longitude.toStringAsFixed(4)}',
        );
      }
    }

    // Check for charging stops
    final chargingStops =
        trip.legEstimates.where((leg) => leg.chargingStop != null).length;
    if (chargingStops > 0) {
      notices.add('$chargingStops charging stop(s) planned');
    }

    // Check for assumptions
    for (final leg in trip.legEstimates) {
      for (final assumption in leg.assumptions) {
        if (!notices.contains(assumption)) {
          notices.add(assumption);
        }
      }
    }

    return notices;
  }
}
