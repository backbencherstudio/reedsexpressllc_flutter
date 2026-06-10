import 'package:get/get.dart';

import '../controllers/carrier_info_docs_controller.dart';

class CarrierInfoDocsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CarrierInfoDocsController>(
      () => CarrierInfoDocsController(),
    );
  }
}
