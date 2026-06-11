import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/extensions/sizedbox_extension.dart';
import 'package:reedsexpressllc_flutter/app/core/theme/app_color.dart';
import 'package:reedsexpressllc_flutter/app/data/models/truck_model.dart';
import 'package:reedsexpressllc_flutter/app/widgets/app_text_style.dart';
import 'package:reedsexpressllc_flutter/app/widgets/appbar_title.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_icon_button.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_svg_image.dart';
import 'package:reedsexpressllc_flutter/app/widgets/global_button.dart';
import 'package:reedsexpressllc_flutter/gen/assets.gen.dart';

import '../controllers/vehicle_controller.dart';

class VehicleView extends GetView<VehicleController> {
  const VehicleView({super.key});

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
        title: appbarTitle(text: 'My Vehicle'),
      ),
      body: SafeArea(
        child: controller.isDriverUser
            ? _DriverVehicleBody(controller: controller)
            : _CarrierVehicleBody(controller: controller),
      ),
    );
  }
}

class _DriverVehicleBody extends StatelessWidget {
  final VehicleController controller;

  const _DriverVehicleBody({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _VehicleInfoItem(
            title: 'License Plate',
            value: controller.driverLicensePlate,
          ),
          16.height,
          _VehicleInfoItem(
            title: 'Truck Type',
            value: controller.driverTruckType,
          ),
          16.height,
          _VehicleInfoItem(title: 'VIN', value: controller.driverVin),
          16.height,
          _VehicleInfoItem(
            title: 'Model/ Make',
            value: controller.driverModelMake,
          ),
          16.height,
          _VehicleInfoItem(
            title: 'Unit Number',
            value: controller.driverUnitNumber,
          ),
        ],
      ),
    );
  }
}

class _VehicleInfoItem extends StatelessWidget {
  final String title;
  final String value;

  const _VehicleInfoItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextStyle(
          text: title,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        6.height,
        AppTextStyle(
          text: value,
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
          color: AppColor.hintText,
        ),
      ],
    );
  }
}

class _CarrierVehicleBody extends StatelessWidget {
  final VehicleController controller;

  const _CarrierVehicleBody({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                      text: 'All Trucks (${controller.trucks.length})',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    12.height,
                    ...List.generate(controller.trucks.length, (index) {
                      final truck = controller.trucks[index];
                      final isLast = index == controller.trucks.length - 1;

                      return Padding(
                        padding: EdgeInsets.only(bottom: isLast ? 8.h : 4.h),
                        child: _TruckRow(
                          truck: truck,
                          onViewTap: () => controller.viewTruck(truck),
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
          child: Column(
            children: [
              GlobalButton(onTap: controller.addTruck, text: 'Add a Truck'),
              12.height,
              GlobalButton(onTap: controller.assignTruck, text: 'Assign Truck'),
            ],
          ),
        ),
      ],
    );
  }
}

class _TruckRow extends StatelessWidget {
  final TruckModel truck;
  final VoidCallback onViewTap;

  const _TruckRow({required this.truck, required this.onViewTap});

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
                imagePath: Assets.icons.truckFillIcon,
                height: 20.h,
                width: 20.w,
                color: AppColor.primary,
              ),
            ),
          ),
          12.width,
          Expanded(
            child: AppTextStyle(
              text: truck.unitNumber,
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
          const _AssignedBadge(),
        ],
      ),
    );
  }
}

class _AssignedBadge extends StatelessWidget {
  const _AssignedBadge();

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
        text: 'Assigned',
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF4CAF50),
      ),
    );
  }
}
