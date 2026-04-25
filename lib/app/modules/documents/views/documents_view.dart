import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/theme/app_colors.dart';
import 'package:reedsexpressllc_flutter/app/widgets/app_text_style.dart';
import 'package:reedsexpressllc_flutter/app/widgets/document_upload_field.dart';
import 'package:reedsexpressllc_flutter/app/routes/app_pages.dart';
import '../../../widgets/appbar_title.dart';
import '../../../widgets/custom_icon_button.dart';
import '../controllers/documents_controller.dart';

class DocumentsView extends GetView<DocumentsController> {
  const DocumentsView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<DocumentsController>()) {
      Get.put(DocumentsController());
    }
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: appbarTitle(text: 'Documents'),
        leading: Get.currentRoute == Routes.MAIN_PAGE
            ? null
            : Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: const CustomIconButton(),
              ),
      ),
      body: Column(
        children: [
          _tabSwitcher(),
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
      child: Obx(
        () => Container(
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
        ),
      ),
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
                _selectLoadField(),
                16.verticalSpace,
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
        _loadDocsBottomActions(),
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

  Widget _loadDocsBottomActions() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
      child: Obx(
        () => Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: controller.cancelLoadDocs,
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
            Expanded(
              child: GestureDetector(
                onTap: controller.isLoading.value
                    ? null
                    : controller.submitLoadDocs,
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
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Carrier Info Card ────────────────────────────
          _carrierInfoCard(),
          20.verticalSpace,

          // ── Upload progress ──────────────────────────────
          _uploadProgressRow(),
          16.verticalSpace,

          // ── Personal documents ───────────────────────────
          DocumentUploadField(
            label: 'Driver Card',
            filePathObs: controller.driverCardPath,
            onTap: () => controller.pickFile(controller.driverCardPath),
            onRemove: () => controller.removeFile(controller.driverCardPath),
            isRequired: false,
          ),
          14.verticalSpace,
          DocumentUploadField(
            label: 'Medical License',
            filePathObs: controller.medicalLicensePath,
            onTap: () => controller.pickFile(controller.medicalLicensePath),
            onRemove: () =>
                controller.removeFile(controller.medicalLicensePath),
            isRequired: false,
          ),
          14.verticalSpace,
          DocumentUploadField(
            label: 'Medical Card',
            filePathObs: controller.medicalCardPath,
            onTap: () => controller.pickFile(controller.medicalCardPath),
            onRemove: () => controller.removeFile(controller.medicalCardPath),
            isRequired: false,
          ),
          14.verticalSpace,
          DocumentUploadField(
            label: 'Vehicle Registration',
            filePathObs: controller.vehicleRegistrationPath,
            onTap: () =>
                controller.pickFile(controller.vehicleRegistrationPath),
            onRemove: () =>
                controller.removeFile(controller.vehicleRegistrationPath),
            isRequired: false,
          ),
          14.verticalSpace,
          DocumentUploadField(
            label: 'Permit',
            filePathObs: controller.permitPath,
            onTap: () => controller.pickFile(controller.permitPath),
            onRemove: () => controller.removeFile(controller.permitPath),
            isRequired: false,
          ),
          14.verticalSpace,
          DocumentUploadField(
            label: 'Traffic Ticket',
            filePathObs: controller.trafficTicketPath,
            onTap: () => controller.pickFile(controller.trafficTicketPath),
            onRemove: () => controller.removeFile(controller.trafficTicketPath),
            isRequired: false,
          ),
          14.verticalSpace,
          DocumentUploadField(
            label: 'Receipt',
            filePathObs: controller.receiptPath,
            onTap: () => controller.pickFile(controller.receiptPath),
            onRemove: () => controller.removeFile(controller.receiptPath),
            isRequired: false,
          ),
        ],
      ),
    );
  }

  Widget _carrierInfoCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextStyle(
            text: 'Carrier Information',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          12.verticalSpace,
          _infoField(
            label: 'Carrier Name',
            value: controller.carrierName.value,
          ),
          12.verticalSpace,
          Row(
            children: [
              Expanded(
                child: _infoField(
                  label: 'DOT Number',
                  value: controller.dotNumber.value,
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: _infoField(
                  label: 'MC Number',
                  value: controller.mcNumber.value,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoField({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextStyle(
          text: label,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.hintText,
        ),
        4.verticalSpace,
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F6FA),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.hintText, width: 0.5),
          ),
          child: AppTextStyle(
            text: value,
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF444444),
          ),
        ),
      ],
    );
  }

  Widget _uploadProgressRow() {
    return Obx(() {
      final uploaded = controller.uploadedPersonalDocsCount;
      final total = controller.totalPersonalDocs;
      final progress = uploaded / total;

      return Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextStyle(
                  text: 'Documents Uploaded',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                AppTextStyle(
                  text: '$uploaded / $total',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ],
            ),
            8.verticalSpace,
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6.h,
                backgroundColor: AppColors.primary.withAlpha(30),
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
          ],
        ),
      );
    });
  }
}
