import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/layouts/load_item_layout.dart';
import 'package:reedsexpressllc_flutter/app/core/widgets/custom_svg_image.dart';
import 'package:reedsexpressllc_flutter/app/routes/app_pages.dart';

import '../../../../gen/assets.gen.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_text_style.dart';
import '../../../core/widgets/quick_action_item.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ── Top header (fixed, inside background color) ──
            _HomeHeader(controller: controller),

            // ── Scrollable content ───────────────────────────
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F8),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                  child: Obx(
                        () => ListView(
                      padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 32.h),
                      children: [
                        // ── Active Load section ──────────────
                        _SectionHeader(
                          title: 'Active Load',
                          actionLabel: 'All Loads',
                          onTap: () {
                            Get.toNamed(Routes.ACTIVE_LOAD_LIST);
                          },
                        ),
                        12.verticalSpace,

                        // ...List.generate(
                        //   controller.activeLoads.length,
                        //       (index) => Padding(
                        //     padding: EdgeInsets.only(bottom: 14.h),
                        //     child: LoadItemLayout(
                        //       load: controller.activeLoads[index],
                        //       onViewDetails: () {},
                        //     ),
                        //   ),
                        // ),
                        LoadItemLayout(
                          load: controller.activeLoads[0],
                          onViewDetails: () {
                            Get.toNamed(Routes.LOAD_DETAILS);
                          },
                        ),

                        20.verticalSpace,

                        // ── Quick Actions section ────────────
                        _SectionHeader(title: 'Quick Actions'),
                        12.verticalSpace,
                        _QuickActionsGrid(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Home Header ───────────────────────────────────────────────────────────────

class _HomeHeader extends StatelessWidget {
  final HomeController controller;

  const _HomeHeader({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
      child: Column(
        children: [
          // Welcome row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextStyle(
                    text: 'Welcome Back!',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withAlpha(200),
                  ),
                  AppTextStyle(
                    text: controller.userName,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ],
              ),
              // Notification bell
              Stack(
                children: [
                  Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(38),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: customSvgImage(
                        imagePath: Assets.icons.notificationIcon,
                        width: 22.w,
                        height: 22.w,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4.h,
                    right: 4.w,
                    child: Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE8A020),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          18.verticalSpace,

          // Stats row
          Row(
            children: [
              _StatCard(
                value: controller.totalLoads.toString().padLeft(2, '0'),
                label: 'Total Loads',
              ),
              8.horizontalSpace,
              _StatCard(
                value: controller.delivered.toString().padLeft(2, '0'),
                label: 'Delivered',
              ),
              8.horizontalSpace,
              _StatCard(
                value: controller.miles.toString(),
                label: 'Miles',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(38),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            AppTextStyle(
              text: value,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            4.verticalSpace,
            AppTextStyle(
              text: label,
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white.withAlpha(200),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Section Header ────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onTap;

  const _SectionHeader({
    required this.title,
    this.actionLabel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppTextStyle(
          text: title,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        if (actionLabel != null)
          GestureDetector(
            onTap: onTap,
            child: AppTextStyle(
              text: actionLabel!,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
      ],
    );
  }
}

// ── Quick Actions Grid ────────────────────────────────────────────────────────

class _QuickActionsGrid extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final actions = [
      (Assets.icons.earningBagFillIcon, 'My Earnings'),
      (Assets.icons.docFillIcon, 'Documents'),
      (Assets.icons.blockPackageIcon, 'Load History'),
    ];

    return Column(
      children: [
        // First row — 2 items
        Row(
          children: [
            Expanded(
              child: QuickActionItem(
                iconPath: actions[0].$1,
                label: actions[0].$2,
                onTap: () {},
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: QuickActionItem(
                iconPath: actions[1].$1,
                label: actions[1].$2,
                onTap: () {},
              ),
            ),
          ],
        ),
        12.verticalSpace,

        // Second row — full width
        QuickActionItem(
          iconPath: actions[2].$1,
          label: actions[2].$2,
          onTap: () {},
        ),
      ],
    );
  }
}