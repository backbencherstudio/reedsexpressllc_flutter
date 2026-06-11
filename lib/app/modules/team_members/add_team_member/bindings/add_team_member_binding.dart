import 'package:get/get.dart';

import '../controllers/add_team_member_controller.dart';

class AddTeamMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTeamMemberController>(
      () => AddTeamMemberController(),
    );
  }
}
