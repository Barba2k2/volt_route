import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/DI/dependency_injector.dart';
import '../../domain/usecases/get_saved_trips.dart';
import '../../domain/usecases/plan_route.dart';
import '../../domain/usecases/save_trip.dart';
import '../features/auth/views/auth_page.dart';
import '../features/auth/views/profile_page.dart';
import '../features/planning/planning_bloc.dart';
import '../features/planning/views/planning_page.dart';
import '../features/trips/trips_bloc.dart';
import '../features/trips/views/trips_page.dart';

/// App router configuration
class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: '/auth',
    routes: [
      GoRoute(
        path: '/planning',
        name: 'planning',
        builder: (context, state) => BlocProvider(
          create: (context) => PlanningBloc(
            planRoute: getIt<PlanRoute>(),
          ),
          child: const PlanningPage(),
        ),
      ),
      GoRoute(
        path: '/trips',
        name: 'trips',
        builder: (context, state) => BlocProvider(
          create: (context) => TripsBloc(
            getSavedTrips: getIt<GetSavedTrips>(),
            saveTrip: getIt<SaveTrip>(),
          ),
          child: const TripsPage(),
        ),
      ),
      GoRoute(
        path: '/auth',
        name: 'auth',
        builder: (context, state) => const AuthPage(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfilePage(),
      ),
    ],
  );

  static GoRouter get router => _router;
}
