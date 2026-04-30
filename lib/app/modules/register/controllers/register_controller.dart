import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:reedsexpressllc_flutter/app/core/utils/logger.dart';
import 'package:reedsexpressllc_flutter/app/routes/app_pages.dart';

import '../../../../gen/assets.gen.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/global_button.dart';

class RegisterController extends GetxController {
  final fullNameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final carrierNameController = TextEditingController();
  final dOTNumberController = TextEditingController();
  final mCNumberController = TextEditingController();

  final isPasswordVisible = false.obs;
  final isLoading = false.obs;

  Future<void> register() async {
    try {
      isLoading.value = true;
      await Future.delayed(Duration(seconds: 2));
      Get.dialog(
        barrierDismissible: false,
        CustomDialog(
          iconPath: Assets.icons.doneDoubleSticker,
          // iconHeight: 50.h,
          // iconWidth: 50.w,
          title: "Registration Successful!",
          subtitle:
              "Thank you for signing up. We're excited to have you with us. You can now start exploring all the features we have to offer.",
          bottomWidget: GlobalButton(
            onTap: () {
              Get.offAllNamed(Routes.MAIN_PAGE);
            },
            text: "Go to Home page",
          ),
        ),
      );
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
