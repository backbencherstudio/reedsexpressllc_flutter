import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/theme/app_colors.dart';
import 'package:reedsexpressllc_flutter/app/core/widgets/app_text_style.dart';
import 'package:reedsexpressllc_flutter/app/core/widgets/document_upload_field.dart';

import '../../../core/widgets/appbar_title.dart';
import '../controllers/documents_controller.dart';

class DocumentsView extends GetView<DocumentsController> {
  const DocumentsView({super.key});

  @override
  Widget build(BuildContext context) {
    if(!Get.isRegistered<DocumentsController>()){
      Get.put(DocumentsController());
    }
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.background,

        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: appbarTitle(text: 'Documents'),
      ),
      body: Column(
        children: [
          // ── Tab switcher ───────────────────────────────────
          _tabSwitcher(),

          // ── Tab content ────────────────────────────────────
          Expanded(
            child: Obx(
              () => controller.selectedTabIndex.value == 0
                  ? _loadDocsTab()
                  : _myDocsTab(),
            ),
          ),
        ],
      ),
    );
  }

  // ── Tab Switcher ────────────────────────────────────────────────────────────

  Widget _tabSwitcher() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
      child: Obx(() {
        return Container(
          height: 46.h,
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha(40),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            children: [
              _tabItem(label: 'Load Docs', index: 0),
              _tabItem(label: 'My Docs', index: 1),
            ],
          ),
        );
      }),
    );
  }

  Widget _tabItem({required String label, required int index}) {
    final isSelected = controller.selectedTabIndex.value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectTab(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.all(4.r),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: AppTextStyle(
              text: label,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }

  // ── Load Docs Tab ───────────────────────────────────────────────────────────

  Widget _loadDocsTab() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Select Load dropdown
                _selectLoadField(),
                16.verticalSpace,

                // Upload fields
                DocumentUploadField(
                  label: 'POD - Proof of Delivery',
                  filePathObs: controller.podPath,
                  onTap: () => controller.pickFile(controller.podPath),
                  onRemove: () => controller.removeFile(controller.podPath),
                ),
                14.verticalSpace,
                DocumentUploadField(
                  label: 'BOL - Bill of Lading',
                  filePathObs: controller.bolPath,
                  onTap: () => controller.pickFile(controller.bolPath),
                  onRemove: () => controller.removeFile(controller.bolPath),
                ),
                14.verticalSpace,
                DocumentUploadField(
                  label: 'Rate Confirmation',
                  filePathObs: controller.rateConfirmationPath,
                  onTap: () =>
                      controller.pickFile(controller.rateConfirmationPath),
                  onRemove: () =>
                      controller.removeFile(controller.rateConfirmationPath),
                ),
                14.verticalSpace,
                DocumentUploadField(
                  label: 'Scale Ticket',
                  filePathObs: controller.scaleTicketPath,
                  onTap: () => controller.pickFile(controller.scaleTicketPath),
                  onRemove: () =>
                      controller.removeFile(controller.scaleTicketPath),
                ),
                14.verticalSpace,
                DocumentUploadField(
                  label: 'Lumper fee',
                  filePathObs: controller.lumperFeePath,
                  onTap: () => controller.pickFile(controller.lumperFeePath),
                  onRemove: () =>
                      controller.removeFile(controller.lumperFeePath),
                ),
                14.verticalSpace,
                DocumentUploadField(
                  label: 'Inspection Report',
                  filePathObs: controller.inspectionReportPath,
                  onTap: () =>
                      controller.pickFile(controller.inspectionReportPath),
                  onRemove: () =>
                      controller.removeFile(controller.inspectionReportPath),
                ),
                20.verticalSpace,
              ],
            ),
          ),
        ),

        // ── Bottom action buttons ──────────────────────────
        _bottomActions(),
      ],
    );
  }

  Widget _selectLoadField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AppTextStyle(
              text: 'Select Load',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            AppTextStyle(
              text: ' *',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.red.shade800,
            ),
          ],
        ),
        4.verticalSpace,
        Obx(
          () => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: AppColors.hintText, width: 0.5),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: controller.selectedLoad.value,
                hint: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: AppTextStyle(
                    text: 'Choose a load...',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.hintText,
                  ),
                ),
                isExpanded: true,
                icon: Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.hintText,
                    size: 20.sp,
                  ),
                ),
                borderRadius: BorderRadius.circular(10.r),
                items: controller.loadOptions
                    .map(
                      (load) => DropdownMenuItem<String>(
                        value: load,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          child: AppTextStyle(
                            text: load,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: controller.selectLoad,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _bottomActions() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
      child: Obx(
        () => Row(
          children: [
            // Cancel
            Expanded(
              child: GestureDetector(
                onTap: controller.cancel,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: AppColors.primary, width: 0.8),
                  ),
                  child: AppTextStyle(
                    text: 'Cancel',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            12.horizontalSpace,

            // Submit
            Expanded(
              child: GestureDetector(
                onTap: controller.isLoading.value ? null : controller.submit,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
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

  // ── My Docs Tab ─────────────────────────────────────────────────────────────

  Widget _myDocsTab() {
    return Center(
      child: AppTextStyle(
        text: 'No documents yet.',
        fontSize: 14.sp,
        color: AppColors.hintText,
      ),
    );
  }
}
