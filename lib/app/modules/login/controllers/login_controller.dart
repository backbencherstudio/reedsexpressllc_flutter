import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/utils/logger.dart' show Log;

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isPasswordVisible = false.obs;
  final isLoading = false.obs;

  Future<void> login() async {
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
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
