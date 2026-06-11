import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:reedsexpressllc_flutter/app/core/utils/image_picker_helper.dart';
import 'package:reedsexpressllc_flutter/app/core/utils/logger.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_dialog.dart';
import 'package:reedsexpressllc_flutter/app/widgets/global_button.dart';
import 'package:reedsexpressllc_flutter/app/widgets/global_tost.dart';
import 'package:reedsexpressllc_flutter/app/widgets/upload_source_bottom_sheet.dart';
import 'package:reedsexpressllc_flutter/gen/assets.gen.dart';

import '../../../routes/app_pages.dart';

class DriverDocumentField {
  const DriverDocumentField({
    required this.label,
    required this.pathObs,
    this.isRequired = false,
  });

  final String label;
  final RxnString pathObs;
  final bool isRequired;
}

class RegisterAsDriverController extends GetxController {
  final isLoading = false.obs;
  final canSubmitObs = false.obs;

  final truckNumberController = TextEditingController();
  final truckLicensePlateController = TextEditingController();

  final vehicleRegistrationPath = RxnString();
  final cdlPath = RxnString();
  final medicalCardPath = RxnString();
  final otherDocumentsPath = RxnString();

  List<DriverDocumentField> get documentFields => [
    DriverDocumentField(
      label: 'Vehicle Registration',
      pathObs: vehicleRegistrationPath,
      isRequired: true,
    ),
    DriverDocumentField(
      label: 'CDL (Commercial Driver’s License)',
      pathObs: cdlPath,
    ),
    DriverDocumentField(
      label: 'Medical Card',
      pathObs: medicalCardPath,
      isRequired: true,
    ),
    DriverDocumentField(
      label: 'Other Documents (Optional)',
      pathObs: otherDocumentsPath,
    ),
  ];

  List<DriverDocumentField> get uploadedDocuments =>
      documentFields.where((field) => field.pathObs.value != null).toList();

  bool get canSubmit {
    if (truckNumberController.text.trim().isEmpty) return false;
    if (truckLicensePlateController.text.trim().isEmpty) return false;
    if (vehicleRegistrationPath.value == null) return false;
    if (medicalCardPath.value == null) return false;
    return true;
  }

  @override
  void onInit() {
    super.onInit();
    truckNumberController.addListener(_refreshSubmitState);
    truckLicensePlateController.addListener(_refreshSubmitState);
    ever(vehicleRegistrationPath, (_) => _refreshSubmitState());
    ever(medicalCardPath, (_) => _refreshSubmitState());
    ever(cdlPath, (_) => _refreshSubmitState());
    ever(otherDocumentsPath, (_) => _refreshSubmitState());
    _refreshSubmitState();
  }

  void _refreshSubmitState() {
    canSubmitObs.value = canSubmit;
  }

  void showUploadSourceSheet(RxnString targetObs) {
    UploadSourceBottomSheet.show(
      onCameraTap: () => pickFromCamera(targetObs),
      onUploadFilesTap: () => pickFile(targetObs),
    );
  }

  Future<void> pickFromCamera(RxnString targetObs) async {
    try {
      final picked = await ImagePickerHelper.pickSingleFile(
        imageSource: ImageSource.camera,
      );
      if (picked != null) {
        targetObs.value = picked.path;
      }
    } catch (e) {
      Log.e(e);
    }
  }

  Future<void> pickFile(RxnString targetObs) async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      );
      if (result != null && result.files.single.path != null) {
        targetObs.value = result.files.single.path;
      }
    } catch (e) {
      Log.e(e);
    }
  }

  void removeFile(RxnString targetObs) {
    targetObs.value = null;
    _refreshSubmitState();
  }

  String displayFileName(DriverDocumentField field) {
    final filePath = field.pathObs.value;
    if (filePath == null) return '';
    final ext = p.extension(filePath).replaceFirst('.', '');
    return '${field.label} .$ext';
  }

  String formatFileSize(String filePath) {
    try {
      final bytes = File(filePath).lengthSync();
      if (bytes < 1024) return '$bytes B';
      if (bytes < 1024 * 1024) {
        return '${(bytes / 1024).toStringAsFixed(2)} KB';
      }
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    } catch (_) {
      return '';
    }
  }

  Future<void> submitRequest() async {
    if (!canSubmit) {
      globalToast(message: 'Please complete all required fields');
      return;
    }

    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));
      Get.dialog(
        barrierDismissible: false,
        CustomDialog(
          iconPath: Assets.icons.doneDoubleSticker,
          title: 'Document sent to Dispatcher',
          subtitle:
              "Thank you for your time. We're excited to have you with us.",
          bottomWidget: GlobalButton(
            onTap: () {
              Get.back(); // close the dialog
              Get.offAllNamed(Routes.MAIN_PAGE);
            },
            text: 'Go to Home page',
          ),
        ),
      );
    } catch (e) {
      Log.e(e);
    } finally {
      isLoading.value = false;
    }
  }

  void skip() {
    Get.back();
  }

  @override
  void onClose() {
    truckNumberController.dispose();
    truckLicensePlateController.dispose();
    super.onClose();
  }
}
