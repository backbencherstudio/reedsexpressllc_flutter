import 'package:get/get.dart';

import '../controllers/tema_member_details_controller.dart';

class TemaMemberDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TemaMemberDetailsController>(
      () => TemaMemberDetailsController(),
    );
  }
}
