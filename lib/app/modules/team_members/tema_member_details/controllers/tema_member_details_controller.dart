import 'package:get/get.dart';

import '../../../../data/models/team_member_model.dart';

class TemaMemberDetailsController extends GetxController {
  late final TeamMemberModel member;

  @override
  void onInit() {
    super.onInit();
    member = Get.arguments as TeamMemberModel;
  }

  void editField(String fieldLabel) {
    // UI phase stub — API integration will open edit flow per field.
  }
}
