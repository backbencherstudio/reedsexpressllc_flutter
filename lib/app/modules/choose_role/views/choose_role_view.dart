import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/constants/enums.dart';
import 'package:reedsexpressllc_flutter/app/core/extensions/sizedbox_extension.dart';
import 'package:reedsexpressllc_flutter/app/core/theme/app_color.dart';
import 'package:reedsexpressllc_flutter/app/widgets/app_text_style.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_check_box.dart';
import 'package:reedsexpressllc_flutter/app/widgets/global_button.dart';

import '../../../../gen/assets.gen.dart';
import '../controllers/choose_role_controller.dart';

class ChooseRoleView extends GetView<ChooseRoleController> {
  const ChooseRoleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Column(
          children: [

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  children: [
                    Image.asset(
                      Assets.images.chooseRoleImage.path,
                      height: 180.h,
                      fit: BoxFit.contain,
                    ),
                    20.height,
                    AppTextStyle(
                      text: 'Choose Your Role',
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                    ),
                    25.height,
                    _RoleCard(
                      role: UserRole.driver,
                      title: 'Driver',
                      description:
                          'View assigned loads, update delivery statuses, and stay connected on the go.',
                      iconPath: Assets.images.manImage.path,
                    ),
                    15.height,
                    _RoleCard(
                      role: UserRole.carrier,
                      title: 'Carrier',
                      description:
                          'Create and manage your carrier account, onboard your business, and invite drivers to join your fleet.',
                      iconPath: Assets.images.buildingImage.path,
                    ),
                    30.height,
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 20.h),
              child: GlobalButton(
                text: 'Next',
                onTap: controller.onNext,
                textColor: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleCard extends GetView<ChooseRoleController> {
  const _RoleCard({
    required this.role,
    required this.title,
    required this.description,
    required this.iconPath,
  });

  final UserRole role;
  final String title;
  final String description;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = controller.selectedRole.value == role;

      return GestureDetector(
        onTap: () => controller.selectRole(role),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColor.primary.withValues(alpha: 0.06)
                : Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected
                  ? AppColor.primary
                  : AppColor.hintText.withValues(alpha: 0.25),
              width: isSelected ? 2.w : 1.w,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: CustomCheckBox(
                  isChecked: isSelected,
                  onTap: () => controller.selectRole(role),
                  size: 20.h,
                ),
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextStyle(
                      text: title,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    6.height,
                    AppTextStyle(
                      text: description,
                      fontSize: 12.sp,
                      color: AppColor.hintText,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
              8.width,
              Image.asset(iconPath, height: 56.h, width: 56.w),
            ],
          ),
        ),
      );
    });
  }
}
