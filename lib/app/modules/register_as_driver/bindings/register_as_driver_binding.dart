import 'package:get/get.dart';

import '../controllers/register_as_driver_controller.dart';

class RegisterAsDriverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterAsDriverController>(
      () => RegisterAsDriverController(),
    );
  }
}
