import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'src/presentation/features/auth/views/auth_page.dart';

final router = GoRouter(
  initialLocation: '/login',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Placeholder(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const AuthPage(),
    ),
  ],
);
