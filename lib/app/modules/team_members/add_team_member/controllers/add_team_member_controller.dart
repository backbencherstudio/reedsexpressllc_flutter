import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/routes/app_pages.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_dialog.dart';
import 'package:reedsexpressllc_flutter/app/widgets/global_button.dart';
import 'package:reedsexpressllc_flutter/gen/assets.gen.dart';

import '../../../../widgets/global_tost.dart';

class AddTeamMemberController extends GetxController {
  final driverNameController = TextEditingController(text: 'Rock Climber');
  final emailController = TextEditingController(
    text: 'abc@transport.gmail.com',
  );
  final passwordController = TextEditingController(text: '12345678');

  final obscurePassword = true.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> sendInvitation() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 600));
    isLoading.value = false;

    Get.dialog(
      barrierDismissible: false,
      CustomDialog(
        iconPath: Assets.icons.doneDoubleSticker,
        // iconHeight: 50.h,
        // iconWidth: 50.w,
        title: "Invitation sent!",
        subtitle: "Your invitation has been sent successfully.",
        bottomWidget: GlobalButton(
          onTap: () {
            Get.back(); // close dialog
            Get.offAllNamed(Routes.MAIN_PAGE);
          },
          text: "Go to Home page",
        ),
      ),
    );
  }

  @override
  void onClose() {
    driverNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
