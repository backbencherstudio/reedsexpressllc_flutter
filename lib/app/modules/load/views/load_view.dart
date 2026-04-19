import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/layouts/load_item_layout.dart';
import 'package:reedsexpressllc_flutter/app/core/theme/app_colors.dart';

import '../../../core/widgets/appbar_title.dart';
import '../../../core/widgets/global_loading.dart';
import '../../../core/widgets/show_empty_result.dart';
import '../../../routes/app_pages.dart';
import '../controllers/load_controller.dart';

class LoadView extends GetView<LoadController> {
  const LoadView({super.key});
  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<LoadController>()) {
      Get.put(LoadController());
    }
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: appbarTitle(text: 'Loads'),
      ),
      body: GetBuilder<LoadController>(
        id: 'update_loads',
        builder: (controller) {
          if (controller.isInit) {
            return GlobalLoading();
          } else if (controller.activeLoads.isEmpty) {
            return ShowEmptyResult(
              refreshOnTap: () {
                controller.getRestaurant(isRefresh: true);
              },
            );
          } else {
            return RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () async {
                controller.getRestaurant();
              },
              child: NotificationListener(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent &&
                      controller.isEndPage == false &&
                      controller.isLoading.value == false) {
                    controller.getRestaurant(isRefresh: false);
                  }
                  return false;
                },
                child: Obx(
                  () => ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    itemCount:
                        controller.activeLoads.length +
                        (controller.isLoading.value ? 1 : 0),
                    itemBuilder: (_, index) {
                      if (index == controller.activeLoads.length &&
                          controller.isLoading.value) {
                        return GlobalLoading();
                      } else {
                        return LoadItemLayout(
                          load: controller.activeLoads[index],
                          onViewDetails: () {
                            Get.toNamed(Routes.LOAD_DETAILS);
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
