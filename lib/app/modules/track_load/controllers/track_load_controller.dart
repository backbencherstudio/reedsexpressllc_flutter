import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/constants/enums.dart';
import '../../../data/models/tracking_status_model.dart';

class TrackLoadController extends GetxController {
  final mapController = MapController();

  late final LoadDetailsModel load;

  /// Demo coordinates for Memphis, TN → Atlanta, GA route.
  final LatLng origin = const LatLng(35.1495, -90.0490);
  final LatLng destination = const LatLng(33.7490, -84.3880);
  final LatLng currentPosition = const LatLng(34.5893, -87.7846);

  final int etaMinutes = 34;

  final List<LatLng> nearbyDrivers = const [
    LatLng(34.72, -87.95),
    LatLng(34.51, -87.62),
  ];

  List<LatLng> get routePoints => _interpolateRoute(origin, destination, 30);

  LatLng get etaMarkerPoint => LatLng(
        (currentPosition.latitude + destination.latitude) / 2,
        (currentPosition.longitude + destination.longitude) / 2,
      );

  String get originCity => _cityFromAddress(load.pickupAddress);
  String get originStreet => _streetFromAddress(load.pickupAddress);
  String get destinationCity => _cityFromAddress(load.deliveryAddress);
  String get destinationStreet => _streetFromAddress(load.deliveryAddress);

  @override
  void onInit() {
    super.onInit();
    load = Get.arguments as LoadDetailsModel? ?? _fallbackLoad;
  }

  void fitRouteOnMap() {
    final bounds = LatLngBounds.fromPoints([
      origin,
      destination,
      currentPosition,
      ...routePoints,
    ]);

    mapController.fitCamera(
      CameraFit.bounds(
        bounds: bounds,
        padding: const EdgeInsets.only(
          top: 80,
          bottom: 280,
          left: 32,
          right: 32,
        ),
      ),
    );
  }

  List<LatLng> _interpolateRoute(LatLng start, LatLng end, int steps) {
    return List.generate(steps + 1, (index) {
      final t = index / steps;
      return LatLng(
        start.latitude + (end.latitude - start.latitude) * t,
        start.longitude + (end.longitude - start.longitude) * t,
      );
    });
  }

  String _cityFromAddress(String address) {
    final parts = address.split(',').map((part) => part.trim()).toList();
    if (parts.length >= 2) {
      return '${parts[0]}, ${parts[1]}';
    }
    return parts.first;
  }

  String _streetFromAddress(String address) {
    final parts = address.split(',').map((part) => part.trim()).toList();
    if (parts.length <= 2) return address;
    return parts.sublist(2).join(', ');
  }

  static const LoadDetailsModel _fallbackLoad = LoadDetailsModel(
    loadId: 'RX-2847',
    date: '24 Aug, 2026',
    status: LoadStatus.inTransit,
    miles: 247,
    pay: 860,
    pickupCompany: 'Delta Housing LTD',
    pickupAddress: 'Memphis, TN, 2200 Airways Blvd, TN 33116',
    pickupTime: '10:00 AM',
    pickupDate: '24 Aug, 2026',
    deliveryCompany: 'Crimson Garage',
    deliveryAddress: 'Atlanta, GA, 3900 Rd, Atlanta, GA 30380',
    deliveryTime: '10:00 AM',
    deliveryDate: '24 Aug, 2026',
    brokerName: 'Johnny Harris',
    brokerReference: 'Reference No. 123- 12324ABC',
    brokerEmail: 'broker@gmail.com',
    brokerPhone: '+33 2132345',
    additionalNotes: '',
    trackingSteps: [],
    uploadedDocuments: [],
  );
}
