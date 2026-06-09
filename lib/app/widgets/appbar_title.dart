import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/extensions/sizedbox_extension.dart';
import '../core/theme/app_color.dart';
import 'app_text_style.dart';

Widget appbarTitle({
  required String text,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
}) {
  return AppTextStyle(
    text: text,
    fontSize: fontSize ?? 18.sp,
    fontWeight: fontWeight ?? FontWeight.w600,
    textAlign: TextAlign.center,
    color: color,
  );
}



Widget authAppBar({
  required String title,
  required String subtitle,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppTextStyle(
        text: title,
        fontSize: 26.sp,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      6.height,
      AppTextStyle(
        text: subtitle,
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        color: AppColor.hintText,
      ),
    ],
  );
}