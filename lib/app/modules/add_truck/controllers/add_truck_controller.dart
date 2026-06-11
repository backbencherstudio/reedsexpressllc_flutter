import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reedsexpressllc_flutter/app/core/utils/image_picker_helper.dart';
import 'package:reedsexpressllc_flutter/app/core/utils/logger.dart';
import 'package:reedsexpressllc_flutter/app/data/models/truck_model.dart';
import 'package:reedsexpressllc_flutter/app/widgets/global_tost.dart';
import 'package:reedsexpressllc_flutter/app/widgets/upload_source_bottom_sheet.dart';

import '../../vehicle/controllers/vehicle_controller.dart';

class AddTruckController extends GetxController {
  final isLoading = false.obs;
  final isTruckTypeDropdownOpen = false.obs;

  final licensePlateController = TextEditingController(text: 'ABC-1234');
  final vinController = TextEditingController();
  final modelMakeController = TextEditingController();
  final unitNumberController = TextEditingController();

  final truckDocPath = RxnString();
  final cabCardPath = RxnString();

  final selectedTruckType = 'Box Truck'.obs;

  final truckTypes = <String>[
    'Box Truck',
    'Dry Van',
    'Flatbed',
    'Reefer',
    'Step Deck',
  ];

  void toggleTruckTypeDropdown() {
    isTruckTypeDropdownOpen.value = !isTruckTypeDropdownOpen.value;
  }

  void selectTruckType(String type) {
    selectedTruckType.value = type;
    isTruckTypeDropdownOpen.value = false;
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

  Future<void> createTruck() async {
    final unitNumber = unitNumberController.text.trim();
    if (unitNumber.isEmpty) {
      globalToast(message: 'Please enter a unit number');
      return;
    }

    try {
      isLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 800));

      if (Get.isRegistered<VehicleController>()) {
        Get.find<VehicleController>().addCreatedTruck(
          TruckModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            unitNumber: unitNumber,
            licensePlate: licensePlateController.text.trim(),
            truckType: selectedTruckType.value,
            vin: vinController.text.trim(),
            modelMake: modelMakeController.text.trim(),
          ),
        );
      }

      Get.back();
      globalToast(message: 'Truck created successfully');
    } catch (e) {
      Log.e(e);
    } finally {
      isLoading.value = false;
    }
  }

  void cancel() => Get.back();

  @override
  void onClose() {
    licensePlateController.dispose();
    vinController.dispose();
    modelMakeController.dispose();
    unitNumberController.dispose();
    super.onClose();
  }
}
