import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reedsexpressllc_flutter/app/core/theme/app_colors.dart';

import '../../../gen/assets.gen.dart';
import '../core/extensions/sizedbox_extension.dart';
import 'app_text_style.dart';
import 'global_button.dart';

class ShowEmptyResult extends StatelessWidget {
  const ShowEmptyResult({
    super.key,
    this.height,
    this.width,
    this.title,
    this.subtitle,
    this.widget,
    this.refreshOnTap,
  });
  final double? height;
  final double? width;

  final String? title;
  final String? subtitle;
  final Widget? widget;
  final VoidCallback? refreshOnTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              Assets.images.emptyBox.path,
              height: 100.h,
              width: 100.w,
            ),
            if (title != null)
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: AppTextStyle(
                  text: title ?? 'No restaurant found!',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            5.height,
            if (subtitle != null)
              AppTextStyle(
                text:
                    subtitle ??
                    'No restaurants found nearby your location. Try exploring a wider area or check again later!',
                fontSize: 14,
                color: AppColors.hintText,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
              ),
            refreshOnTap != null
                ? Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: GlobalButton(
                      height: 35.h,
                      width: 150.w,
                      onTap: refreshOnTap ?? () {},
                      text: "Refresh",
                    ),
                  )
                : 0.height,
            widget != null ? 30.height : 0.width,
            widget ?? 0.width,
          ],
        ),
      ),
    );
  }
}
