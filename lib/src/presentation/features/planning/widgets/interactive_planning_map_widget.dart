import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/DI/dependency_injector.dart';
import '../../../../core/services/location_service.dart';
import '../../../../data/datasources/remote/google_places_client.dart'
    hide LatLng;
import '../../../../domain/entities/vehicle.dart';
import '../planning_bloc.dart';

/// Interactive map widget for trip planning similar to Google Maps/Waze
class InteractivePlanningMapWidget extends StatefulWidget {
  const InteractivePlanningMapWidget({super.key});

  @override
  State<InteractivePlanningMapWidget> createState() =>
      _InteractivePlanningMapWidgetState();
}

class _InteractivePlanningMapWidgetState
    extends State<InteractivePlanningMapWidget> {
  late GoogleMapController _mapController;
  final LocationService _locationService = getIt<LocationService>();
  final GooglePlacesClient _placesClient = getIt<GooglePlacesClient>();

  Set<Marker> _markers = {};
  LatLng? _currentLocation;
  bool _isLoadingLocation = true;

  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _tripNameController = TextEditingController();
  Vehicle? _selectedVehicle;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _destinationController.dispose();
    _tripNameController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final location = await _locationService.getCurrentLocation();
      if (location != null && mounted) {
        setState(() {
          _currentLocation = location;
          _isLoadingLocation = false;
          _markers.add(
            Marker(
              markerId: const MarkerId('current_location'),
              position: location,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
              infoWindow: const InfoWindow(title: 'Your Location'),
            ),
          );
        });

        // Update PlanningBloc with current location as origin
        context.read<PlanningBloc>().add(
              CurrentLocationObtained(
                latitude: location.latitude,
                longitude: location.longitude,
              ),
            );

        // Animate camera to current location
        _animateToLocation(location);
      }
    } catch (e) {
      setState(() {
        _isLoadingLocation = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not get your location: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _animateToLocation(LatLng location) async {
    await _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(location, 15),
    );
  }

  void _onMapTap(LatLng position) {
    setState(() {
      // Update destination marker
      _markers.removeWhere((marker) => marker.markerId.value == 'destination');
      _markers.add(
        Marker(
          markerId: const MarkerId('destination'),
          position: position,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: const InfoWindow(title: 'Destination'),
        ),
      );
    });

    // Update PlanningBloc with destination
    context.read<PlanningBloc>().add(
          DestinationChanged(
            latitude: position.latitude,
            longitude: position.longitude,
          ),
        );
  }

  Future<void> _searchAndSetDestination(String address) async {
    if (address.isEmpty) return;

    try {
      final location = await _placesClient.geocodeAddress(address);
      if (location != null && mounted) {
        // Convert GooglePlacesClient LatLng to Google Maps LatLng
        final mapsLocation = LatLng(location.latitude, location.longitude);
        _onMapTap(mapsLocation);
        _animateToLocation(mapsLocation);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not find destination: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildTopControls() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Trip Name
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _tripNameController,
              decoration: const InputDecoration(
                hintText: 'Trip Name',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.label, color: Colors.grey),
              ),
              onChanged: (value) {
                context
                    .read<PlanningBloc>()
                    .add(TripNameChanged(tripName: value));
              },
            ),
          ),
          const SizedBox(height: 8),

          // Destination Search
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _destinationController,
              decoration: const InputDecoration(
                hintText: 'Where to?',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                suffixIcon: Icon(Icons.my_location, color: Colors.grey),
              ),
              onSubmitted: _searchAndSetDestination,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Vehicle Selection
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Vehicle>(
                value: _selectedVehicle,
                hint: const Text('Select your vehicle'),
                icon: const Icon(Icons.directions_car),
                onChanged: (Vehicle? vehicle) {
                  setState(() {
                    _selectedVehicle = vehicle;
                  });
                  if (vehicle != null) {
                    context
                        .read<PlanningBloc>()
                        .add(VehicleSelected(vehicle: vehicle));
                  }
                },
                items: _getVehicleOptions().map((vehicle) {
                  return DropdownMenuItem<Vehicle>(
                    value: vehicle,
                    child: Text('${vehicle.brand} ${vehicle.model}'),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Plan Route Button
          BlocBuilder<PlanningBloc, PlanningState>(
            builder: (context, state) {
              final canPlan = state is PlanningInitial &&
                  state.originLat != null &&
                  state.destinationLat != null &&
                  state.vehicle != null;

              return SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: canPlan
                      ? () => context
                          .read<PlanningBloc>()
                          .add(const PlanRequested())
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.navigation),
                      SizedBox(width: 8),
                      Text(
                        'Plan Route',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  List<Vehicle> _getVehicleOptions() {
    return [
      const Vehicle(
        id: 'tesla_model_3',
        name: 'Tesla Model 3',
        brand: 'Tesla',
        model: 'Model 3',
        year: 2023,
        usableBatteryKwh: 75,
        efficiencyWhPerKm: 150,
        supportedConnectors: [ConnectorType.tesla, ConnectorType.ccs2],
        maxChargingPowerKw: 11,
        maxDcChargingPowerKw: 250,
      ),
      const Vehicle(
        id: 'volvo_xc40_recharge',
        name: 'Volvo XC40 Recharge',
        brand: 'Volvo',
        model: 'XC40 Recharge',
        year: 2023,
        usableBatteryKwh: 78,
        efficiencyWhPerKm: 180,
        supportedConnectors: [ConnectorType.ccs2, ConnectorType.type2],
        maxChargingPowerKw: 11,
        maxDcChargingPowerKw: 150,
      ),
      const Vehicle(
        id: 'bmw_i4',
        name: 'BMW i4',
        brand: 'BMW',
        model: 'i4',
        year: 2023,
        usableBatteryKwh: 83,
        efficiencyWhPerKm: 165,
        supportedConnectors: [ConnectorType.ccs2, ConnectorType.type2],
        maxChargingPowerKw: 11,
        maxDcChargingPowerKw: 200,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingLocation) {
      return Container(
        color: Colors.grey.shade50,
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                strokeWidth: 3,
              ),
              SizedBox(height: 24),
              Text(
                'Getting your location...',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),
              Text(
                'This may take a few seconds on first use',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    if (_currentLocation == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_off,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              'Could not access your location',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please enable location services and try again',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    return Stack(
      children: [
        // Google Map
        GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
          },
          initialCameraPosition: CameraPosition(
            target: _currentLocation!,
            zoom: 15,
          ),
          markers: _markers,
          onTap: _onMapTap,
          myLocationEnabled: false, // We handle this manually
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
        ),

        // Top Controls (Search & Trip Name)
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: _buildTopControls(),
        ),

        // Current Location Button
        Positioned(
          right: 16,
          bottom: 180,
          child: FloatingActionButton(
            mini: true,
            onPressed: () {
              if (_currentLocation != null) {
                _animateToLocation(_currentLocation!);
              }
            },
            backgroundColor: Colors.white,
            child: const Icon(Icons.my_location, color: Colors.blue),
          ),
        ),

        // Bottom Controls (Vehicle & Plan Button)
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _buildBottomControls(),
        ),
      ],
    );
  }
}
