import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/utils/logger.dart';
import '../../../routes/app_pages.dart';

class ForgotPasswordController extends GetxController {
  //TODO: Implement ForgotPasswordController

  final emailController = TextEditingController();

  final isPasswordVisible = false.obs;
  final isLoading = false.obs;

  Future<void> login() async {
    try {
      isLoading.value = true;
      await Future.delayed(Duration(seconds: 2));

      Get.toNamed(Routes.VERIFY_OTP);
    } catch (e) {
      Log.e(e);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
