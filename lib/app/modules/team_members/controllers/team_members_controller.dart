import 'package:get/get.dart';

import '../../../data/models/team_member_model.dart';
import '../../../routes/app_pages.dart';

class TeamMembersController extends GetxController {
  final members = <TeamMemberModel>[
    const TeamMemberModel(
      id: '1',
      name: 'Alan Walk',
      carrier: 'Logic LTD',
      state: 'Mexico',
      contact: '+32 23234',
      cdlNumber: '213324 234324',
      registrationExpirationDate: '1/1/25',
      cdlExpirationDate: '1/1/25',
      medicalCardExpirationDate: '12/12/28',
    ),
    const TeamMemberModel(
      id: '2',
      name: 'John Ryan',
      carrier: 'Logic LTD',
      state: 'Texas',
      contact: '+1 555 0101',
      cdlNumber: '445566 778899',
      registrationExpirationDate: '3/15/25',
      cdlExpirationDate: '3/15/25',
      medicalCardExpirationDate: '6/20/28',
    ),
    const TeamMemberModel(
      id: '3',
      name: 'Jigsaw Kenny',
      carrier: 'Logic LTD',
      state: 'California',
      contact: '+1 555 0102',
      cdlNumber: '998877 665544',
      registrationExpirationDate: '5/10/25',
      cdlExpirationDate: '5/10/25',
      medicalCardExpirationDate: '9/01/28',
    ),
    const TeamMemberModel(
      id: '4',
      name: 'Michael Dustalyev',
      carrier: 'Logic LTD',
      state: 'Florida',
      contact: '+1 555 0103',
      cdlNumber: '112233 445566',
      registrationExpirationDate: '7/22/25',
      cdlExpirationDate: '7/22/25',
      medicalCardExpirationDate: '11/30/28',
    ),
  ].obs;

  void openMemberDetails(TeamMemberModel member) {
    Get.toNamed(Routes.TEMA_MEMBER_DETAILS, arguments: member);
  }

  void addDriver() {
    Get.toNamed(Routes.ADD_TEAM_MEMBER);
  }
}
