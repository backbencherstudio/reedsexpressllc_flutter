import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/extensions/sizedbox_extension.dart';
import 'package:reedsexpressllc_flutter/app/core/theme/app_color.dart';
import 'package:reedsexpressllc_flutter/app/widgets/app_input_text_form_field.dart';
import 'package:reedsexpressllc_flutter/app/widgets/app_text_style.dart';
import 'package:reedsexpressllc_flutter/app/widgets/appbar_title.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_icon_button.dart';
import 'package:reedsexpressllc_flutter/app/widgets/document_upload_field.dart';
import 'package:reedsexpressllc_flutter/app/widgets/global_button.dart';
import 'package:reedsexpressllc_flutter/app/widgets/global_loading.dart';

import '../controllers/add_truck_controller.dart';

class AddTruckView extends GetView<AddTruckController> {
  const AddTruckView({super.key});

  static const _uploadAccentColor = AppColor.error;

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
        title: appbarTitle(text: 'Add a Truck'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputFieldWithLabel(
                      controller: controller.licensePlateController,
                      label: 'License Plate',
                      hintText: 'ABC-1234',
                    ),
                    16.height,
                    _truckTypeDropdown(),
                    16.height,
                    InputFieldWithLabel(
                      controller: controller.vinController,
                      label: 'VIN',
                      hintText: 'Enter VIN Number',
                    ),
                    16.height,
                    InputFieldWithLabel(
                      controller: controller.modelMakeController,
                      label: 'Model/ Make',
                      hintText: 'Freightliner Cascadia',
                    ),
                    16.height,
                    InputFieldWithLabel(
                      controller: controller.unitNumberController,
                      label: 'Unit Number',
                      hintText: 'e.g., 101 or T-45',
                    ),
                    16.height,
                    DocumentUploadField(
                      label: 'Truck Doc',
                      filePathObs: controller.truckDocPath,
                      uploadAccentColor: _uploadAccentColor,
                      onTap: () => controller.showUploadSourceSheet(
                        controller.truckDocPath,
                      ),
                      onRemove: () =>
                          controller.removeFile(controller.truckDocPath),
                    ),
                    16.height,
                    DocumentUploadField(
                      label: 'Card Cab (If applicable)',
                      isRequired: false,
                      filePathObs: controller.cabCardPath,
                      uploadAccentColor: _uploadAccentColor,
                      onTap: () => controller.showUploadSourceSheet(
                        controller.cabCardPath,
                      ),
                      onRemove: () =>
                          controller.removeFile(controller.cabCardPath),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              child: Obx(
                () => controller.isLoading.value
                    ? const GlobalLoading()
                    : Column(
                        children: [
                          GlobalButton(
                            onTap: controller.createTruck,
                            text: 'Create Truck',
                          ),
                          12.height,
                          GlobalButton(
                            onTap: controller.cancel,
                            text: 'Cancel',
                            color: Colors.white,
                            textColor: Colors.black,
                            borderColor: AppColor.hintText.withValues(
                              alpha: 0.5,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _truckTypeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextStyle(
          text: 'Truck Type',
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        4.height,
        Obx(
          () => Column(
            children: [
              GestureDetector(
                onTap: controller.toggleTruckTypeDropdown,
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
                          text: controller.selectedTruckType.value,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Icon(
                        controller.isTruckTypeDropdownOpen.value
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: AppColor.hintText,
                        size: 20.sp,
                      ),
                    ],
                  ),
                ),
              ),
              if (controller.isTruckTypeDropdownOpen.value) ...[
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
                    children: controller.truckTypes.map((type) {
                      final isSelected =
                          controller.selectedTruckType.value == type;
                      final isLast = type == controller.truckTypes.last;

                      return GestureDetector(
                        onTap: () => controller.selectTruckType(type),
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 14.h,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFF3F4F8)
                                : Colors.transparent,
                            border: Border(
                              bottom: isLast
                                  ? BorderSide.none
                                  : BorderSide(
                                      color: AppColor.hintText.withValues(
                                        alpha: 0.15,
                                      ),
                                    ),
                            ),
                          ),
                          child: AppTextStyle(
                            text: type,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
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
