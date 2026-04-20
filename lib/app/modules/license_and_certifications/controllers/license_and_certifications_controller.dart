import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LicenseAndCertificationsController extends GetxController {
  final isEditing = false.obs;

  final licenseNumberController = TextEditingController(text: '3453453');
  final licenseState = 'Arizona'.obs;
  
  final licenseExpirationController = TextEditingController(text: '28/03/2027');
  final medicalCardExpirationController = TextEditingController(text: '28/03/2027');
  final registrationExpirationController = TextEditingController(text: '28/03/2027');

  void toggleEdit() {
    isEditing.value = !isEditing.value;
  }
}
