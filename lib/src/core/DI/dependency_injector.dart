import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/datasources/local/isar_datasource.dart';
import '../../data/datasources/remote/google_directions_client.dart';
import '../../data/datasources/remote/google_places_client.dart';
import '../../data/models/leg_estimate_dto.dart';
import '../../data/models/trip_dto.dart';
import '../../data/models/user_dto.dart';
import '../../data/models/vehicle_dto.dart';
import '../../data/repositories_impl/auth_repository_impl.dart';
import '../../data/repositories_impl/charging_repository_impl.dart';
import '../../data/repositories_impl/routing_repository_impl.dart';
import '../../data/repositories_impl/trips_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/charging_repository.dart';
import '../../domain/repositories/routing_repository.dart';
import '../../domain/repositories/trips_repository.dart';
import '../../domain/usecases/authenticate_user.dart';
import '../../domain/usecases/estimate_leg_energy.dart';
import '../../domain/usecases/get_compatible_chargers.dart';
import '../../domain/usecases/get_saved_trips.dart';
import '../../domain/usecases/plan_route.dart';
import '../../domain/usecases/save_trip.dart';
import '../services/logger_service.dart';
import '../services/location_service.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  // Get application documents directory for Isar database
  final dir = await getApplicationDocumentsDirectory();

  // Initialize Isar database
  final isar = await Isar.open(
    [
      VehicleDtoSchema,
      TripDtoSchema,
      UserDtoSchema,
      LegEstimateDtoSchema,
    ],
    directory: dir.path,
  );

  // Register core dependencies
  getIt.registerSingleton<Isar>(isar);
  getIt.registerSingleton<Logger>(Logger());
  getIt.registerSingleton<LoggerService>(LoggerService());
  getIt.registerLazySingleton<LocationService>(() => LocationService());

  // Register Dio with interceptors
  getIt.registerSingleton<Dio>(_createDio());

  // Register data sources
  getIt.registerLazySingleton<IsarDataSource>(
    () => IsarDataSource(isar: getIt<Isar>()),
  );

  getIt.registerLazySingleton<GooglePlacesClient>(
    () => GooglePlacesClient(
      dio: getIt<Dio>(),
      apiKey: _getGooglePlacesApiKey(),
      loggerService: getIt<LoggerService>(),
    ),
  );

  getIt.registerLazySingleton<GoogleDirectionsClient>(
    () => GoogleDirectionsClient(
      dio: getIt<Dio>(),
      apiKey: _getGoogleDirectionsApiKey(),
      loggerService: getIt<LoggerService>(),
    ),
  );

  // Register repositories
  getIt.registerLazySingleton<RoutingRepository>(
    () => RoutingRepositoryImpl(
      directionsClient: getIt<GoogleDirectionsClient>(),
      loggerService: getIt<LoggerService>(),
    ),
  );

  getIt.registerLazySingleton<ChargingRepository>(
    () => ChargingRepositoryImpl(
      placesClient: getIt<GooglePlacesClient>(),
      loggerService: getIt<LoggerService>(),
    ),
  );

  getIt.registerLazySingleton<TripsRepository>(
    () => TripsRepositoryImpl(
      localDataSource: getIt<IsarDataSource>(),
      loggerService: getIt<LoggerService>(),
    ),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      localDataSource: getIt<IsarDataSource>(),
      loggerService: getIt<LoggerService>(),
    ),
  );

  // Register use cases
  getIt.registerLazySingleton<PlanRoute>(
    () => PlanRoute(
      routingRepository: getIt<RoutingRepository>(),
      chargingRepository: getIt<ChargingRepository>(),
      loggerService: getIt<LoggerService>(),
    ),
  );

  getIt.registerLazySingleton<EstimateLegEnergy>(() => EstimateLegEnergy());

  getIt.registerLazySingleton<GetCompatibleChargers>(
    () => GetCompatibleChargers(
      chargingRepository: getIt<ChargingRepository>(),
      loggerService: getIt<LoggerService>(),
    ),
  );

  getIt.registerLazySingleton<SaveTrip>(
    () => SaveTrip(
      tripsRepository: getIt<TripsRepository>(),
      loggerService: getIt<LoggerService>(),
    ),
  );

  getIt.registerLazySingleton<GetSavedTrips>(
    () => GetSavedTrips(
      tripsRepository: getIt<TripsRepository>(),
      loggerService: getIt<LoggerService>(),
    ),
  );

  getIt.registerLazySingleton<AuthenticateUser>(
    () => AuthenticateUser(
      authRepository: getIt<AuthRepository>(),
      loggerService: getIt<LoggerService>(),
    ),
  );
}

/// Creates and configures Dio instance
Dio _createDio() {
  final dio = Dio();

  // Add interceptors
  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (object) => getIt<Logger>().d(object),
    ),
  );

  // Add timeout
  dio.options.connectTimeout = const Duration(seconds: 30);
  dio.options.receiveTimeout = const Duration(seconds: 30);

  return dio;
}

/// Gets Google Places API key - Direct configuration
String _getGooglePlacesApiKey() {
  // Using the same API key for all Google services
  return 'AIzaSyAwNAjDMvWL7po2DuM10tt_RxSRjJ2QdxM';
}

/// Gets Google Directions API key - Direct configuration
String _getGoogleDirectionsApiKey() {
  // Using the same API key for all Google services
  return 'AIzaSyAwNAjDMvWL7po2DuM10tt_RxSRjJ2QdxM';
}
