import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Service for handling GPS location and positioning
class LocationService {
  /// Gets the current location of the user with iOS optimization
  Future<LatLng?> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled');
      }

      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied');
      }

      // Try to get last known location first (faster)
      Position? lastKnownPosition = await Geolocator.getLastKnownPosition();
      if (lastKnownPosition != null) {
        // Check if the last known position is recent enough (within 5 minutes)
        final now = DateTime.now();
        final locationTime = lastKnownPosition.timestamp;
        if (now.difference(locationTime).inMinutes < 5) {
          return LatLng(
            lastKnownPosition.latitude,
            lastKnownPosition.longitude,
          );
        }
      }

      // If no recent cached location, get current position with iOS-optimized settings
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium, // Less demanding than high
        timeLimit: const Duration(seconds: 20), // More time for iOS
        forceAndroidLocationManager: false,
      );

      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      // Return null if location cannot be obtained
      return null;
    }
  }

  /// Checks if location permissions are granted
  Future<bool> hasLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  /// Requests location permissions from the user
  Future<bool> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }
}
