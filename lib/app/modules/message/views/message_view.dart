import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/theme/app_colors.dart';
import 'package:reedsexpressllc_flutter/app/widgets/app_text_style.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_svg_image.dart';
import 'package:reedsexpressllc_flutter/app/data/models/conversation_model.dart';
import 'package:reedsexpressllc_flutter/gen/assets.gen.dart';
import '../../../widgets/appbar_title.dart';
import '../../../widgets/cached_image_widget.dart';
import '../controllers/message_controller.dart';

class MessageView extends GetView<MessageController> {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<MessageController>()) {
      Get.put(MessageController());
    }
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: appbarTitle(text: 'Chat'),
      ),
      body: Column(
        children: [
          // ── Search bar ─────────────────────────────────────
          _searchBar(),
          // ── Conversation list ──────────────────────────────
          Expanded(
            child: Obx(() {
              final list = controller.filteredConversations;
              if (list.isEmpty) {
                return Center(
                  child: AppTextStyle(
                    text: 'No conversations found.',
                    fontSize: 14.sp,
                    color: AppColors.hintText,
                  ),
                );
              }
              return ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                itemCount: list.length,
                separatorBuilder: (_, __) => Divider(
                  height: 1,
                  indent: 76.w,
                  color: const Color(0xFFEEEEEE),
                ),
                itemBuilder: (_, index) => _conversationTile(list[index]),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
      child: Container(
        height: 44.h,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F8),
          borderRadius: BorderRadius.circular(22.r),
        ),
        child: Row(
          children: [
            16.horizontalSpace,
            customSvgImage(
              imagePath: Assets.icons.searchIcon,
              width: 18.w,
              height: 18.w,
              color: AppColors.hintText,
            ),
            10.horizontalSpace,
            Expanded(
              child: TextField(
                controller: controller.searchController,
                onChanged: controller.onSearch,
                style: TextStyle(fontSize: 14.sp),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: AppColors.hintText,
                    fontSize: 14.sp,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _conversationTile(ConversationModel conv) {
    return GestureDetector(
      onTap: () => controller.openChat(conv),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            // Avatar
            // cachedImageWidget(imgUrl: conv.avatarPath,
            // borderRadius: 50.r,
            //   height: 40.h,
            //   width: 40.w,
            // ),
            CachedImage(
              imgUrl: conv.avatarPath,
              height: 45.h,
              width: 50.w,
              borderRadius: 50.r,
            ),
            // CircleAvatar(
            //   radius: 26.r,
            //   backgroundImage: NetworkImage(conv.avatarPath),
            //   backgroundColor: const Color(0xFFDDDDDD),
            // ),
            12.horizontalSpace,

            // Name + last message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppTextStyle(
                        text: conv.name,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      if (conv.role != null) ...[
                        4.horizontalSpace,
                        AppTextStyle(
                          text: '• ${conv.role}',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.hintText,
                        ),
                      ],
                      if (conv.isAdmin) ...[
                        4.horizontalSpace,
                        customSvgImage(
                          imagePath: Assets.icons.verifyBadgeIcon,
                          width: 16.w,
                          height: 16.w,
                          color: AppColors.primary,
                        ),
                      ],
                    ],
                  ),
                  4.verticalSpace,
                  AppTextStyle(
                    text: conv.lastMessage,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.hintText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Time + unread
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AppTextStyle(
                  text: conv.time,
                  fontSize: 11.sp,
                  color: AppColors.hintText,
                ),
                if (conv.unreadCount > 0) ...[
                  4.verticalSpace,
                  Container(
                    width: 18.w,
                    height: 18.w,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: AppTextStyle(
                        text: '${conv.unreadCount}',
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
