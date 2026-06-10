import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:reedsexpressllc_flutter/app/core/utils/image_picker_helper.dart';
import 'package:reedsexpressllc_flutter/app/core/utils/logger.dart';
import 'package:reedsexpressllc_flutter/app/widgets/global_tost.dart';
import 'package:reedsexpressllc_flutter/app/widgets/upload_source_bottom_sheet.dart';

class CarrierDocumentField {
  const CarrierDocumentField({
    required this.label,
    required this.pathObs,
    required this.tag,
    required this.tagColor,
  });

  final String label;
  final RxnString pathObs;
  final String tag;
  final Color tagColor;
}

class CarrierSavedDocument {
  const CarrierSavedDocument({
    required this.fileName,
    required this.fileSize,
    required this.uploadedAt,
    required this.tag,
    required this.tagColor,
  });

  final String fileName;
  final String fileSize;
  final String uploadedAt;
  final String tag;
  final Color tagColor;
}

class CarrierInfoDocsController extends GetxController {
  final isEditing = false.obs;
  final isLoading = false.obs;

  final carrierNameController = TextEditingController(text: 'RF Logistics');
  final dotNumberController = TextEditingController(text: '24667788');
  final mcNumberController = TextEditingController(text: '24667788');

  final driverCardPath = RxnString();
  final medicalLicensePath = RxnString();
  final medicalCardPath = RxnString();
  final vehicleRegistrationPath = RxnString();
  final permitPath = RxnString();
  final trafficTicketPath = RxnString();
  final receiptPath = RxnString();

  final savedDocuments = <CarrierSavedDocument>[
    const CarrierSavedDocument(
      fileName: 'Driver Card.pdf',
      fileSize: '0.87 MB',
      uploadedAt: 'Mar 23, 2026, 09:06 PM',
      tag: 'Driver Card',
      tagColor: Color(0xFFE8A020),
    ),
    const CarrierSavedDocument(
      fileName: 'Permit.PDF',
      fileSize: '0.87 MB',
      uploadedAt: 'Mar 23, 2026, 09:06 PM',
      tag: 'Permit',
      tagColor: Color(0xFFE8A020),
    ),
  ].obs;

  List<CarrierDocumentField> get documentFields => [
    CarrierDocumentField(
      label: 'Driver Card',
      pathObs: driverCardPath,
      tag: 'Driver Card',
      tagColor: const Color(0xFFE8A020),
    ),
    CarrierDocumentField(
      label: 'Medical License',
      pathObs: medicalLicensePath,
      tag: 'Medical License',
      tagColor: const Color(0xFF2196F3),
    ),
    CarrierDocumentField(
      label: 'Medical Card',
      pathObs: medicalCardPath,
      tag: 'Medical Card',
      tagColor: const Color(0xFF2196F3),
    ),
    CarrierDocumentField(
      label: 'Vehicle Registration',
      pathObs: vehicleRegistrationPath,
      tag: 'Vehicle Registration',
      tagColor: const Color(0xFF4CAF50),
    ),
    CarrierDocumentField(
      label: 'Permit',
      pathObs: permitPath,
      tag: 'Permit',
      tagColor: const Color(0xFFE8A020),
    ),
    CarrierDocumentField(
      label: 'Traffic Ticket',
      pathObs: trafficTicketPath,
      tag: 'Traffic Ticket',
      tagColor: const Color(0xFF9C27B0),
    ),
    CarrierDocumentField(
      label: 'Receipt',
      pathObs: receiptPath,
      tag: 'Receipt',
      tagColor: const Color(0xFF607D8B),
    ),
  ];

  bool get hasSavedProfile => savedDocuments.isNotEmpty;

  bool get useCancelSubmitLayout => isEditing.value && !hasSavedProfile;

  @override
  void onInit() {
    _syncEditPathsFromSaved();
    super.onInit();
  }

  void toggleEdit() {
    if (isEditing.value) {
      _restoreFormFromSaved();
      isEditing.value = false;
      return;
    }

    _syncEditPathsFromSaved();
    isEditing.value = true;
  }

  void _syncEditPathsFromSaved() {
    for (final field in documentFields) {
      field.pathObs.value = null;
    }

    if (savedDocuments.isEmpty) return;

    const demoPath = '/mock/Driver_card.pdf';
    for (final field in documentFields) {
      field.pathObs.value = demoPath;
    }
  }

  void _restoreFormFromSaved() {
    carrierNameController.text = 'RF Logistics';
    dotNumberController.text = '24667788';
    mcNumberController.text = '24667788';
    _syncEditPathsFromSaved();
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

  void removeFile(RxnString targetObs) => targetObs.value = null;

  String fileName(String filePath) => p.basename(filePath);

  String formatFileSize(String filePath) {
    if (filePath.startsWith('/mock/')) return '0.87 MB';

    try {
      final bytes = File(filePath).lengthSync();
      if (bytes < 1024) return '$bytes B';
      if (bytes < 1024 * 1024) {
        return '${(bytes / 1024).toStringAsFixed(2)} KB';
      }
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    } catch (_) {
      return '0.87 MB';
    }
  }

  String _currentUploadedAt() {
    return 'Mar 23, 2026, 09:06 PM';
  }

  bool _validateForm() {
    if (carrierNameController.text.trim().isEmpty) {
      globalToast(message: 'Please enter Carrier Name');
      return false;
    }

    if (dotNumberController.text.trim().isEmpty) {
      globalToast(message: 'Please enter DOT Number');
      return false;
    }

    if (mcNumberController.text.trim().isEmpty) {
      globalToast(message: 'Please enter MC Number');
      return false;
    }

    for (final field in documentFields) {
      if (field.pathObs.value == null) {
        globalToast(message: 'Please upload ${field.label}');
        return false;
      }
    }

    return true;
  }

  void _persistDocuments() {
    savedDocuments.assignAll(
      documentFields.map((field) {
        final path = field.pathObs.value!;
        return CarrierSavedDocument(
          fileName: fileName(path),
          fileSize: formatFileSize(path),
          uploadedAt: _currentUploadedAt(),
          tag: field.tag,
          tagColor: field.tagColor,
        );
      }).toList(),
    );
  }

  Future<void> submitProfile() async {
    if (!_validateForm()) return;

    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));
      _persistDocuments();
      isEditing.value = false;
      globalToast(message: 'Carrier info submitted successfully');
    } catch (e) {
      Log.e(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveChanges() async {
    await submitProfile();
  }

  void cancelEdit() {
    if (!hasSavedProfile) {
      carrierNameController.clear();
      dotNumberController.clear();
      mcNumberController.clear();
      for (final field in documentFields) {
        field.pathObs.value = null;
      }
    } else {
      _restoreFormFromSaved();
    }
    isEditing.value = false;
  }

  void downloadDocument(CarrierSavedDocument document) {
    globalToast(message: 'Downloading ${document.fileName}');
  }

  @override
  void onClose() {
    carrierNameController.dispose();
    dotNumberController.dispose();
    mcNumberController.dispose();
    super.onClose();
  }
}
