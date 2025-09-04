import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/DI/dependency_injector.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/authenticate_user.dart';
import 'features/auth/auth_bloc.dart';
import 'routes/app_router.dart';
import 'theme/app_theme.dart';

/// Main app widget
class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            authenticateUser: getIt<AuthenticateUser>(),
            authRepository: getIt<AuthRepository>(),
          )..add(const RestoreSessionRequested()),
        ),
      ],
      child: MaterialApp.router(
        title: 'VoltRoute',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
