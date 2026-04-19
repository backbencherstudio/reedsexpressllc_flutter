import 'package:get/get.dart';

import '../controllers/active_load_list_controller.dart';

class ActiveLoadListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActiveLoadListController>(
      () => ActiveLoadListController(),
    );
  }
}
