import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../trips_bloc.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/error_widget.dart';
import '../../../widgets/empty_state_widget.dart';
import '../widgets/trips_list_widget.dart';

/// Trips page for managing saved trips
class TripsPage extends StatelessWidget {
  const TripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Trips'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Navigate to planning page
            },
          ),
        ],
      ),
      body: BlocBuilder<TripsBloc, TripsState>(
        builder: (context, state) {
          if (state is TripsLoading) {
            return const LoadingWidget(message: 'Loading trips...');
          }

          if (state is TripsError) {
            return AppErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<TripsBloc>().add(const LoadSavedTrips());
              },
            );
          }

          if (state is TripsLoaded) {
            if (state.trips.isEmpty) {
              return const EmptyStateWidget(
                icon: Icons.route,
                title: 'No saved trips',
                subtitle: 'Plan your first trip to get started',
                buttonText: 'Plan Trip',
                onButtonPressed: null, // TODO: Navigate to planning page
              );
            }
            return TripsListWidget(trips: state.trips);
          }

          return const Center(
            child: Text('No trips loaded'),
          );
        },
      ),
    );
  }
}
