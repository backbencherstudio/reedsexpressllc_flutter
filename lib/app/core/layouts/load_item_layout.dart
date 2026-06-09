// lib/app/core/widgets/load_item_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reedsexpressllc_flutter/app/core/theme/app_color.dart';
import 'package:reedsexpressllc_flutter/app/widgets/app_text_style.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_svg_image.dart';
import 'package:reedsexpressllc_flutter/app/data/models/load_model.dart';
import 'package:reedsexpressllc_flutter/gen/assets.gen.dart';

import '../constants/enums.dart';

enum LoadItemActionStyle { outlined, filled }

class LoadItemLayout extends StatelessWidget {
  final LoadModel load;
  final VoidCallback? onViewDetails;
  final VoidCallback? onAction;
  final String actionLabel;
  final LoadItemActionStyle actionStyle;
  final EdgeInsets? padding;

  const LoadItemLayout({
    super.key,
    required this.load,
    this.onViewDetails,
    this.onAction,
    this.actionLabel = 'View Details',
    this.actionStyle = LoadItemActionStyle.outlined,
    this.padding,
  });

  Color get _statusColor {
    switch (load.status) {
      case LoadStatus.pickup:
      case LoadStatus.assigned:
        return const Color(0xFFF9C80E);
      case LoadStatus.inTransit:
        return AppColor.primary;
      case LoadStatus.delivered:
      case LoadStatus.completed:
        return const Color(0xFF00F259);
    }
  }

  String get _statusLabel {
    switch (load.status) {
      case LoadStatus.pickup:
        return 'Pickup';
      case LoadStatus.assigned:
        return 'Assigned';
      case LoadStatus.inTransit:
        return 'In Transit';
      case LoadStatus.delivered:
        return 'Delivered';
      case LoadStatus.completed:
        return 'Completed';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding ?? EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _LoadHeader(
            loadId: load.loadId,
            date: load.date,
            statusLabel: _statusLabel,
            statusColor: _statusColor,
          ),
          Padding(
            padding: EdgeInsets.all(14.w),
            child: Column(
              children: [
                _RouteSection(load: load),
                12.verticalSpace,
                const Divider(height: 1, color: Color(0xFFEEEEEE)),
                12.verticalSpace,
                _StatsRow(miles: load.miles, pay: load.pay),
                12.verticalSpace,
                _ActionButton(
                  onTap: onAction ?? onViewDetails,
                  label: actionLabel,
                  style: actionStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadHeader extends StatelessWidget {
  final String loadId;
  final String? date;
  final String statusLabel;
  final Color statusColor;

  const _LoadHeader({
    required this.loadId,
    this.date,
    required this.statusLabel,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextStyle(
                text: '# $loadId',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              2.verticalSpace,
              if (date != null)
                AppTextStyle(
                  text: date!,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withAlpha(200),
                ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(75),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: statusColor),
            ),
            child: AppTextStyle(
              text: statusLabel,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _RouteSection extends StatelessWidget {
  final LoadModel load;

  const _RouteSection({required this.load});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: 10.w,
                height: 10.w,
                decoration: const BoxDecoration(
                  color: AppColor.primary,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Container(width: 1.5.w, color: const Color(0xFFDDDDDD)),
              ),
              customSvgImage(
                imagePath: Assets.icons.locationPinIcon,
                width: 18.w,
                height: 20.w,
                color: Colors.red,
              ),
            ],
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextStyle(
                  text: load.originCity,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                AppTextStyle(
                  text: load.originAddress,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColor.hintText,
                ),
                Row(
                  children: [
                    customSvgImage(
                      imagePath: Assets.icons.stopwatchIcon,
                      width: 11.w,
                      height: 11.w,
                      color: AppColor.hintText,
                    ),
                    4.horizontalSpace,
                    AppTextStyle(
                      text: load.originTime,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.hintText,
                    ),
                  ],
                ),
                12.verticalSpace,
                AppTextStyle(
                  text: load.destinationCity,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                AppTextStyle(
                  text: load.destinationAddress,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColor.hintText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final int miles;
  final double pay;

  const _StatsRow({required this.miles, required this.pay});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _StatBox(value: '$miles', label: 'Miles')),
        12.horizontalSpace,
        Expanded(
          child: _StatBox(value: '\$${pay.toStringAsFixed(0)}', label: 'Pay'),
        ),
      ],
    );
  }
}

class _StatBox extends StatelessWidget {
  final String value;
  final String label;

  const _StatBox({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6FA),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          AppTextStyle(
            text: value,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          AppTextStyle(
            text: label,
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.hintText,
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String label;
  final LoadItemActionStyle style;

  const _ActionButton({
    this.onTap,
    required this.label,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    final isFilled = style == LoadItemActionStyle.filled;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isFilled ? AppColor.primary : Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: AppColor.primary,
            width: isFilled ? 0 : 0.8,
          ),
        ),
        child: AppTextStyle(
          text: label,
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: isFilled ? Colors.white : AppColor.primary,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
