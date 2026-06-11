import 'package:get/get.dart';

import '../controllers/assign_vehicle_controller.dart';

class AssignVehicleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssignVehicleController>(
      () => AssignVehicleController(),
    );
  }
}
