import 'package:get/get.dart';

import '../../../../widgets/global_tost.dart';

class AssignVehicleController extends GetxController {
  final drivers = <String>[
    'Alan Walk',
    'John Ryan',
    'Jigsaw Kenny',
    'Michael Dustalyev',
  ];

  final selectedDriver = RxnString('Alan Walk');
  final isDropdownOpen = false.obs;
  final isLoading = false.obs;

  void toggleDropdown() {
    isDropdownOpen.value = !isDropdownOpen.value;
  }

  void selectDriver(String driver) {
    selectedDriver.value = driver;
    isDropdownOpen.value = false;
  }

  Future<void> assignNow() async {
    if (selectedDriver.value == null) {
      globalToast(message: 'Please select a driver');
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 600));
    isLoading.value = false;
    Get.back();
    globalToast(
      message: '${selectedDriver.value} assigned to truck successfully',
    );
  }
}
