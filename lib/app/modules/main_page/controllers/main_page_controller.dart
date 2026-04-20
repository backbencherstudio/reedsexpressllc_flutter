import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/modules/documents/views/documents_view.dart';
import 'package:reedsexpressllc_flutter/app/modules/load/views/load_view.dart';
import 'package:reedsexpressllc_flutter/app/modules/message/views/message_view.dart';
import 'package:reedsexpressllc_flutter/app/modules/profile/views/profile_view.dart';

import '../../home/views/home_view.dart';

class MainPageController extends GetxController {
  final selectedIndex = 0.obs;

  final List<Widget> pages = const [
    HomeView(),
    LoadView(), // replace with your actual screen
    MessageView(), // replace with your actual screen
    DocumentsView(), // replace with your actual screen
    ProfileView(), // replace with your actual screen
  ];

  void changePage(int index) => selectedIndex.value = index;
}
