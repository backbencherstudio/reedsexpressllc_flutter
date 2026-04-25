import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/extensions/sizedbox_extension.dart';
import 'package:reedsexpressllc_flutter/app/core/theme/app_colors.dart';
import 'package:reedsexpressllc_flutter/app/widgets/app_text_style.dart';
import 'package:reedsexpressllc_flutter/app/widgets/document_upload_field.dart';
import 'package:reedsexpressllc_flutter/app/modules/load_details/controllers/load_details_controller.dart';

class UploadDocumentsDialog extends GetView<LoadDetailsController> {
  const UploadDocumentsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(15.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextStyle(
              text: "Upload Required Documents",
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
            5.height,

            AppTextStyle(
              text: "Upload required documents to mark this as completed.",
              color: AppColors.hintText,
            ),
            20.height,

            DocumentUploadField(
              label: 'POD - Proof of Delivery',
              fieldColor: AppColors.background,
              filePathObs: controller.podPath,
              onTap: () => controller.pickFile(controller.podPath),
              onRemove: () => controller.removeFile(controller.podPath),
            ),
            14.verticalSpace,
            DocumentUploadField(
              label: 'BOL - Bill of Lading',
              fieldColor: AppColors.background,
              filePathObs: controller.bolPath,
              onTap: () => controller.pickFile(controller.bolPath),
              onRemove: () => controller.removeFile(controller.bolPath),
            ),
            14.verticalSpace,
            DocumentUploadField(
              label: 'Rate Confirmation',
              fieldColor: AppColors.background,
              filePathObs: controller.rateConfirmationPath,
              onTap: () => controller.pickFile(controller.rateConfirmationPath),
              onRemove: () =>
                  controller.removeFile(controller.rateConfirmationPath),
            ),
            14.verticalSpace,
            DocumentUploadField(
              label: 'Scale Ticket',
              fieldColor: AppColors.background,
              filePathObs: controller.scaleTicketPath,
              onTap: () => controller.pickFile(controller.scaleTicketPath),
              onRemove: () => controller.removeFile(controller.scaleTicketPath),
            ),
            14.verticalSpace,
            DocumentUploadField(
              label: 'Lumper fee',
              fieldColor: AppColors.background,
              filePathObs: controller.lumperFeePath,
              onTap: () => controller.pickFile(controller.lumperFeePath),
              onRemove: () => controller.removeFile(controller.lumperFeePath),
            ),
            14.verticalSpace,
            DocumentUploadField(
              label: 'Inspection Report',
              fieldColor: AppColors.background,
              filePathObs: controller.inspectionReportPath,
              onTap: () => controller.pickFile(controller.inspectionReportPath),
              onRemove: () =>
                  controller.removeFile(controller.inspectionReportPath),
            ),
            20.verticalSpace,

            // ── Action buttons ─────────────────────────
            Obx(
              () => Row(
                children: [
                  // Cancel
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        controller.clearAllUploads();
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 13.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: AppColors.primary,
                            width: 0.8,
                          ),
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
                      onTap: controller.isLoading.value
                          ? null
                          : controller.submitDocuments,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 13.h),
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
          ],
        ),
      ),
    );
  }
}
