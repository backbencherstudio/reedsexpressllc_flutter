import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_dialog.dart';
import 'package:reedsexpressllc_flutter/app/widgets/global_button.dart';
import 'package:reedsexpressllc_flutter/gen/assets.gen.dart';

import '../../../core/utils/logger.dart';
import '../../../routes/app_pages.dart';

class UploadDocumentsController extends GetxController {
  final isLoading = false.obs;

  // Driver document fields
  final driverCardPath = RxnString();
  final medicalLicensePath = RxnString();
  final medicalCardPath = RxnString();
  final vehicleRegistrationPath = RxnString();
  final permitPath = RxnString();
  final trafficTicketPath = RxnString();
  final receiptPath = RxnString();

  // Carrier document fields
  final mcAuthorityPath = RxnString();
  final voidCheckPath = RxnString();
  final w9Path = RxnString();

  final truckNumberController = TextEditingController();
  final truckLicensePlateNumberController = TextEditingController();

  final carrierNameController = TextEditingController();
  final mCNumberController = TextEditingController();
  final dOTNumberController = TextEditingController();
  final eINNumberController = TextEditingController();

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
      await Future.delayed(const Duration(seconds: 1));
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
    } catch (e) {
      Log.e(e);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    truckNumberController.dispose();
    truckLicensePlateNumberController.dispose();
    carrierNameController.dispose();
    mCNumberController.dispose();
    dOTNumberController.dispose();
    eINNumberController.dispose();
    super.onClose();
  }
}
