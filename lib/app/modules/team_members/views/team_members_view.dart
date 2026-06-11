import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/extensions/sizedbox_extension.dart';
import 'package:reedsexpressllc_flutter/app/core/theme/app_color.dart';
import 'package:reedsexpressllc_flutter/app/data/models/team_member_model.dart';
import 'package:reedsexpressllc_flutter/app/widgets/app_text_style.dart';
import 'package:reedsexpressllc_flutter/app/widgets/appbar_title.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_icon_button.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_svg_image.dart';
import 'package:reedsexpressllc_flutter/app/widgets/global_button.dart';
import 'package:reedsexpressllc_flutter/gen/assets.gen.dart';

import '../controllers/team_members_controller.dart';

class TeamMembersView extends GetView<TeamMembersController> {
  const TeamMembersView({super.key});

  @override
  Widget build(BuildContext context) {
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
        title: appbarTitle(text: 'Team Members'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                child: Obx(
                  () => Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: const Color(0xFFE8EBF2)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(8),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextStyle(
                          text: 'All Team Members (${controller.members.length})',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        12.height,
                        ...List.generate(controller.members.length, (index) {
                          final member = controller.members[index];
                          final isLast = index == controller.members.length - 1;

                          return Padding(
                            padding: EdgeInsets.only(bottom: isLast ? 8.h : 4.h),
                            child: _TeamMemberRow(
                              member: member,
                              onViewTap: () =>
                                  controller.openMemberDetails(member),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              child: GlobalButton(
                onTap: controller.addDriver,
                text: 'Add a Driver',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TeamMemberRow extends StatelessWidget {
  final TeamMemberModel member;
  final VoidCallback onViewTap;

  const _TeamMemberRow({
    required this.member,
    required this.onViewTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
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
          Expanded(
            child: AppTextStyle(
              text: member.name,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          GestureDetector(
            onTap: onViewTap,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Icon(
                Icons.remove_red_eye_outlined,
                size: 20.sp,
                color: AppColor.hintText,
              ),
            ),
          ),
          const _ActiveBadge(),
        ],
      ),
    );
  }
}

class _ActiveBadge extends StatelessWidget {
  const _ActiveBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFF4CAF50)),
      ),
      child: AppTextStyle(
        text: 'Active',
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF4CAF50),
      ),
    );
  }
}
