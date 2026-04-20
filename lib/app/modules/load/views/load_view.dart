import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/extensions/sizedbox_extension.dart';
import 'package:reedsexpressllc_flutter/app/core/layouts/load_item_layout.dart';
import 'package:reedsexpressllc_flutter/app/core/theme/app_colors.dart';
import 'package:reedsexpressllc_flutter/app/core/widgets/app_text_style.dart';
import 'package:reedsexpressllc_flutter/app/core/widgets/custom_svg_image.dart';

import '../../../../gen/assets.gen.dart';
import '../../../core/widgets/appbar_title.dart';
import '../../../core/widgets/custom_icon_button.dart';
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
        leading: Get.currentRoute == Routes.MAIN_PAGE
            ? null
            : Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: const CustomIconButton(),
        ),
      ),
      body: Column(
        children: [
          searchWidget(),
          10.height,
          Expanded(
            child: GetBuilder<LoadController>(
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
          ),
        ],
      ),
    );
  }

  Widget searchWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 45.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  customSvgImage(
                    imagePath: Assets.icons.searchIcon,
                    color: AppColors.hintText,
                  ),
                  10.width,
                  AppTextStyle(text: "Search", color: AppColors.hintText),
                ],
              ),
            ),
          ),
          10.width,
          Container(
            height: 45.h,
            width: 50.w,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: customSvgImage(
                imagePath: Assets.icons.filterIcon,
                color: AppColors.hintText,
                height: 18.h,
                width: 18.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
