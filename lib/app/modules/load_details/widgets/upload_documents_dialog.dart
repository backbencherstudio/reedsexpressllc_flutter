import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/extensions/sizedbox_extension.dart';
import 'package:reedsexpressllc_flutter/app/core/theme/app_color.dart';
import 'package:reedsexpressllc_flutter/app/widgets/app_text_style.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_svg_image.dart';
import 'package:reedsexpressllc_flutter/app/widgets/document_upload_field.dart';
import 'package:reedsexpressllc_flutter/app/modules/load_details/controllers/load_details_controller.dart';
import 'package:reedsexpressllc_flutter/gen/assets.gen.dart';

class UploadDocumentsDialog extends GetView<LoadDetailsController> {
  const UploadDocumentsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final load = controller.loadDetails.value;

    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(15.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      customSvgImage(
                        imagePath: Assets.icons.packageIcon,
                        color: AppColor.hintText,
                      ),
                      10.width,
                      AppTextStyle(
                        text: load.loadId,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  10.height,
                  Row(
                    children: [
                      customSvgImage(
                        imagePath: Assets.icons.calendarIcon,
                        color: AppColor.hintText,
                      ),
                      10.width,
                      AppTextStyle(
                        text: load.date,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            14.verticalSpace,
            DocumentUploadField(
              label: 'Scale Ticket',
              fieldColor: AppColor.background,
              filePathObs: controller.scaleTicketPath,
              onTap: () =>
                  controller.showUploadSourceSheet(controller.scaleTicketPath),
              onRemove: () =>
                  controller.removeFile(controller.scaleTicketPath),
            ),
            14.verticalSpace,
            DocumentUploadField(
              label: 'Lumper fee',
              fieldColor: AppColor.background,
              filePathObs: controller.lumperFeePath,
              onTap: () =>
                  controller.showUploadSourceSheet(controller.lumperFeePath),
              onRemove: () => controller.removeFile(controller.lumperFeePath),
            ),
            14.verticalSpace,
            DocumentUploadField(
              label: 'Inspection Report',
              fieldColor: AppColor.background,
              filePathObs: controller.inspectionReportPath,
              onTap: () => controller.showUploadSourceSheet(
                controller.inspectionReportPath,
              ),
              onRemove: () =>
                  controller.removeFile(controller.inspectionReportPath),
            ),
            20.verticalSpace,
            Obx(
              () => Row(
                children: [
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
                          : controller.submitDocuments,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 13.h),
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
          ],
        ),
      ),
    );
  }
}
