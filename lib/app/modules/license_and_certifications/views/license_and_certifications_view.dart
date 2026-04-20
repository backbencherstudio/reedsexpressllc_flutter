import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../gen/assets.gen.dart';
import '../../../core/extensions/sizedbox_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_input_text_form_field.dart';
import '../../../core/widgets/app_text_style.dart';
import '../../../core/widgets/appbar_title.dart';
import '../../../core/widgets/custom_icon_button.dart';
import '../../../core/widgets/custom_svg_image.dart';
import '../../../core/widgets/global_button.dart';
import '../controllers/license_and_certifications_controller.dart';

class LicenseAndCertificationsView extends GetView<LicenseAndCertificationsController> {
  const LicenseAndCertificationsView({super.key});

  @override
  Widget build(BuildContext context) {
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
        title: appbarTitle(text: 'License & Certifications'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Edit button
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => controller.toggleEdit(),
                        child: Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(10),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: customSvgImage(
                            imagePath: Assets.icons.editIcon,
                            width: 22.w,
                            height: 22.w,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                    16.verticalSpace,
                    
                    InputFieldWithLabel(
                      label: 'License Number',
                      hintText: 'Enter License Number',
                      controller: controller.licenseNumberController,
                    ),
                    16.verticalSpace,
                    
                    _LicenseStateDropdown(controller: controller),
                    
                    16.verticalSpace,
                    
                    InputFieldWithLabel(
                      label: 'License Expiration',
                      hintText: 'Enter License Expiration',
                      controller: controller.licenseExpirationController,
                      readOnly: true,
                      onTap: () => _showDatePicker(context, controller.licenseExpirationController),
                      suffixIcon: Padding(
                        padding:  EdgeInsets.all(5.r),
                        child: customSvgImage(
                          imagePath: Assets.icons.docIcon,
                          color: AppColors.hintText,
                          height: 15.h,
                          width: 15.w
                        ),
                      ),
                    ),
                    16.verticalSpace,
                    
                    InputFieldWithLabel(
                      label: 'Medical Card Expiration',
                      hintText: 'Enter Medical Card Expiration',
                      controller: controller.medicalCardExpirationController,
                      readOnly: true,
                      onTap: () => _showDatePicker(context, controller.medicalCardExpirationController),
                      suffixIcon: Padding(
                        padding:  EdgeInsets.all(5.r),
                        child: customSvgImage(
                            imagePath: Assets.icons.docIcon,
                            color: AppColors.hintText,
                            height: 15.h,
                            width: 15.w
                        ),
                      ),
                    ),
                    16.verticalSpace,
                    
                    InputFieldWithLabel(
                      label: 'Registration Expiration',
                      hintText: 'Enter Registration Expiration',
                      controller: controller.registrationExpirationController,
                      readOnly: true,
                      onTap: () => _showDatePicker(context, controller.registrationExpirationController),
                      suffixIcon: Padding(
                        padding:  EdgeInsets.all(5.r),
                        child: customSvgImage(
                            imagePath: Assets.icons.docIcon,
                            color: AppColors.hintText,
                            height: 15.h,
                            width: 15.w
                        ),
                      ),
                    ),
                    
                    40.verticalSpace,
                    
                    Obx(() => controller.isEditing.value 
                      ? globalButton(
                          onTap: () {
                            controller.toggleEdit();
                            // Save logic here
                          },
                          text: "Save Changes",
                          textColor: Colors.white,
                        )
                      : const SizedBox.shrink()
                    ),
                    40.verticalSpace,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context, TextEditingController textController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            width: 320,
            height: 400,
            child: SfDateRangePicker(
              showNavigationArrow: true,
              showActionButtons: true,
              onSubmit: (Object? value) {
                if (value is DateTime) {
                  textController.text = DateFormat('dd/MM/yyyy').format(value);
                  Navigator.pop(context);
                }
              },
              onCancel: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }
}

class _LicenseStateDropdown extends StatelessWidget {
  final LicenseAndCertificationsController controller;

  const _LicenseStateDropdown({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextStyle(
          text: 'License State',
          fontSize: 14.sp,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        8.verticalSpace,
        Obx(() => DropdownButtonFormField<String>(
          value: controller.licenseState.value.isNotEmpty ? controller.licenseState.value : null,
          icon: Icon(Icons.keyboard_arrow_down, color: AppColors.hintText),
          decoration: InputDecoration(
            hintText: 'Enter License State',
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 14.sp,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
             border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 0.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.hintText,
                width: 0.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 0.8,
              ),
            ),
          ),
          items: ['Arizona', 'California', 'Texas', 'New York', 'Florida']
              .map((state) => DropdownMenuItem(
                    value: state,
                    child: Text(state, style: TextStyle(fontSize: 14.sp, color: Colors.black)),
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) controller.licenseState.value = value;
          },
        )),
      ],
    );
  }
}
