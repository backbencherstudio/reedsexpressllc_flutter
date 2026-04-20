import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/utils/logger.dart';

class DocumentsController extends GetxController {
  final selectedTabIndex = 0.obs;
  final selectedLoad = RxnString();
  final isLoading = false.obs;

  // Upload fields
  final podPath = RxnString();
  final bolPath = RxnString();
  final rateConfirmationPath = RxnString();
  final scaleTicketPath = RxnString();
  final lumperFeePath = RxnString();
  final inspectionReportPath = RxnString();

  final loadOptions = <String>[
    'Load #RX-2847 — Memphis to Atlanta',
    'Load #RX-2901 — Nashville to Birmingham',
    'Load #RX-3012 — Charlotte to Richmond',
  ];

  void selectTab(int index) => selectedTabIndex.value = index;

  void selectLoad(String? value) => selectedLoad.value = value;

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

  Future<void> submit() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));
      // TODO: API call
    } catch (e) {
      Log.e(e);
    } finally {
      isLoading.value = false;
    }
  }

  void cancel() {
    selectedLoad.value = null;
    podPath.value = null;
    bolPath.value = null;
    rateConfirmationPath.value = null;
    scaleTicketPath.value = null;
    lumperFeePath.value = null;
    inspectionReportPath.value = null;
  }
}
