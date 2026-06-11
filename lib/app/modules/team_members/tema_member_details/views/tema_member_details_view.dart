import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/extensions/sizedbox_extension.dart';
import 'package:reedsexpressllc_flutter/app/core/theme/app_color.dart';
import 'package:reedsexpressllc_flutter/app/widgets/app_text_style.dart';
import 'package:reedsexpressllc_flutter/app/widgets/appbar_title.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_icon_button.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_svg_image.dart';
import 'package:reedsexpressllc_flutter/gen/assets.gen.dart';

import '../controllers/tema_member_details_controller.dart';

class TemaMemberDetailsView extends GetView<TemaMemberDetailsController> {
  const TemaMemberDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final member = controller.member;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: const CustomIconButton(),
        ),
        title: appbarTitle(text: 'Team Info'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 32.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 44.w,
                  width: 44.w,
                  decoration: BoxDecoration(
                    color: AppColor.primary.withAlpha(45),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: customSvgImage(
                      imagePath: Assets.icons.profileIcon,
                      height: 22.h,
                      width: 22.w,
                      color: AppColor.primary,
                    ),
                  ),
                ),
                12.width,
                Expanded(
                  child: AppTextStyle(
                    text: member.name,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const _ActiveBadge(),
              ],
            ),
            24.height,
            _SectionTitle(title: 'Driver Information'),
            12.height,
            _InfoRow(
              label: 'Carrier',
              value: member.carrier,
              onEditTap: () => controller.editField('Carrier'),
            ),
            _InfoRow(
              label: 'State',
              value: member.state,
              onEditTap: () => controller.editField('State'),
            ),
            _InfoRow(
              label: 'Contact',
              value: member.contact,
              onEditTap: () => controller.editField('Contact'),
              showDivider: false,
            ),
            24.height,
            _SectionTitle(title: 'Driver Fitness / Compliance'),
            12.height,
            _InfoRow(
              label: 'CDL Number',
              value: member.cdlNumber,
              onEditTap: () => controller.editField('CDL Number'),
            ),
            _InfoRow(
              label: 'Registration Expiration Date',
              value: member.registrationExpirationDate,
              onEditTap: () => controller.editField('Registration Expiration Date'),
            ),
            _InfoRow(
              label: 'CDL Expiration Date',
              value: member.cdlExpirationDate,
              onEditTap: () => controller.editField('CDL Expiration Date'),
            ),
            _InfoRow(
              label: 'Medical Card Expiration Date',
              value: member.medicalCardExpirationDate,
              onEditTap: () => controller.editField('Medical Card Expiration Date'),
              showDivider: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppTextStyle(
      text: title,
      fontSize: 15.sp,
      fontWeight: FontWeight.w600,
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onEditTap;
  final bool showDivider;

  const _InfoRow({
    required this.label,
    required this.value,
    required this.onEditTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextStyle(
                      text: label,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    6.height,
                    AppTextStyle(
                      text: value,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.hintText,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onEditTap,
                child: Container(
                  height: 32.w,
                  width: 32.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F8),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: customSvgImage(
                      imagePath: Assets.icons.editIcon,
                      width: 16.w,
                      height: 16.w,
                      color: AppColor.secondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
      ],
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
