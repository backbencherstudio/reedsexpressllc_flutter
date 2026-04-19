import 'package:get/get.dart';

import '../../../core/constants/enums.dart';
import '../../../core/utils/logger.dart';
import '../../../data/models/load_model.dart';

class LoadController extends GetxController {
  //TODO: Implement LoadController
  final isLoading = true.obs;
  bool isInit = false;
  bool isEndPage = false;
  int pagination = 10;
  final currentPage = 0.obs;

  Future<void> getRestaurant({bool isRefresh = true}) async {
    try {
      if (isRefresh == true) {
        currentPage.value = 0;
        isEndPage = false;
        isInit = true;
        update(['update_loads']);
      }
      isLoading.value = true;

      await Future.delayed(Duration(seconds: 1));

      if (currentPage.value == 0) {
        // activeLoads.value = restaurants;
      } else {
        // activeLoads.addAll(restaurants);
      }
      currentPage.value++;
      // if (restaurants.isEmpty) {
      //   isEndPage = true;
      // }

      if (isInit == true) {
        isInit = false;
        update(['update_loads']);
      }
    } catch (e) {
      Log.e(e);
      if (isInit == true) {
        isInit = false;
        update(['update_loads']);
      }
    } finally {
      isLoading.value = false;
    }
  }

  final activeLoads = <LoadModel>[
    const LoadModel(
      loadId: 'RX-2847',
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
