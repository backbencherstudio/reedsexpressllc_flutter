import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../core/extensions/sizedbox_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/app_input_text_form_field.dart';
import '../../../widgets/appbar_title.dart';
import '../../../widgets/auth_header.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/global_button.dart';
import '../../../widgets/global_loading.dart';
import '../../../widgets/global_tost.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});
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
              title: "Enter Your Email",
              subTitle:
                  "Please enter the email address associated with your account. We’ll send you a link to reset your password and regain access.",
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
