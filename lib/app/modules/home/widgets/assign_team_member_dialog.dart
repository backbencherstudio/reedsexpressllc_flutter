import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/extensions/sizedbox_extension.dart';
import 'package:reedsexpressllc_flutter/app/core/theme/app_color.dart';
import 'package:reedsexpressllc_flutter/app/widgets/app_text_style.dart';
import 'package:reedsexpressllc_flutter/app/widgets/cross_button.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_svg_image.dart';

import '../../../../gen/assets.gen.dart';
import '../controllers/home_controller.dart';

class AssignTeamMemberDialog extends GetView<HomeController> {
  const AssignTeamMemberDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AppTextStyle(
                    text: 'Assign a Team Member',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                crossButton(
                  onTap: Get.back,
                  bgColor: const Color(0xFFF3F4F8),
                  iconColor: Colors.black87,
                  height: 32.h,
                  width: 32.w,
                  iconHeight: 12.h,
                  iconWidth: 12.w,
                ),
              ],
            ),
            8.verticalSpace,
            AppTextStyle(
              text: 'Pick a team member for this specific load.',
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: AppColor.hintText,
            ),
            16.verticalSpace,
            Obx(
              () => Column(
                children: List.generate(controller.teamMembers.length, (index) {
                  final isSelected =
                      controller.selectedTeamMemberIndex.value == index;

                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: GestureDetector(
                      onTap: () => controller.selectTeamMember(index),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFF3F4F8)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 40.w,
                              width: 40.w,
                              decoration: BoxDecoration(
                                color: AppColor.primary.withAlpha(45),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: customSvgImage(
                                  imagePath: Assets.icons.profileIcon,
                                  height: 20.h,
                                  width: 20.w,
                                  color: AppColor.primary,
                                ),
                              ),
                            ),
                            12.width,
                            AppTextStyle(
                              text: controller.teamMembers[index],
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
