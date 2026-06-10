import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/theme/app_color.dart';
import 'package:reedsexpressllc_flutter/app/widgets/app_text_style.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_svg_image.dart';

import '../../gen/assets.gen.dart';

class UploadSourceBottomSheet extends StatelessWidget {
  const UploadSourceBottomSheet({
    super.key,
    required this.onCameraTap,
    required this.onUploadFilesTap,
    this.title = 'Upload Document',
  });

  final VoidCallback onCameraTap;
  final VoidCallback onUploadFilesTap;
  final String title;

  static void show({
    required VoidCallback onCameraTap,
    required VoidCallback onUploadFilesTap,
    String title = 'Upload Document',
  }) {
    Get.bottomSheet(
      UploadSourceBottomSheet(
        onCameraTap: onCameraTap,
        onUploadFilesTap: onUploadFilesTap,
        title: title,
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            text: title,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
          16.verticalSpace,
          Row(
            children: [
              Expanded(
                child: _SourceOption(
                  iconPath: Assets.icons.cameraIcon,
                  label: 'Camera',
                  onTap: () {
                    Get.back();
                    onCameraTap();
                  },
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: _SourceOption(
                  iconPath: Assets.icons.uploadIcon,
                  label: 'Upload files',
                  onTap: () {
                    Get.back();
                    onUploadFilesTap();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SourceOption extends StatelessWidget {
  const _SourceOption({
    required this.iconPath,
    required this.label,
    required this.onTap,
  });

  final String iconPath;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColor.background,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColor.hintText.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          children: [
            customSvgImage(
              imagePath: iconPath,
              width: 24.w,
              height: 24.w,
              color: AppColor.primary,
            ),
            8.verticalSpace,
            AppTextStyle(
              text: label,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
