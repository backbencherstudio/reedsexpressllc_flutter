import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/extensions/sizedbox_extension.dart';
import 'package:reedsexpressllc_flutter/app/widgets/app_text_style.dart';
import 'package:reedsexpressllc_flutter/app/widgets/global_button.dart';
import 'package:reedsexpressllc_flutter/app/routes/app_pages.dart';

import '../../../../gen/assets.gen.dart';
import '../controllers/onboard_controller.dart';

class OnboardView extends GetView<OnboardController> {
  const OnboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.mapImage.path),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          // Dark overlay to create shadow/contrast over the map
          decoration: BoxDecoration(color: Colors.black.withAlpha(180)),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),

                // Logo with shadow
                Image.asset(
                  Assets.logos.appLogo.path,
                  height: 170.h,
                  width: 150.w,
                ),

                // Tagline text with shadow
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: AppTextStyle(
                    text: "Your All-in-One Transportation \nSolution",
                    textAlign: TextAlign.center,
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),

                const Spacer(),

                // Buttons at bottom
                Padding(
                  padding: EdgeInsets.only(
                    left: 24.w,
                    right: 24.w,
                    bottom: 50.h,
                  ),
                  child: Column(
                    children: [
                      GlobalButton(
                        onTap: () {
                          Get.offAllNamed(Routes.REGISTER);
                        },
                        text: "Sign Up",
                        color: Colors.white,
                        textColor: Colors.black,
                      ),
                      10.height,
                      GlobalButton(
                        onTap: () {
                          Get.offAllNamed(Routes.LOGIN);
                        },
                        text: "Log In",
                        color: Colors.transparent,
                        borderColor: Colors.white,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
