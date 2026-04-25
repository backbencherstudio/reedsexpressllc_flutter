import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../gen/assets.gen.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/app_text_style.dart';
import '../../../widgets/appbar_title.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/custom_svg_image.dart';
import '../controllers/earnings_controller.dart';

class EarningsView extends GetView<EarningsController> {
  const EarningsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: const CustomIconButton(),
        ),
        title: appbarTitle(text: 'My Earning'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                height: 48.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    customSvgImage(
                      imagePath: Assets.icons.searchIcon,
                      color: AppColors.hintText,
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: TextField(
                        controller: controller.searchController,
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(
                            color: AppColors.hintText,
                            fontSize: 14.sp,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              24.verticalSpace,

              // Date Range Header
              AppTextStyle(
                text: 'Date Range',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              12.verticalSpace,

              // Date Range Picker Dropdown Button
              GestureDetector(
                onTap: () => _showDatePicker(context),
                child: Container(
                  height: 48.h,
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Colors.grey.withAlpha(75)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => AppTextStyle(
                          text: controller.dateRangeText,
                          fontSize: 14.sp,
                          color: Colors.black87,
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black87,
                      ),
                    ],
                  ),
                ),
              ),
              24.verticalSpace,

              // Earnings Card
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.grey.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stats
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppTextStyle(
                          text: 'Load Completed',
                          fontSize: 14.sp,
                          color: Colors.black54,
                        ),
                        Obx(
                          () => AppTextStyle(
                            text: '${controller.loadCompleted.value}',
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    12.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppTextStyle(
                          text: 'Miles Driven',
                          fontSize: 14.sp,
                          color: Colors.black54,
                        ),
                        Obx(
                          () => AppTextStyle(
                            text: '${controller.milesDriven.value}m',
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    16.verticalSpace,
                    Divider(height: 1, color: Colors.grey.withAlpha(20)),
                    16.verticalSpace,

                    // Load Breakdown Title
                    AppTextStyle(
                      text: 'Load Breakdown',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    16.verticalSpace,

                    // Breakdowns List
                    Obx(
                      () => Column(
                        children: controller.loadBreakdowns
                            .map(
                              (load) => Container(
                                margin: EdgeInsets.only(bottom: 8.h),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 12.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF9FAFC),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppTextStyle(
                                            text: load.id,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                          ),
                                          6.verticalSpace,
                                          AppTextStyle(
                                            text: load.route,
                                            fontSize: 13.sp,
                                            color: Colors.black87,
                                          ),
                                          6.verticalSpace,
                                          AppTextStyle(
                                            text: load.distance,
                                            fontSize: 13.sp,
                                            color: Colors.grey.shade500,
                                          ),
                                        ],
                                      ),
                                    ),
                                    AppTextStyle(
                                      text:
                                          '\$${load.amount.toStringAsFixed(2)}',
                                      fontSize: 14.sp,
                                      color: Colors.black87,
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),

                    16.verticalSpace,

                    // Total Earnings
                    AppTextStyle(
                      text: 'Total Earnings',
                      fontSize: 14.sp,
                      color: Colors.black54,
                    ),
                    8.verticalSpace,
                    Obx(
                      () => AppTextStyle(
                        text:
                            '\$${controller.totalEarnings.value.toStringAsFixed(2)}',
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: 320,
            height: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: SfDateRangePicker(
                selectionMode: DateRangePickerSelectionMode.range,
                showNavigationArrow: true,
                showActionButtons: true,
                selectionColor: AppColors.primary,
                startRangeSelectionColor: AppColors.primary,
                endRangeSelectionColor: AppColors.primary,
                rangeSelectionColor: AppColors.primary.withAlpha(25),
                todayHighlightColor: AppColors.primary,
                backgroundColor: Colors.white,
                initialSelectedRange: PickerDateRange(
                  controller.startDate.value,
                  controller.endDate.value,
                ),

                onSubmit: (Object? value) {
                  if (value is PickerDateRange) {
                    controller.startDate.value = value.startDate;
                    controller.endDate.value = value.endDate ?? value.startDate;
                    Navigator.pop(context);
                  }
                },
                onCancel: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
