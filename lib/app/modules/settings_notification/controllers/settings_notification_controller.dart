import 'package:get/get.dart';

class SettingsNotificationController extends GetxController {
  final inAppNotification = true.obs;
  final emailNotification = true.obs;
  final newLoadAssignment = true.obs;
  final vehicleInfoUpdate = false.obs;
  final docVerificationUpdate = false.obs;

  void toggleInApp(bool value) => inAppNotification.value = value;
  void toggleEmail(bool value) => emailNotification.value = value;
  void toggleNewLoad(bool value) => newLoadAssignment.value = value;
  void toggleVehicleInfo(bool value) => vehicleInfoUpdate.value = value;
  void toggleDocVerif(bool value) => docVerificationUpdate.value = value;
}
