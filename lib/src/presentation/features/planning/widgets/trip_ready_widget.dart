import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../planning_bloc.dart';
import 'trip_map_widget.dart';

/// Widget for displaying the ready trip
class TripReadyWidget extends StatelessWidget {
  final PlanningReady state;

  const TripReadyWidget({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Trip map visualization
          TripMapWidget(planningState: state),

          // Trip summary
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.tripName,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                      'Distance: ${state.trip.route.totalDistanceKm.toStringAsFixed(1)} km'),
                  Text('Duration: ${state.trip.totalTripTimeMinutes} minutes'),
                  Text(
                      'Energy: ${state.trip.totalEnergyConsumedKwh.toStringAsFixed(1)} kWh'),
                  Text('Charging stops: ${state.trip.numberOfChargingStops}'),
                ],
              ),
            ),
          ),

          // Notices
          if (state.notices.isNotEmpty) ...[
            const SizedBox(height: 16),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notices',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    ...state.notices.map((notice) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text('• $notice'),
                        )),
                  ],
                ),
              ),
            ),
          ],

          // Action buttons
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      context.read<PlanningBloc>().add(const ReplanRequested());
                    },
                    child: const Text('Replan'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Save trip
                    },
                    child: const Text('Save Trip'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
