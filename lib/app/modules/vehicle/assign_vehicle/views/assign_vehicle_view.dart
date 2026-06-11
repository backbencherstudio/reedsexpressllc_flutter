import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/extensions/sizedbox_extension.dart';
import 'package:reedsexpressllc_flutter/app/core/theme/app_color.dart';
import 'package:reedsexpressllc_flutter/app/widgets/app_text_style.dart';
import 'package:reedsexpressllc_flutter/app/widgets/appbar_title.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_icon_button.dart';
import 'package:reedsexpressllc_flutter/app/widgets/global_button.dart';
import 'package:reedsexpressllc_flutter/app/widgets/global_loading.dart';

import '../controllers/assign_vehicle_controller.dart';

class AssignVehicleView extends GetView<AssignVehicleController> {
  const AssignVehicleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: const CustomIconButton(),
        ),
        title: appbarTitle(text: 'My Vehicle'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                child: _driverDropdown(),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              child: Obx(
                () => controller.isLoading.value
                    ? const GlobalLoading()
                    : GlobalButton(
                        onTap: controller.assignNow,
                        text: 'Assign Now',
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _driverDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextStyle(
          text: 'Select a Driver',
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        8.height,
        Obx(
          () => Column(
            children: [
              GestureDetector(
                onTap: controller.toggleDropdown,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 14.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: AppColor.hintText.withValues(alpha: 0.5),
                      width: 0.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppTextStyle(
                          text: controller.selectedDriver.value ?? 'Choose a driver...',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: controller.selectedDriver.value == null
                              ? AppColor.hintText
                              : AppColor.hintText,
                        ),
                      ),
                      Icon(
                        controller.isDropdownOpen.value
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: AppColor.hintText,
                        size: 20.sp,
                      ),
                    ],
                  ),
                ),
              ),
              if (controller.isDropdownOpen.value) ...[
                4.height,
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: AppColor.hintText.withValues(alpha: 0.25),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(10),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 8.h),
                        child: AppTextStyle(
                          text: 'Select Truck Type',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ...controller.drivers.map((driver) {
                        final isSelected =
                            controller.selectedDriver.value == driver;

                        return GestureDetector(
                          onTap: () => controller.selectDriver(driver),
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 2.h,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 12.h,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFF3F4F8)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: AppTextStyle(
                              text: driver,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }),
                      8.height,
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
