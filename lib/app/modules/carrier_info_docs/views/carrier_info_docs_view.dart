import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/extensions/sizedbox_extension.dart';
import 'package:reedsexpressllc_flutter/app/core/theme/app_color.dart';
import 'package:reedsexpressllc_flutter/app/widgets/app_input_text_form_field.dart';
import 'package:reedsexpressllc_flutter/app/widgets/app_text_style.dart';
import 'package:reedsexpressllc_flutter/app/widgets/appbar_title.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_icon_button.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_svg_image.dart';
import 'package:reedsexpressllc_flutter/app/widgets/document_upload_field.dart';
import 'package:reedsexpressllc_flutter/app/widgets/global_button.dart';

import '../../../../gen/assets.gen.dart';
import '../controllers/carrier_info_docs_controller.dart';

class CarrierInfoDocsView extends GetView<CarrierInfoDocsController> {
  const CarrierInfoDocsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        surfaceTintColor: AppColor.background,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: const CustomIconButton(),
        ),
        title: appbarTitle(text: 'Carrier Info and Docs'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!controller.isEditing.value) _editButton(),
                      if (controller.isEditing.value) 8.verticalSpace,
                      _carrierInfoFields(),
                      20.verticalSpace,
                      if (controller.isEditing.value)
                        ..._editDocumentFields()
                      else
                        ..._viewDocumentsSection(),
                      24.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
            Obx(() {
              if (!controller.isEditing.value) {
                return const SizedBox.shrink();
              }

              if (controller.useCancelSubmitLayout) {
                return _cancelSubmitActions();
              }

              return _saveChangesAction();
            }),
          ],
        ),
      ),
    );
  }

  Widget _editButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: controller.toggleEdit,
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(12),
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
    );
  }

  Widget _carrierInfoFields() {
    return Obx(
      () => Column(
        children: [
          InputFieldWithLabel(
            label: 'Carrier Name',
            hintText: 'Enter Carrier Name',
            controller: controller.carrierNameController,
            readOnly: !controller.isEditing.value,
          ),
          16.verticalSpace,
          InputFieldWithLabel(
            label: 'DOT Number',
            hintText: 'Enter DOT Number',
            controller: controller.dotNumberController,
            readOnly: !controller.isEditing.value,
          ),
          16.verticalSpace,
          InputFieldWithLabel(
            label: 'MC Number',
            hintText: 'Enter MC Number',
            controller: controller.mcNumberController,
            readOnly: !controller.isEditing.value,
          ),
        ],
      ),
    );
  }

  List<Widget> _editDocumentFields() {
    return controller.documentFields.expand((field) {
      return [
        DocumentUploadField(
          label: field.label,
          isRequired: true,
          fieldColor: AppColor.background,
          uploadAccentColor: AppColor.error,
          filePathObs: field.pathObs,
          onTap: () => controller.showUploadSourceSheet(field.pathObs),
          onRemove: () => controller.removeFile(field.pathObs),
        ),
        14.verticalSpace,
      ];
    }).toList();
  }

  List<Widget> _viewDocumentsSection() {
    return [
      AppTextStyle(
        text: 'Documents',
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
      12.verticalSpace,
      ...controller.savedDocuments.map(
        (doc) => Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: _savedDocumentCard(doc),
        ),
      ),
    ];
  }

  Widget _savedDocumentCard(CarrierSavedDocument doc) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.hintText.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customSvgImage(
            imagePath: Assets.icons.docIcon,
            width: 32.w,
            height: 32.w,
            color: AppColor.hintText,
          ),
          10.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextStyle(
                  text: doc.fileName,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
                4.verticalSpace,
                AppTextStyle(
                  text: '${doc.fileSize} • ${doc.uploadedAt}',
                  fontSize: 11.sp,
                  color: AppColor.hintText,
                ),
                8.verticalSpace,
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 3.h,
                  ),
                  decoration: BoxDecoration(
                    color: doc.tagColor.withAlpha(75),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: AppTextStyle(
                    text: doc.tag,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: doc.tagColor,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => controller.downloadDocument(doc),
            child: customSvgImage(
              imagePath: Assets.icons.downloadIcon,
              width: 28.w,
              height: 28.w,
            ),
          ),
        ],
      ),
    );
  }

  Widget _cancelSubmitActions() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
      child: Obx(
        () => Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: controller.cancelEdit,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: AppColor.hintText.withValues(alpha: 0.35),
                    ),
                  ),
                  child: AppTextStyle(
                    text: 'Cancel',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: GestureDetector(
                onTap: controller.isLoading.value
                    ? null
                    : controller.submitProfile,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: controller.isLoading.value
                      ? Center(
                          child: SizedBox(
                            width: 18.w,
                            height: 18.w,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                        )
                      : AppTextStyle(
                          text: 'Submit',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          textAlign: TextAlign.center,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _saveChangesAction() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
      child: Obx(
        () => GlobalButton(
          text: 'Save Changes',
          onTap: controller.saveChanges,
          isDisabled: controller.isLoading.value,
          textColor: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
