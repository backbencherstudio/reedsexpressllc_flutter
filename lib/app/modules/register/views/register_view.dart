import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/extensions/sizedbox_extension.dart';
import 'package:reedsexpressllc_flutter/app/core/theme/app_colors.dart';
import 'package:reedsexpressllc_flutter/app/widgets/app_input_text_form_field.dart';
import 'package:reedsexpressllc_flutter/app/widgets/app_text_style.dart';

import 'package:reedsexpressllc_flutter/app/widgets/auth_header.dart';
import 'package:reedsexpressllc_flutter/app/widgets/global_loading.dart';
import 'package:reedsexpressllc_flutter/app/routes/app_pages.dart';
import 'package:reedsexpressllc_flutter/app/widgets/global_button.dart';

import '../../../widgets/global_tost.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

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
                          controller: controller.fullNameController,
                          label: "Full Name",
                          hintText: "Your full name",
                          keyboardType: TextInputType.text,

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                        ),
                        15.height,
                        InputFieldWithLabel(
                          controller: controller.numberController,
                          label: "Number",
                          hintText: "Your contract number",
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                        ),
                        15.height,
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
                        15.height,
                        InputFieldWithLabel(
                          controller: controller.carrierNameController,
                          label: "Carrier Name",
                          hintText: "Enter Carrier Name ",
                          keyboardType: TextInputType.text,

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                        ),
                        15.height,
                        InputFieldWithLabel(
                          controller: controller.dOTNumberController,
                          label: "DOT Number",
                          hintText: "Enter DOT number",
                          keyboardType: TextInputType.text,

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                        ),
                        15.height,
                        InputFieldWithLabel(
                          controller: controller.mCNumberController,
                          label: "MC Number",
                          hintText: "Enter MC number",
                          keyboardType: TextInputType.text,

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                        ),
                        40.height,
                        Align(
                          alignment: Alignment.center,
                          child: Obx(() {
                            return controller.isLoading.value
                                ? GlobalLoading()
                                : GlobalButton(
                                    text: "Register",
                                    onTap: () {
                                      if (formKey.currentState!.validate()) {
                                        Get.toNamed(Routes.UPLOAD_DOCUMENTS);
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
                              text: "Already have an account?",
                              fontWeight: FontWeight.w400,
                              color: AppColors.hintText,
                            ),
                            5.width,
                            TextButton(
                              onPressed: () {
                                Get.toNamed(Routes.LOGIN);
                              },
                              child: AppTextStyle(
                                text: "Login",
                                color: AppColors.primary,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        30.height,
                        Align(
                          alignment: Alignment.center,
                          child: AppTextStyle(
                            text: "By registering you agree to ",
                            fontWeight: FontWeight.w400,
                            color: AppColors.hintText,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: AppTextStyle(
                                text: "Terms & Privacy ",
                                fontWeight: FontWeight.w400,
                                color: AppColors.primary,
                              ),
                            ),
                            AppTextStyle(
                              text: "and",
                              fontWeight: FontWeight.w400,
                              color: AppColors.hintText,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: AppTextStyle(
                                text: "Policy",
                                fontWeight: FontWeight.w400,
                                color: AppColors.primary,
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
