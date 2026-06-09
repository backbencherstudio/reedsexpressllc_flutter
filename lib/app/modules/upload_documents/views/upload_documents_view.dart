import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/constants/enums.dart';
import 'package:reedsexpressllc_flutter/app/core/extensions/sizedbox_extension.dart';
import 'package:reedsexpressllc_flutter/app/core/theme/app_color.dart';
import 'package:reedsexpressllc_flutter/app/core/utils/helper_utils.dart';
import 'package:reedsexpressllc_flutter/app/routes/app_pages.dart';
import 'package:reedsexpressllc_flutter/app/widgets/app_input_text_form_field.dart';
import 'package:reedsexpressllc_flutter/app/widgets/app_text_style.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_dialog.dart';
import 'package:reedsexpressllc_flutter/app/widgets/document_upload_field.dart';
import 'package:reedsexpressllc_flutter/app/widgets/global_button.dart';
import 'package:reedsexpressllc_flutter/app/widgets/global_loading.dart';
import 'package:reedsexpressllc_flutter/app/widgets/global_tost.dart';
import 'package:reedsexpressllc_flutter/gen/assets.gen.dart';

import '../controllers/upload_documents_controller.dart';
import '../widgets/signature_email_field.dart';

class UploadDocumentsView extends GetView<UploadDocumentsController> {
  const UploadDocumentsView({super.key});

  static const _uploadAccentColor = AppColor.error;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final isDriver = UserRole.isDriverRole(HelperUtils.userRole);

    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(15.w, 20.h, 15.w, 20.h),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      25.height,
                      if (isDriver)
                        ..._buildDriverFields()
                      else
                        ..._buildCarrierFields(),
                      20.height,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 20.h),
              child: Obx(
                () => controller.isLoading.value
                    ? const GlobalLoading()
                    : GlobalButton(
                        text: 'Next',
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            controller.uploadDocuments();
                          } else {
                            globalToast(
                              message: 'Please fix all errors in the form',
                            );
                          }
                          Get.dialog(
                            barrierDismissible: false,
                            CustomDialog(
                              iconPath: Assets.icons.doneDoubleSticker,
                              // iconHeight: 50.h,
                              // iconWidth: 50.w,
                              title: "Registration Successful!",
                              subtitle:
                              "Thank you for signing up. We're excited to have you with us. You can now start exploring all the features we have to offer.",
                              bottomWidget: GlobalButton(
                                onTap: () {
                                  Get.offAllNamed(Routes.MAIN_PAGE);
                                },
                                text: "Go to Home page",
                              ),
                            ),
                          );
                        },
                        color: AppColor.primaryDisable,
                        textColor: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
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
              'Upload your required documents to get approved and start receiving loads.',
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColor.hintText,
        ),
      ],
    );
  }

  List<Widget> _buildDriverFields() {
    return [
      InputFieldWithLabel(
        controller: controller.truckNumberController,
        label: 'Truck Number',
        hintText: 'Enter truck number',
        validator: _requiredValidator,
      ),
      15.height,
      InputFieldWithLabel(
        controller: controller.truckLicensePlateNumberController,
        label: 'Truck License Plate Number',
        hintText: 'Enter truck license plate number',
        validator: _requiredValidator,
      ),
      15.height,
      _documentField(
        label: 'Driver Card',
        filePathObs: controller.driverCardPath,
      ),
      15.height,
      _documentField(
        label: 'Medical License',
        filePathObs: controller.medicalLicensePath,
      ),
      15.height,
      _documentField(
        label: 'Medical Card',
        filePathObs: controller.medicalCardPath,
      ),
      15.height,
      _documentField(
        label: 'Vehicle Registration',
        filePathObs: controller.vehicleRegistrationPath,
      ),
      15.height,
      _documentField(label: 'Permit', filePathObs: controller.permitPath),
      15.height,
      _documentField(
        label: 'Traffic Ticket',
        filePathObs: controller.trafficTicketPath,
        isRequired: false,
      ),
      15.height,
      _documentField(
        label: 'Receipt',
        filePathObs: controller.receiptPath,
        isRequired: false,
      ),
    ];
  }

  List<Widget> _buildCarrierFields() {
    return [
      InputFieldWithLabel(
        controller: controller.carrierNameController,
        label: 'Carrier Name',
        hintText: 'Enter Carrier Name',
        validator: _requiredValidator,
      ),
      15.height,
      InputFieldWithLabel(
        controller: controller.mCNumberController,
        label: 'MC Number',
        hintText: 'Enter MC number',
        validator: _requiredValidator,
      ),
      15.height,
      InputFieldWithLabel(
        controller: controller.dOTNumberController,
        label: 'DOT Number',
        hintText: 'Enter DOT number',
        validator: _requiredValidator,
      ),
      15.height,
      InputFieldWithLabel(
        controller: controller.eINNumberController,
        label: 'EIN Number',
        hintText: 'Enter EIN number',
        validator: _requiredValidator,
      ),
      15.height,
      _documentField(
        label: 'MC Authority',
        filePathObs: controller.mcAuthorityPath,
      ),
      15.height,
      _documentField(
        label: 'Void Check (Optional)',
        filePathObs: controller.voidCheckPath,
        isRequired: false,
      ),
      15.height,
      _documentField(label: 'W-9', filePathObs: controller.w9Path),
      20.height,
      _buildSignatureSection(),
    ];
  }

  Widget _buildSignatureSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.hintText.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextStyle(
            text: 'Signature Required',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
          15.height,
          const SignatureEmailField(label: 'Carrier Contract'),
          15.height,
          const SignatureEmailField(label: 'Limited Power of Attorney'),
        ],
      ),
    );
  }

  Widget _documentField({
    required String label,
    required RxnString filePathObs,
    bool isRequired = true,
  }) {
    return DocumentUploadField(
      label: label,
      filePathObs: filePathObs,
      isRequired: isRequired,
      uploadAccentColor: _uploadAccentColor,
      onTap: () => controller.pickFile(filePathObs),
      onRemove: () => controller.removeFile(filePathObs),
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }
}
