import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import '../../../core/utils/logger.dart';
import '../../../routes/app_pages.dart';

class UploadDocumentsController extends GetxController {
  final isLoading = false.obs;

  // Each document field as an observable RxnString (nullable path)
  final driverCardPath = RxnString();
  final medicalLicensePath = RxnString();
  final medicalCardPath = RxnString();
  final vehicleRegistrationPath = RxnString();
  final permitPath = RxnString();
  final trafficTicketPath = RxnString();
  final receiptPath = RxnString();

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
  }

  Future<void> uploadDocuments() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));
      Get.offAllNamed(Routes.MAIN_PAGE);
    } catch (e) {
      Log.e(e);
    } finally {
      isLoading.value = false;
    }
  }
}
