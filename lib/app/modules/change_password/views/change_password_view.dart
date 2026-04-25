import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../core/extensions/sizedbox_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_input_text_form_field.dart';
import '../../../core/widgets/appbar_title.dart';
import '../../../core/widgets/auth_header.dart';
import '../../../core/widgets/custom_icon_button.dart';
import '../../../core/widgets/global_button.dart';
import '../../../core/widgets/global_loading.dart';
import '../../../core/widgets/global_tost.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.background,
        elevation: 0,
        toolbarHeight: 50.h,
        centerTitle: true,
        title: appbarTitle(text: 'Forgot Password'),
        leading: Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: const CustomIconButton(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            authHeader(
              height: 150.h,
              title: "Create New Password",
              subTitle:
                  "Choose a strong new password for your account. Make sure it’s unique and different from your previous passwords to keep your account secure.",
            ),

            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        25.height,
                        PasswordInputField(
                              controller: controller.passwordController,
                              label: "Password",
                              hintText: "Enter your new password",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is required';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            )
                            .animate()
                            .fadeIn(delay: 400.ms, duration: 400.ms)
                            .slideY(begin: 0.1),
                        15.height,
                        PasswordInputField(
                              controller: controller.confirmPasswordController,
                              label: "Confirm Password",
                              hintText: "Retype your password",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please confirm your password";
                                }
                                if (value !=
                                    controller.passwordController.text) {
                                  return "Passwords do not match";
                                }
                                return null;
                              },
                            )
                            .animate()
                            .fadeIn(delay: 400.ms, duration: 400.ms)
                            .slideY(begin: 0.1),

                        20.height,
                        Align(
                          alignment: Alignment.center,
                          child: Obx(() {
                            return controller.isLoading.value
                                ? GlobalLoading()
                                : globalButton(
                                    text: "Send Code",
                                    onTap: () {
                                      if (formKey.currentState!.validate()) {
                                        controller.login();
                                      } else {
                                        globalToast(
                                          message:
                                              "Please fix all errors in the form",
                                        );
                                      }
                                    },
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  );
                          }),
                        ),
                        10.height,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
