import 'package:get/get.dart';

import '../../../core/constants/enums.dart';
import '../../../data/models/load_model.dart';

class HomeController extends GetxController {
  final isLoading = false.obs;

  final String userName = 'Marcus J.';
  final int totalLoads = 3;
  final int delivered = 2;
  final int miles = 247;

  final activeLoads = <LoadModel>[
    const LoadModel(
      loadId: 'RX-2847',
      date: '24 Aug, 2026',
      originCity: 'Memphis, TN',
      originAddress: '2200 Airways Blvd, TN 33116',
      originTime: '10:00 AM',
      destinationCity: 'Atlanta, GA',
      destinationAddress: '3900 Rd, Atlanta, GA 30380',
      miles: 247,
      pay: 860,
      status: LoadStatus.pickup,
    ),
    const LoadModel(
      loadId: 'RX-2901',
      date: '26 Aug, 2026',
      originCity: 'Nashville, TN',
      originAddress: '1500 Broadway, TN 37203',
      originTime: '08:30 AM',
      destinationCity: 'Birmingham, AL',
      destinationAddress: '200 Paul W Bryant Dr, AL 35401',
      miles: 191,
      pay: 720,
      status: LoadStatus.inTransit,
    ),
    const LoadModel(
      loadId: 'RX-3012',
      date: '28 Aug, 2026',
      originCity: 'Charlotte, NC',
      originAddress: '500 S College St, NC 28202',
      originTime: '09:00 AM',
      destinationCity: 'Richmond, VA',
      destinationAddress: '401 N 3rd St, VA 23219',
      miles: 334,
      pay: 1100,
      status: LoadStatus.delivered,
    ),
  ].obs;
}
