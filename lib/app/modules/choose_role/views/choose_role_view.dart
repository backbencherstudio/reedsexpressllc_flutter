import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/choose_role_controller.dart';

class ChooseRoleView extends GetView<ChooseRoleController> {
  const ChooseRoleView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChooseRoleView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ChooseRoleView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
