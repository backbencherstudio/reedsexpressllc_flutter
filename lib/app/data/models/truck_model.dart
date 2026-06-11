class TruckModel {
  final String id;
  final String unitNumber;
  final String licensePlate;
  final String truckType;
  final String vin;
  final String modelMake;
  final bool isAssigned;

  const TruckModel({
    required this.id,
    required this.unitNumber,
    this.licensePlate = '',
    this.truckType = '',
    this.vin = '',
    this.modelMake = '',
    this.isAssigned = true,
  });
}
