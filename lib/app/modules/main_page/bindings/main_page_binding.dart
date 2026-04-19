import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/modules/home/controllers/home_controller.dart';

import '../controllers/main_page_controller.dart';

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(),permanent: true);
    Get.lazyPut<MainPageController>(
      () => MainPageController(),
    );
  }
}
