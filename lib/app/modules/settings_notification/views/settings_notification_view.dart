import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/extensions/sizedbox_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_text_style.dart';
import '../../../core/widgets/appbar_title.dart';
import '../../../core/widgets/custom_icon_button.dart';
import '../controllers/settings_notification_controller.dart';

class SettingsNotificationView extends GetView<SettingsNotificationController> {
  const SettingsNotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<SettingsNotificationController>()) {
      Get.put(SettingsNotificationController());
    }
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: const CustomIconButton(),
        ),
        title: appbarTitle(text: 'Notifications'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextStyle(
                text: 'Notification Settings',
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              20.verticalSpace,
              Obx(() => _buildSwitchItem(
                    title: 'In app Notification',
                    value: controller.inAppNotification.value,
                    onChanged: controller.toggleInApp,
                  )),
              12.verticalSpace,
              Obx(() => _buildSwitchItem(
                    title: 'Email Notification',
                    value: controller.emailNotification.value,
                    onChanged: controller.toggleEmail,
                  )),
              12.verticalSpace,
              Obx(() => _buildSwitchItem(
                    title: 'New load assignment',
                    value: controller.newLoadAssignment.value,
                    onChanged: controller.toggleNewLoad,
                  )),
              12.verticalSpace,
              Obx(() => _buildSwitchItem(
                    title: 'Vehicle information Update',
                    value: controller.vehicleInfoUpdate.value,
                    onChanged: controller.toggleVehicleInfo,
                  )),
              12.verticalSpace,
              Obx(() => _buildSwitchItem(
                    title: 'Document Verification update',
                    value: controller.docVerificationUpdate.value,
                    onChanged: controller.toggleDocVerif,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchItem({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.withOpacity(0.15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: AppTextStyle(
              text: title,
              fontSize: 14.sp,
              color: Colors.black87,
            ),
          ),
          Transform.scale(
            scale: 0.85,
            child: CupertinoSwitch(
              value: value,
              activeColor: AppColors.primary,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
