import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/extensions/sizedbox_extension.dart';
import 'package:reedsexpressllc_flutter/app/core/layouts/load_item_layout.dart';
import 'package:reedsexpressllc_flutter/app/core/utils/helper_utils.dart';
import 'package:reedsexpressllc_flutter/app/core/utils/logger.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_svg_image.dart';
import 'package:reedsexpressllc_flutter/app/widgets/global_button.dart';
import 'package:reedsexpressllc_flutter/app/widgets/show_empty_result.dart';
import 'package:reedsexpressllc_flutter/app/routes/app_pages.dart';

import '../../../../gen/assets.gen.dart';
import '../../../core/theme/app_color.dart';
import '../../../widgets/app_text_style.dart';
import '../../../widgets/quick_action_item.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
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
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 32.h),
                    children: [
                      // ── Active Load section ──────────────
                      const _SectionHeader(title: 'Active Load'),
                      12.verticalSpace,

                      Obx(
                        () => controller.isDocumentSubmit.value
                            ? LoadItemLayout(
                                load: controller.activeLoad,
                                onViewDetails: () {
                                  Get.toNamed(Routes.LOAD_DETAILS);
                                },
                              )
                            : const ShowEmptyResult(
                                subtitle: 'No assigned loads yet',
                              ),
                      ),

                      20.verticalSpace,

                      // ── Next Load section ────────────────
                      _SectionHeader(
                        title: 'Next Load',
                        actionLabel: 'All Loads',
                        onTap: () {
                          Get.toNamed(Routes.ACTIVE_LOAD_LIST);
                        },
                      ),
                      12.verticalSpace,
                      Obx(
                        () => controller.isDocumentSubmit.value
                            ? LoadItemLayout(
                                load: controller.nextLoad,
                                actionLabel: controller.nextLoadActionLabel,
                                actionStyle: LoadItemActionStyle.filled,
                                onAction: controller.isCarrierUser
                                    ? controller.assignMember
                                    : controller.acceptLoad,
                              )
                            : const ShowEmptyResult(
                                subtitle: 'No next loads yet',
                              ),
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
    return Stack(
      children: [
        Padding(
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
                      InkWell(
                        onTap: () {
                          if (controller.isDocumentSubmit.value == true) {
                            controller.isDocumentSubmit.value = false;
                          } else {
                            controller.isDocumentSubmit.value = true;
                          }
                        },
                        child: AppTextStyle(
                          text: controller.userName,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              18.height,

              // Stats row / unsubmit doc card
              Obx(() {
                if (controller.isDocumentSubmit.value == true) {
                  return Row(
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
                        value: controller.nextLoads.toString(),
                        label: 'Next Loads',
                      ),
                    ],
                  );
                } else {
                  return _UnsubmitDocStatCard();
                }
              }),
            ],
          ),
        ),
        Positioned(
          top: 25.h,
          left: -60,
          child: Container(
            height: 90.h,
            width: 90.w,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(20),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: -15.h,
          right: -50,
          child: Container(
            height: 130.h,
            width: 130.w,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(20),
              shape: BoxShape.circle,
            ),
          ),
        ),

        Positioned(
          top: 20.h,
          right: 15.w,
          child: GestureDetector(
            onTap: () {
              Get.toNamed(Routes.NOTIFICATIONS);
            },
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(40),
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: [
                  Center(
                    child: customSvgImage(
                      imagePath: Assets.icons.notificationIcon,
                      width: 22.w,
                      height: 22.w,
                      color: Colors.white,
                    ),
                  ),

                  Positioned(
                    top: 9.h,
                    right: 10.w,
                    child: Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF9C80E),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _UnsubmitDocStatCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 140.h,
      width: Get.width,
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(45),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withAlpha(50), width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppTextStyle(
            text: "Complete Your Verification",
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          4.verticalSpace,
          AppTextStyle(
            text:
                "To get approved and start working, please add your required documents.",
            textAlign: TextAlign.center,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: Colors.white.withAlpha(200),
          ),
          10.height,
          GlobalButton(
            onTap: () {
              Get.toNamed(Routes.UPLOAD_DOCUMENTS);
            },
            text: "Add Documents",
            height: 40.h,
            color: Colors.white,
            textColor: Colors.black,
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
          color: Colors.white.withAlpha(45),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.white.withAlpha(50), width: 2),
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

  const _SectionHeader({required this.title, this.actionLabel, this.onTap});

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
              color: AppColor.primary,
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
    if (controller.isCarrierUser) {
      return _buildCarrierActions();
    }

    return _buildDriverActions();
  }

  Widget _buildDriverActions() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: QuickActionItem(
                iconPath: Assets.icons.earningBagFillIcon,
                label: 'My Earnings',
                onTap: () => Get.toNamed(Routes.EARNINGS),
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: QuickActionItem(
                iconPath: Assets.icons.docFillIcon,
                label: 'Documents',
                onTap: () => Get.toNamed(Routes.DOCUMENTS),
              ),
            ),
          ],
        ),
        12.verticalSpace,
        QuickActionItem(
          iconPath: Assets.icons.blockPackageIcon,
          label: 'Load History',
          onTap: () => Get.toNamed(Routes.LOAD),
        ),
      ],
    );
  }

  Widget _buildCarrierActions() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: QuickActionItem(
                iconPath: Assets.icons.earningBagFillIcon,
                label: 'My Earnings',
                onTap: () => Get.toNamed(Routes.EARNINGS),
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: QuickActionItem(
                iconPath: Assets.icons.docFillIcon,
                label: 'Documents',
                onTap: () => Get.toNamed(Routes.DOCUMENTS),
              ),
            ),
          ],
        ),
        12.verticalSpace,
        Row(
          children: [
            Expanded(
              child: QuickActionItem(
                iconPath: Assets.icons.blockPackageIcon,
                label: 'Load History',
                onTap: () => Get.toNamed(Routes.LOAD),
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: QuickActionItem(
                iconPath: Assets.icons.userPlusIcon,
                label: 'Add Drivers',
                onTap: controller.assignMember,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
