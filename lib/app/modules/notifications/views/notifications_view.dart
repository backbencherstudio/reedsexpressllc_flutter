import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_color.dart';
import '../../../widgets/app_text_style.dart';
import '../../../widgets/appbar_title.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/global_loading.dart';
import '../../../widgets/show_empty_result.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<NotificationsController>()) {
      Get.put(NotificationsController());
    }
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
        title: appbarTitle(text: 'Notifications'),
      ),
      body: GetBuilder<NotificationsController>(
        id: 'update_notifications',
        builder: (controller) {
          if (controller.isInit) {
            return const GlobalLoading();
          } else if (controller.activeNotifications.isEmpty) {
            return ShowEmptyResult(
              refreshOnTap: () {
                controller.getNotifications(isRefresh: true);
              },
            );
          } else {
            return RefreshIndicator(
              color: AppColor.primary,
              onRefresh: () async {
                controller.getNotifications(isRefresh: true);
              },
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                      controller.isEndPage == false &&
                      controller.isLoading.value == false) {
                    controller.getNotifications(isRefresh: false);
                  }
                  return false;
                },
                child: Obx(
                  () => ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    itemCount: controller.activeNotifications.length + (controller.isLoading.value ? 1 : 0),
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey.withOpacity(0.15),
                    ),
                    itemBuilder: (context, index) {
                      if (index == controller.activeNotifications.length && controller.isLoading.value) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: GlobalLoading(),
                        );
                      } else {
                        return _NotificationItem(
                          notification: controller.activeNotifications[index],
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

class _NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  const _NotificationItem({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.withAlpha(50), width: 1),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.notifications_none,
              color: Colors.grey.shade400,
              size: 24.w,
            ),
          ),
          16.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AppTextStyle(
                        text: notification.title,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2B2E3B),
                        maxLines: 2,
                      ),
                    ),
                    8.horizontalSpace,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppTextStyle(
                          text: notification.timeText,
                          fontSize: 12.sp,
                          color: Colors.grey.shade500,
                        ),
                        if (notification.isUnread) ...[
                          6.horizontalSpace,
                          Container(
                            width: 8.w,
                            height: 8.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                        ]
                      ],
                    ),
                  ],
                ),
                4.verticalSpace,
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade600,
                      height: 1.4,
                      // fontFamily: 'Inter', // Fallback to default
                    ),
                    children: [
                      TextSpan(text: notification.description),
                      if (notification.actionText.isNotEmpty)
                        TextSpan(
                          text: notification.actionText,
                          style: TextStyle(
                            color: Colors.blueAccent.shade400, // Matching the bright blue link color
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Handle action
                            },
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
