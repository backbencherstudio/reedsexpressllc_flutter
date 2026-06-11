import 'package:get/get.dart';

import '../controllers/add_truck_controller.dart';

class AddTruckBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTruckController>(
      () => AddTruckController(),
    );
  }
}
