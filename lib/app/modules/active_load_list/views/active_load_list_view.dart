import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/layouts/load_item_layout.dart';
import 'package:reedsexpressllc_flutter/app/core/theme/app_color.dart';

import '../../../widgets/appbar_title.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/global_loading.dart';
import '../../../widgets/show_empty_result.dart';
import '../../../routes/app_pages.dart';
import '../controllers/active_load_list_controller.dart';

class ActiveLoadListView extends GetView<ActiveLoadListController> {
  const ActiveLoadListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        surfaceTintColor: AppColor.background,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: const CustomIconButton(),
        ),
        title: appbarTitle(text: 'Active Loads'),
      ),
      body: GetBuilder<ActiveLoadListController>(
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
              color: AppColor.primary,
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
