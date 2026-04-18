import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:reedsexpressllc_flutter/app/core/utils/logger.dart';


class RegisterController extends GetxController {
  final fullNameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isPasswordVisible = false.obs;
  final isLoading = false.obs;

  Future<void> register() async {
    try {
      isLoading.value = true;
      await Future.delayed(Duration(seconds: 2));
    } catch (e) {
      Log.e(e);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    numberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
