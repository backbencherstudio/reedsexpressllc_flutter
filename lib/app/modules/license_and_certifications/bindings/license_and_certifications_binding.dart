import 'package:get/get.dart';

import '../controllers/license_and_certifications_controller.dart';

class LicenseAndCertificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LicenseAndCertificationsController>(
      () => LicenseAndCertificationsController(),
    );
  }
}
