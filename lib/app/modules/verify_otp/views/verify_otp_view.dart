import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../../core/extensions/sizedbox_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/appbar_title.dart';
import '../../../core/widgets/auth_header.dart';
import '../../../core/widgets/custom_icon_button.dart';
import '../../../core/widgets/global_button.dart';
import '../../../core/widgets/global_loading.dart';
import '../../../core/widgets/global_tost.dart';
import '../controllers/verify_otp_controller.dart';

class VerifyOtpView extends GetView<VerifyOtpController> {
  const VerifyOtpView({super.key});

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

                        Align(
                          alignment: Alignment.center,
                          child: buildPinPut(controller.otpTextController),
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
                                        controller.verifyOTP();
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

  Widget buildPinPut(TextEditingController otpTextController) {
    final defaultPinTheme = PinTheme(
      width: 50.w,
      height: 50.h,
      textStyle: GoogleFonts.poppins(
        textStyle: TextStyle(
          fontSize: 20.sp,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10.r),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.primaryDisable),
      borderRadius: BorderRadius.circular(10.r),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color(0xFFe9ecef),
      ),
    );

    return Pinput(
      controller: otpTextController,
      length: 6,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
      showCursor: true,
      // onCompleted: (pin) => controller.otp.value = pin,
    );
  }
}
