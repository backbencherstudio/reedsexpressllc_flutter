import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/extensions/sizedbox_extension.dart';
import 'package:reedsexpressllc_flutter/app/core/utils/helper_utils.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_dialog.dart';
import 'package:reedsexpressllc_flutter/app/widgets/global_button.dart';
import 'package:reedsexpressllc_flutter/app/modules/main_page/controllers/main_page_controller.dart';

import '../../../../gen/assets.gen.dart';
import '../../../routes/app_pages.dart';
import '../../../core/theme/app_color.dart';
import '../../../widgets/app_text_style.dart';
import '../../../widgets/custom_svg_image.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ── Top header ───────────────────────────────────────────────────
            _ProfileHeader(),

            // ── Scrollable content ───────────────────────────────────────────
            Expanded(
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F8),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 32.h),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      _ProfileMenuItem(
                        iconWidget: customSvgImage(
                          imagePath: Assets.icons.profileIcon,
                          width: 24.w,
                          height: 24.w,
                          color: Colors.black87,
                        ),
                        title: 'Personal Info',
                        onTap: () {
                          Get.toNamed(Routes.PERSONAL_INFO);
                        },
                      ),

                      HelperUtils.isCarrierUser
                          ? Padding(
                              padding: EdgeInsets.only(top: 12.h),
                              child: _ProfileMenuItem(
                                iconWidget: customSvgImage(
                                  imagePath: Assets.icons.registerDriverIcon,
                                  width: 24.w,
                                  height: 24.w,
                                  color: Colors.black87,
                                ),
                                title: 'Register as a Driver',
                                onTap: () {
                                  Get.toNamed(Routes.REGISTER_AS_DRIVER);
                                },
                              ),
                            )
                          : SizedBox.shrink(),
                      12.verticalSpace,
                      _ProfileMenuItem(
                        iconWidget: customSvgImage(
                          imagePath: Assets.icons.studentCardIcon,
                          width: 24.w,
                          height: 24.w,
                          color: Colors.black87,
                        ),
                        title: 'License & Certifications',
                        onTap: () {
                          Get.toNamed(Routes.LICENSE_AND_CERTIFICATIONS);
                        },
                      ),
                      12.verticalSpace,
                      _ProfileMenuItem(
                        iconWidget: customSvgImage(
                          imagePath: Assets.icons.truckIcon,
                          width: 24.w,
                          height: 24.w,
                          color: Colors.black87,
                        ),
                        title: 'My Vehicle',
                        onTap: () {
                          Get.toNamed(Routes.VEHICLE);
                        },
                      ),
                      12.verticalSpace,
                      _ProfileMenuItem(
                        iconWidget: customSvgImage(
                          imagePath: Assets.icons.docIcon,
                          width: 24.w,
                          height: 24.w,
                          color: Colors.black87,
                        ),
                        title: 'Carrier Info and Docs',
                        onTap: () {
                          Get.toNamed(Routes.CARRIER_INFO_DOCS);
                        },
                      ),
                      12.verticalSpace,
                      _ProfileMenuItem(
                        iconWidget: customSvgImage(
                          imagePath: Assets.icons.notificationIcon,
                          width: 24.w,
                          height: 24.w,
                          color: Colors.black87,
                        ),
                        title: 'Notifications',
                        onTap: () {
                          Get.toNamed(Routes.SETTINGS_NOTIFICATION);
                        },
                      ),
                      12.verticalSpace,
                      _ProfileMenuItem(
                        iconWidget: customSvgImage(
                          imagePath: Assets.icons.customerSupportIcon,
                          width: 24.w,
                          height: 24.w,
                          color: Colors.black87,
                        ),
                        title: 'Support',
                        onTap: () {
                          Get.find<MainPageController>().changePage(2);
                        },
                      ),
                      12.verticalSpace,
                      _ProfileMenuItem(
                        iconWidget: customSvgImage(
                          imagePath: Assets.icons.logoutIcon,
                          width: 24.w,
                          height: 24.w,
                          color: const Color(
                            0xFFC04F56,
                          ), // Reddish color matches screenshot
                        ),
                        title: 'Log Out',
                        titleColor: const Color(0xFFC04F56),
                        showArrow: false,
                        onTap: () {
                          Get.dialog(
                            CustomDialog(
                              iconPath: Assets.icons.logoutWithBgIcon,
                              iconHeight: 50.h,
                              iconWidth: 50.w,
                              title: "Logout your Account",
                              subtitle: "Are you sure you want to logout?",
                              bottomWidget: Row(
                                children: [
                                  Expanded(
                                    child: GlobalButton(
                                      onTap: () {
                                        Get.back();
                                      },
                                      text: "Cancel",
                                      color: Colors.white,
                                      textColor: Colors.black,
                                      borderColor: Colors.grey,
                                    ),
                                  ),
                                  10.width,
                                  Expanded(
                                    child: GlobalButton(
                                      onTap: () {
                                        Get.offAllNamed(Routes.ONBOARD);
                                      },
                                      text: "Logout",
                                      color: Color(0xFFEB3D4D),
                                      textColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
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

class _ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      // alignment: Alignment.center,
      children: [
        // Background circles
        Positioned(
          top: 25.h,
          left: -60,
          child: Container(
            height: 90.h,
            width: 90.w,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(20),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: -15.h,
          right: -50,
          child: Container(
            height: 130.h,
            width: 130.w,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(20),
              shape: BoxShape.circle,
            ),
          ),
        ),

        // Profile Details Content
        Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Avatar
              SizedBox(width: double.infinity),
              Stack(
                children: [
                  Container(
                    height: 80.w,
                    width: 80.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withAlpha(40),
                      border: Border.all(
                        color: Colors.white.withAlpha(50),
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: AppTextStyle(
                      text: "MJ",
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 28.w,
                      width: 28.w,
                      decoration: BoxDecoration(
                        color: AppColor.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Center(
                        child: customSvgImage(
                          imagePath: Assets.icons.cameraIcon,
                          width: 14.w,
                          height: 14.w,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              16.verticalSpace,
              // Username
              AppTextStyle(
                text: "Marcus Johnson",
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              4.verticalSpace,
              // User ID
              AppTextStyle(
                text: "Driver ID: DRV-00412",
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white.withAlpha(200),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final Widget iconWidget;
  final String title;
  final Color? titleColor;
  final VoidCallback onTap;
  final bool showArrow;

  const _ProfileMenuItem({
    required this.iconWidget,
    required this.title,
    this.titleColor,
    required this.onTap,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            iconWidget,
            12.horizontalSpace,
            Expanded(
              child: AppTextStyle(
                text: title,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: titleColor ?? Colors.black,
              ),
            ),
            if (showArrow)
              customSvgImage(
                imagePath: Assets.icons.forwordArrowIcon,
                color: Colors.black,
                height: 20.h,
                width: 20.w,
              ),
          ],
        ),
      ),
    );
  }
}
