import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/theme/app_colors.dart';
import 'package:reedsexpressllc_flutter/app/core/widgets/app_text_style.dart';
import 'package:reedsexpressllc_flutter/app/core/widgets/custom_icon_button.dart';
import 'package:reedsexpressllc_flutter/app/core/widgets/custom_svg_image.dart';
import 'package:reedsexpressllc_flutter/app/data/models/chat_message_model.dart';
import 'package:reedsexpressllc_flutter/gen/assets.gen.dart';
import '../../../../core/widgets/appbar_title.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    if(!Get.isRegistered<ChatController>()){
      Get.put(ChatController());
    }
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: const CustomIconButton(),
        ),
        title: appbarTitle(text: 'Chat'),
      ),
      body: Column(
        children: [
          // ── User info header ───────────────────────────────
          _userInfoHeader(),

          // ── Messages list ──────────────────────────────────
          Expanded(child: _messagesList()),

          // ── Pending attachment preview ─────────────────────
          Obx(
            () => controller.pendingFilePath.value != null
                ? _pendingAttachmentPreview()
                : const SizedBox.shrink(),
          ),

          // ── Input bar ──────────────────────────────────────
          _inputBar(context),
        ],
      ),
    );
  }

  // ── User Info Header ────────────────────────────────────────────────────────

  Widget _userInfoHeader() {
    final conv = controller.conversation;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
      child: Column(
        children: [
          CircleAvatar(
            radius: 36.r,
            backgroundImage: AssetImage(conv.avatarPath),
            backgroundColor: const Color(0xFFDDDDDD),
          ),
          10.verticalSpace,
          AppTextStyle(
            text: conv.name,
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          6.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (conv.role != null) ...[
                AppTextStyle(
                  text: 'Roadside LTD',
                  fontSize: 12.sp,
                  color: AppColors.hintText,
                ),
                _dot(),
                AppTextStyle(
                  text: conv.role!,
                  fontSize: 12.sp,
                  color: AppColors.hintText,
                ),
                _dot(),
              ],
              AppTextStyle(
                text: 'burger@gmail.com',
                fontSize: 12.sp,
                color: AppColors.hintText,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dot() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Container(
        width: 4.w,
        height: 4.w,
        decoration: const BoxDecoration(
          color: Color(0xFFAAAAAA),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  // ── Messages List ───────────────────────────────────────────────────────────

  Widget _messagesList() {
    return Obx(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.scrollToBottom();
      });
      return ListView.builder(
        controller: controller.scrollController,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        itemCount: controller.messages.length,
        itemBuilder: (_, index) {
          final msg = controller.messages[index];

          // Typing indicator
          if (msg.isTyping) return _typingIndicator();

          // Time separator — show for first message only (demo)
          final showTime = index == 0;
          return Column(
            children: [
              if (showTime) _timeSeparator(msg.time),
              _messageBubble(msg),
            ],
          );
        },
      );
    });
  }

  Widget _timeSeparator(String time) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: AppTextStyle(
        text: time,
        fontSize: 11.sp,
        color: AppColors.hintText,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _typingIndicator() {
    return Padding(
      padding: EdgeInsets.only(top: 8.h, bottom: 4.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14.r,
            backgroundImage: AssetImage(controller.conversation.avatarPath),
            backgroundColor: const Color(0xFFDDDDDD),
          ),
          10.horizontalSpace,
          AppTextStyle(
            text: 'Typing...',
            fontSize: 13.sp,
            color: AppColors.hintText,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }

  Widget _messageBubble(ChatMessageModel msg) {
    final isMe = msg.sender == MessageSender.me;
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 14.r,
              backgroundImage: AssetImage(controller.conversation.avatarPath),
              backgroundColor: const Color(0xFFDDDDDD),
            ),
            8.horizontalSpace,
          ],

          // Bubble
          Flexible(
            child: GestureDetector(
              onTap: msg.filePath != null
                  ? () => controller.openFile(msg.filePath!)
                  : null,
              child: Container(
                padding: msg.type == MessageType.image
                    ? EdgeInsets.zero
                    : EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                constraints: BoxConstraints(maxWidth: 0.65.sw),
                decoration: BoxDecoration(
                  color: isMe ? AppColors.primary : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                    bottomLeft: Radius.circular(isMe ? 16.r : 4.r),
                    bottomRight: Radius.circular(isMe ? 4.r : 16.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(10),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: _bubbleContent(msg, isMe),
              ),
            ),
          ),

          if (isMe) ...[
            8.horizontalSpace,
            CircleAvatar(
              radius: 14.r,
              backgroundImage: AssetImage(controller.conversation.avatarPath),
              backgroundColor: const Color(0xFFDDDDDD),
            ),
          ],
        ],
      ),
    );
  }

  Widget _bubbleContent(ChatMessageModel msg, bool isMe) {
    switch (msg.type) {
      case MessageType.image:
        return ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.file(
            File(msg.filePath!),
            width: 200.w,
            height: 160.h,
            fit: BoxFit.cover,
          ),
        );

      case MessageType.pdf:
      case MessageType.document:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            customSvgImage(
              imagePath: Assets.icons.docIcon,
              width: 28.w,
              height: 28.w,
              color: isMe ? Colors.white : AppColors.primary,
            ),
            10.horizontalSpace,
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextStyle(
                    text: msg.fileName ?? msg.text,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: isMe ? Colors.white : Colors.black,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (msg.docType != null) ...[
                    3.verticalSpace,
                    AppTextStyle(
                      text: msg.docType!,
                      fontSize: 10.sp,
                      color: isMe
                          ? Colors.white.withAlpha(180)
                          : AppColors.hintText,
                    ),
                  ],
                ],
              ),
            ),
          ],
        );

      case MessageType.text:
      default:
        return AppTextStyle(
          text: msg.text,
          fontSize: 14.sp,
          color: isMe ? Colors.white : Colors.black,
          fontWeight: FontWeight.w400,
        );
    }
  }

  // ── Pending Attachment Preview ──────────────────────────────────────────────

  Widget _pendingAttachmentPreview() {
    return Obx(() {
      final path = controller.pendingFilePath.value!;
      final name = controller.pendingFileName.value ?? '';
      final docType = controller.pendingDocType.value;
      final isImage = controller.isImage(path);

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.primary, width: 0.8),
        ),
        child: Row(
          children: [
            // Preview
            if (isImage)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.file(
                  File(path),
                  width: 44.w,
                  height: 44.w,
                  fit: BoxFit.cover,
                ),
              )
            else
              customSvgImage(
                imagePath: Assets.icons.docIcon,
                width: 36.w,
                height: 36.w,
                color: AppColors.primary,
              ),
            10.horizontalSpace,

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextStyle(
                    text: name,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (docType != null)
                    AppTextStyle(
                      text: docType,
                      fontSize: 11.sp,
                      color: AppColors.hintText,
                    ),
                ],
              ),
            ),

            // Cancel pending
            GestureDetector(
              onTap: controller.cancelPending,
              child: customSvgImage(
                imagePath: Assets.icons.crossCircleIcon,
                width: 20.w,
                height: 20.w,
                color: AppColors.hintText,
              ),
            ),
          ],
        ),
      );
    });
  }

  // ── Input Bar ───────────────────────────────────────────────────────────────

  Widget _inputBar(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 24.h),
      child: Row(
        children: [
          // Attachment button
          GestureDetector(
            onTap: () => _showAttachmentBottomSheet(context),
            child: customSvgImage(
              imagePath: Assets.icons.attachFileIcon,
              width: 24.w,
              height: 24.w,
              color: AppColors.hintText,
            ),
          ),
          10.horizontalSpace,

          // Text field
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F8),
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: TextField(
                controller: controller.messageController,
                style: TextStyle(fontSize: 14.sp),
                maxLines: 4,
                minLines: 1,
                decoration: InputDecoration(
                  hintText: 'Type your message',
                  hintStyle: TextStyle(
                    color: AppColors.hintText,
                    fontSize: 14.sp,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                ),
              ),
            ),
          ),
          10.horizontalSpace,

          // Send button
          GestureDetector(
            onTap: controller.sendMessage,
            child: Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: customSvgImage(
                  imagePath: Assets.icons.shareIcon,
                  width: 20.w,
                  height: 20.w,
                  color: AppColors.hintText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Attachment Bottom Sheet ─────────────────────────────────────────────────

  void _showAttachmentBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFDDDDDD),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            16.verticalSpace,
            AppTextStyle(
              text: 'Share Attachment',
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            16.verticalSpace,

            // Options row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _attachOption(
                  iconPath: Assets.icons.cameraIcon,
                  label: 'Camera',
                  onTap: () {
                    Get.back();
                    controller.pickFromCamera();
                  },
                ),
                _attachOption(
                  iconPath: Assets.icons.galaryIcon,
                  label: 'Gallery',
                  onTap: () {
                    Get.back();
                    controller.pickFromGallery();
                  },
                ),
                _attachOption(
                  iconPath: Assets.icons.docFillIcon,
                  label: 'Document',
                  onTap: () {
                    Get.back();
                    _showDocTypeSheet(context);
                  },
                ),
              ],
            ),
            16.verticalSpace,
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  // ── Doc Type Sheet ──────────────────────────────────────────────────────────

  void _showDocTypeSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFDDDDDD),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            14.verticalSpace,
            AppTextStyle(
              text: 'Select Document Type',
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            12.verticalSpace,

            // Doc type list
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 0.5.sh),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: controller.docTypes.length,
                separatorBuilder: (_, __) =>
                    Divider(height: 1, color: const Color(0xFFEEEEEE)),
                itemBuilder: (_, index) {
                  final type = controller.docTypes[index];
                  final isGeneral = index == 0;
                  return GestureDetector(
                    onTap: () {
                      Get.back();
                      controller.pickDocument(type);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 13.h),
                      child: Row(
                        children: [
                          customSvgImage(
                            imagePath: isGeneral
                                ? Assets.icons.docIcon
                                : Assets.icons.docFillIcon,
                            width: 20.w,
                            height: 20.w,
                            color: isGeneral
                                ? AppColors.hintText
                                : AppColors.primary,
                          ),
                          12.horizontalSpace,
                          AppTextStyle(
                            text: type,
                            fontSize: 13.sp,
                            fontWeight: isGeneral
                                ? FontWeight.w400
                                : FontWeight.w500,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _attachOption({
    required String iconPath,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(18),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: customSvgImage(
                imagePath: iconPath,
                width: 24.w,
                height: 24.w,
                color: AppColors.primary,
              ),
            ),
          ),
          8.verticalSpace,
          AppTextStyle(
            text: label,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
