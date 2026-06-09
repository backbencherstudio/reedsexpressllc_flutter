import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reedsexpressllc_flutter/app/core/extensions/sizedbox_extension.dart';
import 'package:reedsexpressllc_flutter/app/core/theme/app_color.dart';
import 'package:reedsexpressllc_flutter/app/widgets/app_text_style.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_svg_image.dart';

import '../../../../gen/assets.gen.dart';

class SignatureEmailField extends StatelessWidget {
  const SignatureEmailField({
    super.key,
    required this.label,
    this.statusText = 'Sent via Email for Signature',
  });

  final String label;
  final String statusText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextStyle(text: label, fontSize: 14.sp, fontWeight: FontWeight.w500),
        6.height,
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: AppColor.hintText.withValues(alpha: 0.35),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customSvgImage(
                imagePath: Assets.icons.emailIcon,
                height: 18.h,
                width: 18.w,
                color: AppColor.error,
              ),
              6.width,
              Flexible(
                child: AppTextStyle(
                  text: statusText,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColor.error,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
