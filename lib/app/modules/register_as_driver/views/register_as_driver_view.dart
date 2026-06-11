import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/extensions/sizedbox_extension.dart';
import 'package:reedsexpressllc_flutter/app/core/theme/app_color.dart';
import 'package:reedsexpressllc_flutter/app/widgets/app_input_text_form_field.dart';
import 'package:reedsexpressllc_flutter/app/widgets/app_text_style.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_svg_image.dart';
import 'package:reedsexpressllc_flutter/app/widgets/document_upload_field.dart';
import 'package:reedsexpressllc_flutter/app/widgets/global_button.dart';
import 'package:reedsexpressllc_flutter/app/widgets/global_loading.dart';
import 'package:reedsexpressllc_flutter/gen/assets.gen.dart';

import '../controllers/register_as_driver_controller.dart';

class RegisterAsDriverView extends GetView<RegisterAsDriverController> {
  const RegisterAsDriverView({super.key});

  static const _uploadAccentColor = AppColor.error;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 20.h),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      24.height,
                      InputFieldWithLabel(
                        controller: controller.truckNumberController,
                        label: 'Truck Number',
                        hintText: 'Enter Truck Number',
                        validator: _requiredValidator,
                      ),
                      16.height,
                      InputFieldWithLabel(
                        controller: controller.truckLicensePlateController,
                        label: 'Truck License Plate Number',
                        hintText: 'Enter Truck License Plate Number',
                        validator: _requiredValidator,
                      ),
                      16.height,
                      ...controller.documentFields.expand(
                        (field) => [
                          DocumentUploadField(
                            label: field.label,
                            isRequired: field.isRequired,
                            uploadAccentColor: _uploadAccentColor,
                            filePathObs: field.pathObs,
                            onTap: () =>
                                controller.showUploadSourceSheet(field.pathObs),
                            onRemove: () => controller.removeFile(field.pathObs),
                          ),
                          16.height,
                        ],
                      ),
                      _uploadedFilesSection(),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
              child: Column(
                children: [
                  Obx(
                    () => controller.isLoading.value
                        ? const GlobalLoading()
                        : GlobalButton(
                            text: 'Request',
                            onTap: () {
                              if (formKey.currentState!.validate() &&
                                  controller.canSubmitObs.value) {
                                controller.submitRequest();
                              }
                            },
                            color: controller.canSubmitObs.value
                                ? AppColor.primary
                                : AppColor.primaryDisable,
                            textColor: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                  ),
                  12.height,
                  GestureDetector(
                    onTap: controller.skip,
                    child: AppTextStyle(
                      text: 'Skip',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.hintText,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextStyle(
          text: 'Upload Documents',
          fontSize: 22.sp,
          fontWeight: FontWeight.w600,
        ),
        6.height,
        AppTextStyle(
          text:
              'Upload your driver documents to get approved and start receiving loads.',
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColor.hintText,
        ),
      ],
    );
  }

  Widget _uploadedFilesSection() {
    return Obx(() {
      final uploaded = controller.uploadedDocuments;
      if (uploaded.isEmpty) return const SizedBox.shrink();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextStyle(
            text: 'Uploaded (${uploaded.length})',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
          10.height,
          ...uploaded.map((field) {
            final filePath = field.pathObs.value!;

            return Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: AppColor.hintText.withValues(alpha: 0.25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(8),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    customSvgImage(
                      imagePath: Assets.icons.docIcon,
                      color: AppColor.primary,
                    ),
                    10.width,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextStyle(
                            text: controller.displayFileName(field),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          2.height,
                          AppTextStyle(
                            text: controller.formatFileSize(filePath),
                            fontSize: 11.sp,
                            color: AppColor.hintText,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.removeFile(field.pathObs),
                      child: customSvgImage(
                        imagePath: Assets.icons.crossCircleIcon,
                        color: AppColor.hintText,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      );
    });
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }
}
