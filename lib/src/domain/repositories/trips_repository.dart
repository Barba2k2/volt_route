import 'package:result_dart/result_dart.dart';
import '../entities/trip.dart';
import '../entities/trip_statistics.dart';

/// Abstract repository for trip operations
abstract class TripsRepository {
  /// Saves a trip
  Future<Result<Trip>> saveTrip(Trip trip);

  /// Gets all saved trips for a user
  Future<Result<List<Trip>>> getSavedTrips({
    String? userId,
  });

  /// Gets a specific trip by ID
  Future<Result<Trip>> getTripById(String tripId);

  /// Updates an existing trip
  Future<Result<Trip>> updateTrip(Trip trip);

  /// Deletes a trip
  Future<Result<void>> deleteTrip(String tripId);

  /// Duplicates a trip
  Future<Result<Trip>> duplicateTrip(String tripId);

  /// Gets trip statistics for a user
  Future<Result<TripStatistics>> getTripStatistics({
    String? userId,
  });
}
