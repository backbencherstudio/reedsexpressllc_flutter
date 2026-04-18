import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/documents_controller.dart';

class DocumentsView extends GetView<DocumentsController> {
  const DocumentsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DocumentsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DocumentsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
