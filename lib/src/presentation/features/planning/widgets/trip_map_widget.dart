import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../planning_bloc.dart';

/// Widget that displays a Google Map with the planned trip route and charging stations
class TripMapWidget extends StatefulWidget {
  final PlanningReady planningState;

  const TripMapWidget({
    super.key,
    required this.planningState,
  });

  @override
  State<TripMapWidget> createState() => _TripMapWidgetState();
}

class _TripMapWidgetState extends State<TripMapWidget> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Polyline> _polylines = {};
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _setupMapData();
  }

  @override
  void didUpdateWidget(TripMapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.planningState.trip != widget.planningState.trip) {
      _setupMapData();
    }
  }

  void _setupMapData() {
    _createPolylines();
    _createMarkers();
  }

  void _createPolylines() {
    final trip = widget.planningState.trip;

    // Convert domain LatLng to Google Maps LatLng
    final polylinePoints = trip.route.waypoints.map((point) {
      return LatLng(point.latitude, point.longitude);
    }).toList();

    _polylines = {
      Polyline(
        polylineId: const PolylineId('route'),
        points: polylinePoints,
        color: Colors.blue,
        width: 4,
        patterns: [],
      ),
    };
  }

  void _createMarkers() {
    final trip = widget.planningState.trip;
    final markers = <Marker>{};

    // Origin marker
    markers.add(
      Marker(
        markerId: const MarkerId('origin'),
        position: LatLng(trip.origin.latitude, trip.origin.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: const InfoWindow(
          title: 'Origin',
          snippet: 'Trip start point',
        ),
      ),
    );

    // Destination marker
    markers.add(
      Marker(
        markerId: const MarkerId('destination'),
        position: LatLng(trip.destination.latitude, trip.destination.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(
          title: 'Destination',
          snippet: 'Trip end point',
        ),
      ),
    );

    // Charging station markers
    for (int i = 0; i < trip.legEstimates.length; i++) {
      final legEstimate = trip.legEstimates[i];
      final charger = legEstimate.chargingStop;

      if (charger != null) {
        markers.add(
          Marker(
            markerId: MarkerId('charger_${charger.id}'),
            position: LatLng(charger.latitude, charger.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueYellow),
            infoWindow: InfoWindow(
              title: charger.name,
              snippet:
                  '⚡ ${charger.maxPowerKw?.toStringAsFixed(0) ?? "Unknown"} kW',
            ),
            onTap: () => _showChargerDetails(context, charger, legEstimate),
          ),
        );
      }
    }

    _markers = markers;
  }

  void _showChargerDetails(BuildContext context, charger, legEstimate) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              charger.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            if (charger.address != null) Text('📍 ${charger.address}'),
            if (charger.maxPowerKw != null)
              Text('⚡ Max Power: ${charger.maxPowerKw!.toStringAsFixed(0)} kW'),
            if (charger.rating != null)
              Text('⭐ Rating: ${charger.rating!.toStringAsFixed(1)}'),
            Text(
                '🔋 Energy to add: ${legEstimate.energyToAddKwh?.toStringAsFixed(1) ?? "Unknown"} kWh'),
            Text(
                '⏱️ Charging time: ${legEstimate.chargingTimeMinutes ?? "Unknown"} minutes'),
            Text(
                '💰 Cost: R\$ ${legEstimate.chargingCost?.toStringAsFixed(2) ?? "Unknown"}'),
            Text(
                '📊 Arrival SoC: ${legEstimate.arrivalSoCPercent.toStringAsFixed(1)}%'),
            Text(
                '📈 Departure SoC: ${legEstimate.departureSoCPercent.toStringAsFixed(1)}%'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final trip = widget.planningState.trip;

    return Container(
      height: 400,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            _animateToShowRoute();
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(trip.origin.latitude, trip.origin.longitude),
            zoom: 10,
          ),
          polylines: _polylines,
          markers: _markers,
          mapType: MapType.normal,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: true,
          compassEnabled: true,
          trafficEnabled: false,
        ),
      ),
    );
  }

  Future<void> _animateToShowRoute() async {
    final controller = await _controller.future;
    final trip = widget.planningState.trip;

    // Calculate bounds to show entire route
    double minLat = trip.origin.latitude;
    double maxLat = trip.origin.latitude;
    double minLng = trip.origin.longitude;
    double maxLng = trip.origin.longitude;

    // Include all waypoints in bounds calculation
    for (final point in trip.route.waypoints) {
      minLat = minLat < point.latitude ? minLat : point.latitude;
      maxLat = maxLat > point.latitude ? maxLat : point.latitude;
      minLng = minLng < point.longitude ? minLng : point.longitude;
      maxLng = maxLng > point.longitude ? maxLng : point.longitude;
    }

    // Include charging stations in bounds
    for (final legEstimate in trip.legEstimates) {
      final charger = legEstimate.chargingStop;
      if (charger != null) {
        minLat = minLat < charger.latitude ? minLat : charger.latitude;
        maxLat = maxLat > charger.latitude ? maxLat : charger.latitude;
        minLng = minLng < charger.longitude ? minLng : charger.longitude;
        maxLng = maxLng > charger.longitude ? maxLng : charger.longitude;
      }
    }

    // Add padding to bounds
    final padding = 0.01; // ~1km padding
    final bounds = LatLngBounds(
      southwest: LatLng(minLat - padding, minLng - padding),
      northeast: LatLng(maxLat + padding, maxLng + padding),
    );

    controller.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 50.0),
    );
  }
}
