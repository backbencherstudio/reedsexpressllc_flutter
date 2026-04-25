import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/widgets/global_button.dart';

import '../../../../gen/assets.gen.dart';
import '../../../core/constants/enums.dart';
import '../../../core/utils/logger.dart';
import '../../../core/widgets/custom_dialog.dart';
import '../../../data/models/tracking_status_model.dart';

class LoadDetailsController extends GetxController {
  final isLoading = false.obs;

  // Upload dialog fields
  final podPath = RxnString();
  final bolPath = RxnString();
  final rateConfirmationPath = RxnString();
  final scaleTicketPath = RxnString();
  final lumperFeePath = RxnString();
  final inspectionReportPath = RxnString();

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

  void clearAllUploads() {
    podPath.value = null;
    bolPath.value = null;
    rateConfirmationPath.value = null;
    scaleTicketPath.value = null;
    lumperFeePath.value = null;
    inspectionReportPath.value = null;
  }

  Future<void> submitDocuments() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));
      clearAllUploads();
      Get.back();

      Get.dialog(
        CustomDialog(
          iconPath: Assets.icons.doneSticker,
          title: "Done!",
          subtitle: "Your document has been uploaded successfully!",
          bottomWidget: globalButton(
            onTap: () {
              Get.back();
              Get.back();
            },
            text: "Back",
          ),
        ),
      );
    } catch (e) {
      Log.e(e);
    } finally {
      isLoading.value = false;
    }
  }

  final loadDetails = Rx<LoadDetailsModel>(
    LoadDetailsModel(
      loadId: 'LD-2024-001',
      date: '24 Aug, 2026',
      status: LoadStatus.pickup,
      miles: 247,
      pay: 860.00,
      pickupCompany: 'Delta Housing LTD',
      pickupAddress: 'Memphis, TN, 2200 Airways Blvd, TN 33116',
      pickupTime: '12:00 AM',
      pickupDate: '10 March, 2026',
      deliveryCompany: 'Crimson Garage',
      deliveryAddress: 'Atlanta, GA, 3900 Rd, Atlanta, GA 30380',
      deliveryTime: '10:00 AM',
      deliveryDate: '13 March, 2026',
      brokerName: 'Johnny Harris',
      brokerReference: 'Reference No. 123- 12324ABC',
      brokerEmail: 'broker@gmail.com',
      brokerPhone: '+33 2132345',
      additionalNotes:
          'Lorem ipsum dolor sit amet consectetur. Faucibus leo tempor in sapien ut quam pulvinar vulputate aliquam.',
      trackingSteps: const [
        TrackingStepModel(
          title: 'Assigned',
          dateTime: '12 Feb 2025 — 09:00',
          status: TrackingStatus.assigned,
          isDone: true,
        ),
        TrackingStepModel(
          title: 'Pickup',
          dateTime: '12 Feb 2025 — 09:00',
          status: TrackingStatus.pickup,
          isDone: true,
        ),
        TrackingStepModel(
          title: 'Delivered',
          dateTime: '12 Feb 2025 — 09:00',
          status: TrackingStatus.delivered,
          isActive: true,
        ),
        TrackingStepModel(
          title: 'Completed',
          dateTime: '12 Feb 2025 — 09:00',
          status: TrackingStatus.completed,
          subNote: 'Upload documents to mark completed',
        ),
      ],
      uploadedDocuments: [
        UploadedDocumentModel(
          fileName: 'POD - Proof of Delivery.pdf',
          fileSize: '0.87 MB',
          uploadedAt: 'Mar 23, 2026, 09:06 PM',
          tag: 'POD',
          tagColor: Color(0xFFE8A020),
        ),
        UploadedDocumentModel(
          fileName: 'BOL - Bill of Lading',
          fileSize: '0.87 MB',
          uploadedAt: 'Mar 23, 2026, 09:06 PM',
          tag: 'Rate Confirmation',
          tagColor: Color(0xFF2196F3),
        ),
        UploadedDocumentModel(
          fileName: 'BOL - Bill of Lading',
          fileSize: '0.87 MB',
          uploadedAt: 'Mar 23, 2026, 09:06 PM',
          tag: 'BOL',
          tagColor: Color(0xFF4CAF50),
        ),
      ],
    ),
  );

  void markDone() {
    // TODO: implement mark done API call
  }
}
