import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/vehicle.dart';
import '../planning_bloc.dart';

/// Widget for the trip planning form
class PlanningFormWidget extends StatelessWidget {
  const PlanningFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Origin input
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Origin',
              hintText: 'Enter origin address',
              prefixIcon: Icon(Icons.my_location),
            ),
            onChanged: (value) {
              // TODO: Implement address search
            },
          ),
          const SizedBox(height: 16),

          // Destination input
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Destination',
              hintText: 'Enter destination address',
              prefixIcon: Icon(Icons.location_on),
            ),
            onChanged: (value) {
              // TODO: Implement address search
            },
          ),
          const SizedBox(height: 16),

          // Vehicle selection
          DropdownButtonFormField<Vehicle>(
            decoration: const InputDecoration(
              labelText: 'Vehicle',
              prefixIcon: Icon(Icons.directions_car),
            ),
            items: _getVehicleOptions().map((vehicle) {
              return DropdownMenuItem(
                value: vehicle,
                child: Text('${vehicle.brand} ${vehicle.model}'),
              );
            }).toList(),
            onChanged: (vehicle) {
              if (vehicle != null) {
                context
                    .read<PlanningBloc>()
                    .add(VehicleSelected(vehicle: vehicle));
              }
            },
          ),
          const SizedBox(height: 16),

          // Trip name
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Trip Name',
              hintText: 'Enter trip name',
              prefixIcon: Icon(Icons.label),
            ),
            onChanged: (value) {
              // TODO: Update trip name
            },
          ),
          const SizedBox(height: 24),

          // Plan trip button
          ElevatedButton(
            onPressed: () {
              context.read<PlanningBloc>().add(const PlanRequested());
            },
            child: const Text('Plan Trip'),
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
        id: 'byd_atto_3',
        name: 'BYD Atto 3',
        brand: 'BYD',
        model: 'Atto 3',
        year: 2023,
        usableBatteryKwh: 60,
        efficiencyWhPerKm: 160,
        supportedConnectors: [ConnectorType.ccs2, ConnectorType.type2],
        maxChargingPowerKw: 7,
        maxDcChargingPowerKw: 80,
      ),
    ];
  }
}
