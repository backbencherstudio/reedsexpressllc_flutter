import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:reedsexpressllc_flutter/app/core/utils/image_picker_helper.dart';
import 'package:reedsexpressllc_flutter/app/core/utils/logger.dart';
import 'package:reedsexpressllc_flutter/app/widgets/global_tost.dart';
import 'package:reedsexpressllc_flutter/app/widgets/upload_source_bottom_sheet.dart';

class LoadDocumentField {
  const LoadDocumentField({
    required this.label,
    required this.pathObs,
    this.isRequired = false,
  });

  final String label;
  final RxnString pathObs;
  final bool isRequired;
}

class SavedMyDocument {
  const SavedMyDocument({
    required this.fileName,
    required this.fileSize,
    required this.uploadedAt,
    required this.groupDate,
  });

  final String fileName;
  final String fileSize;
  final String uploadedAt;
  final String groupDate;
}

class DocumentsController extends GetxController {
  final selectedTabIndex = 0.obs;
  final selectedLoad = RxnString();
  final isLoadDropdownOpen = false.obs;
  final isLoading = false.obs;
  final showMyDocsUploadForm = false.obs;

  // ── Load Docs tab upload fields ────────────────────────
  final bolPath = RxnString();
  final podPath = RxnString();
  final rateConfirmationPath = RxnString();
  final scaleTicketPath = RxnString();
  final lumperFeePath = RxnString();
  final inspectionReportPath = RxnString();

  // ── My Uploaded Docs tab upload fields ───────────────
  final cdlPath = RxnString();
  final medicalCardPath = RxnString();
  final vehicleRegistrationPath = RxnString();
  final cabCardPath = RxnString();
  final otherDocumentsPath = RxnString();

  final savedMyDocuments = <SavedMyDocument>[
    const SavedMyDocument(
      fileName: "Driver's License. pdf",
      fileSize: '0.87 MB',
      uploadedAt: 'Feb 23, 2026, 09:06 PM',
      groupDate: 'Feb 15, 2026, 09:34 AM',
    ),
    const SavedMyDocument(
      fileName: 'Medical Card. PDF',
      fileSize: '0.87 MB',
      uploadedAt: 'Feb 23, 2026, 09:06 PM',
      groupDate: 'Feb 15, 2026, 09:34 AM',
    ),
    const SavedMyDocument(
      fileName: 'Vehicle Registration. PDF',
      fileSize: '0.87 MB',
      uploadedAt: 'Feb 23, 2026, 09:06 PM',
      groupDate: 'Feb 15, 2026, 09:34 AM',
    ),
  ].obs;

  final loadOptions = <String>[
    'LD-2026-001',
    'LD-2026-002',
    'LD-2026-003',
    'LD-2026-004',
  ];

  List<LoadDocumentField> get loadDocumentFields => [
    LoadDocumentField(
      label: 'BOL - Bill of Lading',
      pathObs: bolPath,
      isRequired: true,
    ),
    LoadDocumentField(
      label: 'POD - Proof of Delivery',
      pathObs: podPath,
      isRequired: true,
    ),
    LoadDocumentField(
      label: 'Rate Confirmation',
      pathObs: rateConfirmationPath,
    ),
    LoadDocumentField(
      label: 'Scale Ticket',
      pathObs: scaleTicketPath,
    ),
    LoadDocumentField(
      label: 'Lumper fee',
      pathObs: lumperFeePath,
    ),
    LoadDocumentField(
      label: 'Inspection Report',
      pathObs: inspectionReportPath,
    ),
  ];

  List<LoadDocumentField> get personalDocumentFields => [
    LoadDocumentField(label: 'CDL', pathObs: cdlPath, isRequired: true),
    LoadDocumentField(
      label: 'Medical Card',
      pathObs: medicalCardPath,
      isRequired: true,
    ),
    LoadDocumentField(
      label: 'Vehicle Registration',
      pathObs: vehicleRegistrationPath,
      isRequired: true,
    ),
    LoadDocumentField(
      label: 'Cab Card (If applicable)',
      pathObs: cabCardPath,
    ),
    LoadDocumentField(
      label: 'Other Documents',
      pathObs: otherDocumentsPath,
    ),
  ];

  List<LoadDocumentField> get uploadedLoadDocuments =>
      loadDocumentFields.where((field) => field.pathObs.value != null).toList();

  List<LoadDocumentField> get uploadedPersonalFormDocuments =>
      personalDocumentFields
          .where((field) => field.pathObs.value != null)
          .toList();

  bool get hasPersonalFormUploads => uploadedPersonalFormDocuments.isNotEmpty;

