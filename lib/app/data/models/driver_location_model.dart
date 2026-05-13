class DriverLocationModel {
  final int driverId;
  final double lat;
  final double lng;
  final String timestamp;
  final String address;

  DriverLocationModel({
    required this.driverId,
    required this.lat,
    required this.lng,
    required this.timestamp,
    required this.address,
  });

  factory DriverLocationModel.fromMap(Map<String, dynamic> map) {
    return DriverLocationModel(
      driverId: map['driverId'],
      lat: (map['lat'] as num).toDouble(),
      lng: (map['lng'] as num).toDouble(),
      timestamp: map['timestamp'],
      address: map['address'] ?? 'Unknown address',
    );
  }
}