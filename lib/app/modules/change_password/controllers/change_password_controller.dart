import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/utils/logger.dart';
import '../../../routes/app_pages.dart';

class ChangePasswordController extends GetxController {
  //TODO: Implement ChangePasswordController
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isPasswordVisible = false.obs;
  final isLoading = false.obs;

  Future<void> login() async {
    try {
      isLoading.value = true;
      await Future.delayed(Duration(seconds: 2));

      Get.offAllNamed(Routes.MAIN_PAGE);
    } catch (e) {
      Log.e(e);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
