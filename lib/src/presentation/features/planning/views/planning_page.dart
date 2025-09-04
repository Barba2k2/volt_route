import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../planning_bloc.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/error_widget.dart';
import '../widgets/interactive_planning_map_widget.dart';
import '../widgets/trip_ready_widget.dart';

/// Planning page for trip planning
class PlanningPage extends StatelessWidget {
  const PlanningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan Trip'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Navigate to settings
            },
          ),
        ],
      ),
      body: BlocBuilder<PlanningBloc, PlanningState>(
        builder: (context, state) {
          if (state is PlanningLoading) {
            return const LoadingWidget(message: 'Planning your trip...');
          }

          if (state is PlanningError) {
            return AppErrorWidget(
              message: state.message,
              onRetry: () {
                // TODO: Retry planning
              },
            );
          }

          if (state is PlanningReady) {
            return TripReadyWidget(state: state);
          }

          return const InteractivePlanningMapWidget();
        },
      ),
    );
  }
}
