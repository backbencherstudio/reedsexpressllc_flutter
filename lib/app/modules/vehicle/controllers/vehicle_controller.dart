import 'package:get/get.dart';

import '../../../core/constants/enums.dart';
import '../../../core/utils/helper_utils.dart';
import '../../../data/models/truck_model.dart';
import '../../../routes/app_pages.dart';

class VehicleController extends GetxController {
  bool get isDriverUser => UserRole.isDriverRole(HelperUtils.userRole);

  bool get isCarrierUser => UserRole.isCarrierRole(HelperUtils.userRole);

  /// Demo assigned vehicle shown to drivers.
  final String driverLicensePlate = 'ABC-1234';
  final String driverTruckType = 'Box Truck';
  final String driverVin = 'Not assigned';
  final String driverModelMake = 'Freight';
  final String driverUnitNumber = '101 T-45';

  final trucks = <TruckModel>[
    const TruckModel(id: '1', unitNumber: '101 T-1471'),
    const TruckModel(id: '2', unitNumber: '102 T-2465'),
    const TruckModel(id: '3', unitNumber: '103 T-4453'),
  ].obs;

  void viewTruck(TruckModel truck) {
    // UI phase stub — truck details screen will open here.
  }

  void addTruck() {
    Get.toNamed(Routes.ADD_TRUCK);
  }

  void assignTruck() {
    Get.toNamed(Routes.ASSIGN_VEHICLE);
  }

  void addCreatedTruck(TruckModel truck) {
    trucks.add(truck);
  }
}
