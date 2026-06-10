import 'package:get/get.dart';

import '../controllers/track_load_controller.dart';

class TrackLoadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrackLoadController>(
      () => TrackLoadController(),
    );
  }
}
