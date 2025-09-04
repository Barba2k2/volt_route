import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/trip.dart';
import '../trips_bloc.dart';

/// Widget for displaying the list of trips
class TripsListWidget extends StatelessWidget {
  final List<Trip> trips;

  const TripsListWidget({
    super.key,
    required this.trips,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: trips.length,
      itemBuilder: (context, index) {
        final trip = trips[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            title: Text(trip.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Distance: ${trip.route.totalDistanceKm.toStringAsFixed(1)} km'),
                Text('Duration: ${trip.totalTripTimeMinutes} minutes'),
                Text(
                    'Energy: ${trip.totalEnergyConsumedKwh.toStringAsFixed(1)} kWh'),
              ],
            ),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'duplicate',
                  child: Text('Duplicate'),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ],
              onSelected: (value) {
                switch (value) {
                  case 'duplicate':
                    context
                        .read<TripsBloc>()
                        .add(DuplicateTripRequested(tripId: trip.id));
                    break;
                  case 'delete':
                    context
                        .read<TripsBloc>()
                        .add(DeleteTripRequested(tripId: trip.id));
                    break;
                }
              },
            ),
            onTap: () {
              // TODO: Navigate to trip details
            },
          ),
        );
      },
    );
  }
}
