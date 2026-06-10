import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/extensions/sizedbox_extension.dart';
import 'package:reedsexpressllc_flutter/app/core/theme/app_color.dart';
import 'package:reedsexpressllc_flutter/app/widgets/app_text_style.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_svg_image.dart';
import 'package:reedsexpressllc_flutter/app/widgets/document_upload_field.dart';
import 'package:reedsexpressllc_flutter/app/routes/app_pages.dart';
import 'package:reedsexpressllc_flutter/gen/assets.gen.dart';
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
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        surfaceTintColor: AppColor.background,
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
            color: AppColor.primary.withAlpha(40),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            children: [
              _tabItem(label: 'Load Docs', index: 0),
              _tabItem(label: 'My Uploaded Docs', index: 1),
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
            color: isSelected ? AppColor.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: AppTextStyle(
              text: label,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : AppColor.primary,
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
                ...controller.loadDocumentFields.expand(
                  (field) => [
                    DocumentUploadField(
                      label: field.label,
                      isRequired: field.isRequired,
                      fieldColor: AppColor.background,
                      uploadAccentColor: AppColor.error,
                      filePathObs: field.pathObs,
                      onTap: () =>
                          controller.showUploadSourceSheet(field.pathObs),
                      onRemove: () => controller.removeFile(field.pathObs),
                    ),
                    14.verticalSpace,
                  ],
                ),
                _uploadedFilesSection(),
                30.height,
                Obx(
                  () => Column(
                    children: [
                      _loadDocsActionButton(
                        text: 'Submit',
                        onTap: controller.isLoading.value
                            ? null
                            : controller.submitLoadDocs,
                        isLoading: controller.isLoading.value,
                      ),
                      10.verticalSpace,
                      _loadDocsActionButton(
                        text: 'Send to Broker',
                        onTap: controller.isLoading.value
                            ? null
                            : controller.sendToBroker,
                      ),
                      10.verticalSpace,
                      _loadDocsActionButton(
                        text: 'Cancel',
                        onTap: controller.cancelLoadDocs,
                        isOutlined: true,
                      ),
                    ],
                  ),
                ),
                20.height,
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _uploadedFilesSection() {
    return Obx(() {
      final uploaded = controller.uploadedLoadDocuments;
      if (uploaded.isEmpty) return const SizedBox.shrink();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextStyle(
            text: 'Uploaded (${uploaded.length})',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
          10.verticalSpace,
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
                            text: controller.fileName(filePath),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          2.verticalSpace,
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
          10.verticalSpace,
        ],
      );
    });
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
          () => Column(
            children: [
              GestureDetector(
                onTap: controller.toggleLoadDropdown,
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
                          text:
                              controller.selectedLoad.value ??
                              'Choose a load...',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: controller.selectedLoad.value == null
                              ? AppColor.hintText
                              : Colors.black,
                        ),
                      ),
                      Icon(
                        controller.isLoadDropdownOpen.value
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: AppColor.hintText,
                        size: 20.sp,
                      ),
                    ],
                  ),
                ),
              ),
              if (controller.isLoadDropdownOpen.value) ...[
                4.verticalSpace,
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
                    children: controller.loadOptions.map((load) {
                      final isSelected = controller.selectedLoad.value == load;
                      return GestureDetector(
                        onTap: () => controller.selectLoad(load),
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 14.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: load == controller.loadOptions.last
                                  ? BorderSide.none
                                  : BorderSide(
                                      color: AppColor.hintText.withValues(
                                        alpha: 0.15,
                                      ),
                                    ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: AppTextStyle(
                                  text: load,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check,
                                  color: AppColor.primary,
                                  size: 18.sp,
                                ),
                            ],
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
        8.verticalSpace,
        Row(
          children: [
            Icon(Icons.info_outline, size: 14.sp, color: AppColor.hintText),
            6.width,
            Expanded(
              child: AppTextStyle(
                text: 'Select a specific load and upload required files',
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColor.hintText,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _loadDocsActionButton({
    required String text,
    VoidCallback? onTap,
    bool isLoading = false,
    bool isOutlined = false,
    bool usePrimary = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: isOutlined
              ? Colors.white
              : (usePrimary ? AppColor.primary : AppColor.primaryDisable),
          borderRadius: BorderRadius.circular(10.r),
          border: isOutlined
              ? Border.all(
                  color: usePrimary
                      ? AppColor.primary
                      : AppColor.hintText.withValues(alpha: 0.25),
                )
              : null,
        ),
        child: isLoading
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
                text: text,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isOutlined
                    ? (usePrimary ? AppColor.primary : AppColor.hintText)
                    : Colors.white,
                textAlign: TextAlign.center,
              ),
      ),
    );
  }

  // ── My Uploaded Docs Tab ────────────────────────────────────────────────────

  Widget _myDocsTab() {
    return Obx(
      () => controller.showMyDocsUploadForm.value
          ? _myDocsUploadForm()
          : _myDocsListView(),
    );
  }

  Widget _myDocsListView() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: controller.openMyDocsUploadForm,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.white, size: 18.sp),
                  6.width,
                  AppTextStyle(
                    text: 'Add New Document',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          20.verticalSpace,
          Obx(() {
            final grouped = controller.groupedSavedMyDocuments;
            if (grouped.isEmpty) {
              return AppTextStyle(
                text: 'No uploaded documents yet',
                fontSize: 13.sp,
                color: AppColor.hintText,
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: grouped.entries.expand((entry) {
                return [
                  AppTextStyle(
                    text: entry.key,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  12.verticalSpace,
                  ...entry.value.map(
                    (doc) => Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: _savedMyDocumentCard(doc),
                    ),
                  ),
                  10.verticalSpace,
                ];
              }).toList(),
            );
          }),
        ],
      ),
    );
  }

  Widget _savedMyDocumentCard(SavedMyDocument document) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: AppColor.hintText.withValues(alpha: 0.2),
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
            color: AppColor.hintText,
          ),
          10.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextStyle(
                  text: document.fileName,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                2.verticalSpace,
                AppTextStyle(
                  text: '${document.fileSize} • ${document.uploadedAt}',
                  fontSize: 11.sp,
                  color: AppColor.hintText,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => controller.downloadMyDocument(document),
            child: Icon(
              Icons.download_outlined,
              color: AppColor.hintText,
              size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _myDocsUploadForm() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...controller.personalDocumentFields.expand(
                  (field) => [
                    DocumentUploadField(
                      label: field.label,
                      isRequired: field.isRequired,
                      fieldColor: AppColor.background,
                      uploadAccentColor: AppColor.error,
                      filePathObs: field.pathObs,
                      onTap: () =>
                          controller.showUploadSourceSheet(field.pathObs),
                      onRemove: () => controller.removeFile(field.pathObs),
                    ),
                    14.verticalSpace,
                  ],
                ),
                _myDocsUploadedSection(),
              ],
            ),
          ),
        ),
        _myDocsBottomActions(),
      ],
    );
  }

  Widget _myDocsUploadedSection() {
    return Obx(() {
      final uploaded = controller.uploadedPersonalFormDocuments;
      if (uploaded.isEmpty) return const SizedBox.shrink();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextStyle(
            text: 'Uploaded (${uploaded.length})',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
          10.verticalSpace,
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
                            text: controller.fileName(filePath),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          2.verticalSpace,
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

  Widget _myDocsBottomActions() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
      child: Obx(() {
        final usePrimary = controller.hasPersonalFormUploads;

        return Column(
          children: [
            _loadDocsActionButton(
              text: 'Submit',
              onTap: controller.isLoading.value
                  ? null
                  : controller.submitMyDocs,
              isLoading: controller.isLoading.value,
              usePrimary: usePrimary,
            ),
            10.verticalSpace,
            _loadDocsActionButton(
              text: 'Send to Broker',
              onTap: controller.isLoading.value
                  ? null
                  : controller.sendMyDocsToBroker,
              usePrimary: usePrimary,
            ),
            10.verticalSpace,
            _loadDocsActionButton(
              text: 'Cancel',
              onTap: controller.cancelMyDocsForm,
              isOutlined: true,
              usePrimary: usePrimary,
            ),
          ],
        );
      }),
    );
  }
}
