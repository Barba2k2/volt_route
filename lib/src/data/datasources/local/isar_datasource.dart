import 'package:isar/isar.dart';
import '../../models/vehicle_dto.dart';
import '../../models/trip_dto.dart';
import '../../models/user_dto.dart';

/// Local data source using Isar database
class IsarDataSource {
  final Isar _isar;

  IsarDataSource({required Isar isar}) : _isar = isar;

  // Vehicle operations
  Future<void> saveVehicle(VehicleDto vehicle) async {
    await _isar.writeTxn(() async {
      await _isar.vehicleDtos.put(vehicle);
    });
  }

  Future<List<VehicleDto>> getAllVehicles() async {
    return await _isar.vehicleDtos.where().findAll();
  }

  Future<VehicleDto?> getVehicleById(String vehicleId) async {
    return await _isar.vehicleDtos
        .where()
        .vehicleIdEqualTo(vehicleId)
        .findFirst();
  }

  Future<void> deleteVehicle(String vehicleId) async {
    await _isar.writeTxn(() async {
      await _isar.vehicleDtos.where().vehicleIdEqualTo(vehicleId).deleteFirst();
    });
  }

  // Trip operations
  Future<void> saveTrip(TripDto trip) async {
    await _isar.writeTxn(() async {
      await _isar.tripDtos.put(trip);
    });
  }

  Future<List<TripDto>> getAllTrips({String? userId}) async {
    if (userId != null) {
      return await _isar.tripDtos.filter().userIdEqualTo(userId).findAll();
    }
    return await _isar.tripDtos.where().findAll();
  }

  Future<TripDto?> getTripById(String tripId) async {
    return await _isar.tripDtos.where().tripIdEqualTo(tripId).findFirst();
  }

  Future<void> updateTrip(TripDto trip) async {
    await _isar.writeTxn(() async {
      await _isar.tripDtos.put(trip);
    });
  }

  Future<void> deleteTrip(String tripId) async {
    await _isar.writeTxn(() async {
      await _isar.tripDtos.where().tripIdEqualTo(tripId).deleteFirst();
    });
  }

  // User operations
  Future<void> saveUser(UserDto user) async {
    await _isar.writeTxn(() async {
      await _isar.userDtos.put(user);
    });
  }

  Future<UserDto?> getCurrentUser() async {
    return await _isar.userDtos
        .where()
        .filter()
        .isCurrentUserEqualTo(true)
        .findFirst();
  }

  Future<UserDto?> getUserById(String userId) async {
    return await _isar.userDtos.where().userIdEqualTo(userId).findFirst();
  }

  Future<void> updateUser(UserDto user) async {
    await _isar.writeTxn(() async {
      await _isar.userDtos.put(user);
    });
  }

  Future<void> deleteUser(String userId) async {
    await _isar.writeTxn(() async {
      await _isar.userDtos.where().userIdEqualTo(userId).deleteFirst();
    });
  }

  Future<void> clearAllUsers() async {
    await _isar.writeTxn(() async {
      await _isar.userDtos.clear();
    });
  }
}
