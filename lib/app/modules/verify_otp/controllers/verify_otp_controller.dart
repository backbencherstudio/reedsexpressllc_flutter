import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/utils/logger.dart';
import '../../../routes/app_pages.dart';

class VerifyOtpController extends GetxController {
  //TODO: Implement VerifyOtpController

  final otpTextController = TextEditingController();
  final isLoading = false.obs;

  Future<void> verifyOTP() async {
    try {
      isLoading.value = true;
      await Future.delayed(Duration(seconds: 2));

      Get.toNamed(Routes.CHANGE_PASSWORD);
    } catch (e) {
      Log.e(e);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    otpTextController.dispose();
  }


}
