import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../core/extensions/sizedbox_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_input_text_form_field.dart';
import '../../../core/widgets/app_text_style.dart';
import '../../../core/widgets/auth_header.dart';
import '../../../core/widgets/global_button.dart';
import '../../../core/widgets/global_loading.dart';
import '../../../core/widgets/global_tost.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            authHeader(
              title: "Join Us Today!",
              subTitle: "Create your account in a few simple steps.",
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
                        InputFieldWithLabel(
                          label: "E-mail",
                          hintText: "Enter your email",
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            if (!value.contains('@') || !value.contains('.')) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                        ),

                        15.height,
                        PasswordInputField(
                          controller: controller.passwordController,
                          label: "Password",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.toNamed(Routes.FORGOT_PASSWORD);
                              },
                              child: AppTextStyle(
                                text: "Forgot Password",
                                color: AppColors.primary,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        20.height,
                        Align(
                          alignment: Alignment.center,
                          child: Obx(() {
                            return controller.isLoading.value
                                ? GlobalLoading()
                                : globalButton(
                                    text: "Login",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppTextStyle(
                              text: "Don’t have an account?",
                              fontWeight: FontWeight.w400,
                              color: AppColors.hintText,
                            ),
                            5.width,
                            TextButton(
                              onPressed: () {
                                Get.toNamed(Routes.REGISTER);
                              },
                              child: AppTextStyle(
                                text: "Register",
                                color: AppColors.primary,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),

                        100.height,
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
