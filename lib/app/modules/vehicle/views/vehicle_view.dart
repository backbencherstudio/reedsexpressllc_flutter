import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/extensions/sizedbox_extension.dart';
import '../../../core/theme/app_color.dart';
import '../../../widgets/app_text_style.dart';
import '../../../widgets/appbar_title.dart';
import '../../../widgets/custom_icon_button.dart';
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
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildVehicleItem('Truck Unit', controller.truckUnit.value),
              16.verticalSpace,
              _buildVehicleItem('Truck', controller.truck.value),
              16.verticalSpace,
              _buildVehicleItem('Truck VIN', controller.truckVin.value),
              16.verticalSpace,
              _buildVehicleItem('Truck Plate', controller.truckPlate.value),
              16.verticalSpace,
              _buildVehicleItem('Trailer Unit', controller.trailerUnit.value),
              16.verticalSpace,
              _buildVehicleItem('Trailer Type', controller.trailerType.value),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVehicleItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextStyle(
          text: title,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        6.verticalSpace,
        AppTextStyle(
          text: value,
          fontSize: 15.sp,
          color: const Color(0xFF8B93AA), // Light grayish-blue for "Not assigned"
        ),
      ],
    );
  }
}
