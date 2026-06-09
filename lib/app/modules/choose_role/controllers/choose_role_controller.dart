import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/utils/logger.dart';

import '../../../core/constants/enums.dart';
import '../../../core/utils/helper_utils.dart';
import '../../../routes/app_pages.dart';

class ChooseRoleController extends GetxController {
  final selectedRole = UserRole.carrier.obs;

  void selectRole(UserRole role) {
    selectedRole.value = role;
  }

  void saveRole() {
    HelperUtils.isDriver = selectedRole.value == UserRole.driver;
    HelperUtils.userRole = selectedRole.value.name;
  }

  void onNext() {
    saveRole();
    Get.toNamed(Routes.LOGIN);
  }
}
