import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/modules/register/controllers/register_controller.dart';
import 'package:reedsexpressllc_flutter/app/routes/app_pages.dart';

import '../../../core/theme/app_colors.dart';
import '../../../widgets/auth_header.dart';
import '../../../widgets/document_upload_field.dart';
import '../../../widgets/global_button.dart';
import '../../../widgets/global_loading.dart';
import '../controllers/upload_documents_controller.dart';

// upload_documents_view.dart
class UploadDocumentsView extends GetView<UploadDocumentsController> {
  const UploadDocumentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            authHeader(
              isBackButton: Get.previousRoute == Routes.REGISTER ? false : true,
              title: "Upload Documents!",
              subTitle:
                  "Upload your required documents to get approved and start receiving loads.",
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      25.verticalSpace,

                      DocumentUploadField(
                        label: "Driver Card",
                        filePathObs: controller.driverCardPath,
                        onTap: () =>
                            controller.pickFile(controller.driverCardPath),
                        onRemove: () =>
                            controller.removeFile(controller.driverCardPath),
                      ),
                      15.verticalSpace,

                      DocumentUploadField(
                        label: "Medical License",
                        filePathObs: controller.medicalLicensePath,
                        onTap: () =>
                            controller.pickFile(controller.medicalLicensePath),
                        onRemove: () => controller.removeFile(
                          controller.medicalLicensePath,
                        ),
                      ),
                      15.verticalSpace,

                      DocumentUploadField(
                        label: "Medical Card",
                        filePathObs: controller.medicalCardPath,
                        onTap: () =>
                            controller.pickFile(controller.medicalCardPath),
                        onRemove: () =>
                            controller.removeFile(controller.medicalCardPath),
                      ),
                      15.verticalSpace,

                      DocumentUploadField(
                        label: "Vehicle Registration",
                        filePathObs: controller.vehicleRegistrationPath,
                        onTap: () => controller.pickFile(
                          controller.vehicleRegistrationPath,
                        ),
                        onRemove: () => controller.removeFile(
                          controller.vehicleRegistrationPath,
                        ),
                      ),
                      15.verticalSpace,

                      DocumentUploadField(
                        label: "Permit",
                        filePathObs: controller.permitPath,
                        onTap: () => controller.pickFile(controller.permitPath),
                        onRemove: () =>
                            controller.removeFile(controller.permitPath),
                      ),
                      15.verticalSpace,

                      DocumentUploadField(
                        label: "Traffic Ticket",
                        filePathObs: controller.trafficTicketPath,
                        onTap: () =>
                            controller.pickFile(controller.trafficTicketPath),
                        onRemove: () =>
                            controller.removeFile(controller.trafficTicketPath),
                      ),
                      15.verticalSpace,

                      DocumentUploadField(
                        label: "Receipt",
                        filePathObs: controller.receiptPath,
                        onTap: () =>
                            controller.pickFile(controller.receiptPath),
                        onRemove: () =>
                            controller.removeFile(controller.receiptPath),
                      ),

                      20.verticalSpace,

                      Align(
                        alignment: Alignment.center,
                        child: Obx(
                          () => controller.isLoading.value
                              ? const GlobalLoading()
                              : GlobalButton(
                                  text: "Next",
                                  onTap: controller.uploadDocuments,
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                        ),
                      ),

                      10.verticalSpace,

                      if (Get.previousRoute == Routes.REGISTER)
                        Align(
                          alignment: Alignment.center,
                          child: Obx(() {
                            final registerController =
                                Get.find<RegisterController>();
                            return registerController.isLoading.value
                                ? const GlobalLoading()
                                : GlobalButton(
                                    text: "Skip",
                                    color: AppColors.primaryDisable,
                                    onTap: registerController.register,
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  );
                          }),
                        ),

                      100.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
