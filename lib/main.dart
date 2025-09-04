import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'src/core/di/dependency_injector.dart';
import 'src/presentation/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'pt_BR';

  // Configure dependencies
  await configureDependencies();

  runApp(const AppWidget());
}
