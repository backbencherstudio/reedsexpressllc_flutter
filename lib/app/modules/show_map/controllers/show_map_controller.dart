import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:reedsexpressllc_flutter/app/data/models/driver_location_model.dart';

class ShowMapController extends GetxController {
  final RxList<DriverLocationModel> drivers = <DriverLocationModel>[].obs;
  final Rx<LatLng> mapCenter = LatLng(23.8103, 90.4125).obs;
  final RxDouble mapZoom = 14.0.obs;

  // Simulated backend response with address field added
  final List<Map<String, dynamic>> _rawDrivers = [
    {
      "driverId": 123,
      "lat": 23.8103,
      "lng": 90.4125,
      "timestamp": "2026-05-13T12:00:00Z",
      "address": "Mirpur-10, Dhaka, Bangladesh",
    },
    {
      "driverId": 124,
      "lat": 23.8150,
      "lng": 90.4180,
      "timestamp": "2026-05-13T12:02:00Z",
      "address": "Pallabi, Mirpur, Dhaka, Bangladesh",
    },
    {
      "driverId": 125,
      "lat": 23.8075,
      "lng": 90.4090,
      "timestamp": "2026-05-13T12:05:00Z",
      "address": "Mirpur-1, Dhaka, Bangladesh",
    },
  ];

  @override
  void onInit() {
    super.onInit();
    _loadDrivers();
  }

  void _loadDrivers() {
    drivers.value = _rawDrivers
        .map((map) => DriverLocationModel.fromMap(map))
        .toList();
  }

  // Call this when tapping a driver card to center map
  void focusOnDriver(DriverLocationModel driver) {
    mapCenter.value = LatLng(driver.lat, driver.lng);
    mapZoom.value = 16.0;
  }

  @override
  void onClose() {
    super.onClose();
  }
}