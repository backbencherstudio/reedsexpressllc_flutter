import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/constants/enums.dart';
import 'package:reedsexpressllc_flutter/app/core/utils/helper_utils.dart';
import 'package:reedsexpressllc_flutter/app/routes/app_pages.dart';

import '../../../core/utils/logger.dart' show Log;

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isPasswordVisible = false.obs;
  final isLoading = false.obs;

  Future<void> login() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));

      await HelperUtils.setUser(
        userId: 'demo_user_001',
        token: 'demo_access_token',
        role: HelperUtils.userRole.isNotEmpty
            ? HelperUtils.userRole
            : UserRole.driver.name,
      );

      Get.toNamed(Routes.UPLOAD_DOCUMENTS);
    } catch (e) {
      Log.e(e);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
