import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/utils/image_picker_helper.dart';

class PersonalInfoController extends GetxController {
  final isEditing = false.obs;
  
  final fullNameController = TextEditingController(text: 'Marcus Johnson');
  final contactController = TextEditingController(text: '+8416926');
  final emailController = TextEditingController(text: 'yourmail@gmail.com');

  final profileImage = Rxn<File>();

  void toggleEdit() {
    isEditing.value = !isEditing.value;
  }

  Future<void> pickProfilePicture() async {
    final pickedFile = await ImagePickerHelper.pickSingleFile(
      imageSource: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
    }
  }
}
