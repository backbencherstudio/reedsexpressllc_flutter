import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/extensions/sizedbox_extension.dart';
import 'package:reedsexpressllc_flutter/app/core/theme/app_colors.dart';
import 'package:reedsexpressllc_flutter/app/core/widgets/app_text_style.dart';

Widget authHeader({
  required String title,
  String? subTitle,
  double? height,
  double? width,
}) {
  return SizedBox(
    height: 100.h,
    width: width ?? Get.width,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppTextStyle(
            text: title,
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
          ),
          5.height,
          subTitle == null
              ? SizedBox.shrink()
              : AppTextStyle(text: subTitle, color: AppColors.hintText),
        ],
      ),
    ),
  );
}
