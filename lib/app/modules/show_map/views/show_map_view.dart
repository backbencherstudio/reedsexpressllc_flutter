import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:reedsexpressllc_flutter/app/data/models/driver_location_model.dart';
import '../controllers/show_map_controller.dart';

class ShowMapView extends GetView<ShowMapController> {
  const ShowMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Locations'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // ── Map Section ──────────────────────────────────────
          Expanded(
            flex: 3,
            child: Obx(() {
              return FlutterMap(
                options: MapOptions(
                  initialCenter: controller.mapCenter.value,
                  initialZoom: controller.mapZoom.value,
                ),
                children: [
                  // OpenStreetMap tile layer — completely free, no key needed
                  TileLayer(
                    urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.reedsexpressllc.app',
                  ),
                  // Driver markers
                  MarkerLayer(
                    markers: controller.drivers.map((driver) {
                      return Marker(
                        point: LatLng(driver.lat, driver.lng),
                        width: 60,
                        height: 60,
                        child: _DriverMarker(driver: driver),
                      );
                    }).toList(),
                  ),
                ],
              );
            }),
          ),

          // ── Driver List Section ──────────────────────────────
          Expanded(
            flex: 2,
            child: Obx(() {
              return ListView.separated(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
                itemCount: controller.drivers.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final driver = controller.drivers[index];
                  return _DriverCard(
                    driver: driver,
                    onTap: () => controller.focusOnDriver(driver),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

// ── Driver Marker Widget ─────────────────────────────────────────────────────

class _DriverMarker extends StatelessWidget {
  final DriverLocationModel driver;

  const _DriverMarker({required this.driver});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.blue.shade700,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '#${driver.driverId}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Icon(Icons.location_pin, color: Colors.red, size: 32),
      ],
    );
  }
}

// ── Driver Card Widget ───────────────────────────────────────────────────────

class _DriverCard extends StatelessWidget {
  final DriverLocationModel driver;
  final VoidCallback onTap;

  const _DriverCard({required this.driver, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 6,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue.shade700,
              child: Text(
                '${driver.driverId}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Driver #${driver.driverId}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 12, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          driver.address,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Lat: ${driver.lat.toStringAsFixed(4)}, '
                        'Lng: ${driver.lng.toStringAsFixed(4)}',
                    style: const TextStyle(
                        fontSize: 11, color: Colors.blueGrey),
                  ),
                ],
              ),
            ),
            const Icon(Icons.my_location, color: Colors.blue, size: 18),
          ],
        ),
      ),
    );
  }
}