  Map<String, List<SavedMyDocument>> get groupedSavedMyDocuments {
    final grouped = <String, List<SavedMyDocument>>{};
    for (final doc in savedMyDocuments) {
      grouped.putIfAbsent(doc.groupDate, () => []).add(doc);
    }
    return grouped;
  }

  void selectTab(int index) => selectedTabIndex.value = index;

  void toggleLoadDropdown() {
    isLoadDropdownOpen.value = !isLoadDropdownOpen.value;
  }

  void selectLoad(String load) {
    selectedLoad.value = load;
    isLoadDropdownOpen.value = false;
  }

  void openMyDocsUploadForm() {
    clearMyDocsForm();
    showMyDocsUploadForm.value = true;
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

  String _currentUploadedAt() {
    final now = DateTime.now();
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final hour = now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);
    final period = now.hour >= 12 ? 'PM' : 'AM';
    final minute = now.minute.toString().padLeft(2, '0');
    return '${months[now.month - 1]} ${now.day}, ${now.year}, '
        '$hour:$minute $period';
  }

  String _currentGroupDate() {
    final now = DateTime.now();
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final hour = now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);
    final period = now.hour >= 12 ? 'PM' : 'AM';
    final minute = now.minute.toString().padLeft(2, '0');
    return '${months[now.month - 1]} ${now.day}, ${now.year}, '
        '$hour:$minute $period';
  }

  void _savePersonalFormDocuments() {
    final groupDate = _currentGroupDate();
    final uploadedAt = _currentUploadedAt();

    for (final field in personalDocumentFields) {
      final path = field.pathObs.value;
      if (path == null) continue;

      savedMyDocuments.add(
        SavedMyDocument(
          fileName: fileName(path),
          fileSize: formatFileSize(path),
          uploadedAt: uploadedAt,
          groupDate: groupDate,
        ),
      );
    }
  }

  bool _validateLoadDocs() {
    if (selectedLoad.value == null) {
      globalToast(message: 'Please select a load');
      return false;
    }

    if (bolPath.value == null) {
      globalToast(message: 'Please upload BOL - Bill of Lading');
      return false;
    }

    if (podPath.value == null) {
      globalToast(message: 'Please upload POD - Proof of Delivery');
      return false;
    }

    return true;
  }

  bool _validateMyDocsForm() {
    if (cdlPath.value == null) {
      globalToast(message: 'Please upload CDL');
      return false;
    }

    if (medicalCardPath.value == null) {
      globalToast(message: 'Please upload Medical Card');
      return false;
    }

    if (vehicleRegistrationPath.value == null) {
      globalToast(message: 'Please upload Vehicle Registration');
      return false;
    }

    return true;
  }

  Future<void> submitLoadDocs() async {
    if (!_validateLoadDocs()) return;

    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));
      globalToast(message: 'Documents submitted successfully');
    } catch (e) {
      Log.e(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendToBroker() async {
    if (!_validateLoadDocs()) return;

    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));
      globalToast(message: 'Documents sent to broker successfully');
    } catch (e) {
      Log.e(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitMyDocs() async {
    if (!_validateMyDocsForm()) return;

    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));
      _savePersonalFormDocuments();
      clearMyDocsForm();
      showMyDocsUploadForm.value = false;
      globalToast(message: 'Documents submitted successfully');
    } catch (e) {
      Log.e(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendMyDocsToBroker() async {
    if (!_validateMyDocsForm()) return;

    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));
      _savePersonalFormDocuments();
      clearMyDocsForm();
      showMyDocsUploadForm.value = false;
      globalToast(message: 'Documents sent to broker successfully');
    } catch (e) {
      Log.e(e);
    } finally {
      isLoading.value = false;
    }
  }

  void cancelLoadDocs() {
    selectedLoad.value = null;
    isLoadDropdownOpen.value = false;
    bolPath.value = null;
    podPath.value = null;
    rateConfirmationPath.value = null;
    scaleTicketPath.value = null;
    lumperFeePath.value = null;
    inspectionReportPath.value = null;
  }

  void clearMyDocsForm() {
    cdlPath.value = null;
    medicalCardPath.value = null;
    vehicleRegistrationPath.value = null;
    cabCardPath.value = null;
    otherDocumentsPath.value = null;
  }

  void cancelMyDocsForm() {
    clearMyDocsForm();
    showMyDocsUploadForm.value = false;
  }

  void downloadMyDocument(SavedMyDocument document) {
    globalToast(message: 'Downloading ${document.fileName}');
  }
}
