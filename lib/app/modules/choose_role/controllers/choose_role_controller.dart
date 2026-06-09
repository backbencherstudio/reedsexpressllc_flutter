import 'package:get/get.dart';

import '../../../core/constants/enums.dart';
import '../../../core/utils/helper_utils.dart';
import '../../../routes/app_pages.dart';

class ChooseRoleController extends GetxController {
  final selectedRole = UserRole.carrier.obs;

  void selectRole(UserRole role) {
    selectedRole.value = role;
  }

  void saveRole() {
    HelperUtils.userRole = selectedRole.value.name;
  }

  void onNext() {
    saveRole();
    Get.toNamed(Routes.LOGIN);
  }
}
