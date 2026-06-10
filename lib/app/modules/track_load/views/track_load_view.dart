import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:reedsexpressllc_flutter/app/core/extensions/sizedbox_extension.dart';
import 'package:reedsexpressllc_flutter/app/core/theme/app_color.dart';
import 'package:reedsexpressllc_flutter/app/widgets/app_text_style.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_icon_button.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_svg_image.dart';
import 'package:reedsexpressllc_flutter/gen/assets.gen.dart';

import '../controllers/track_load_controller.dart';

class TrackLoadView extends GetView<TrackLoadController> {
  const TrackLoadView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: controller.mapController,
            options: MapOptions(
              initialCenter: controller.currentPosition,
              initialZoom: 7,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all,
              ),
              onMapReady: controller.fitRouteOnMap,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.reedsexpressllc.app',
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: controller.routePoints,
                    color: const Color(0xFF22C55E),
                    strokeWidth: 5,
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  _buildOriginMarker(controller.origin),
                  _buildDestinationMarker(controller.destination),
                  _buildEtaMarker(
                    controller.etaMarkerPoint,
                    controller.etaMinutes,
                  ),
                  _buildVehicleMarker(controller.currentPosition),
                  ...controller.nearbyDrivers.map(_buildDriverMarker),
                ],
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.paddingOf(context).top + 12.h,
            left: 16.w,
            child: const CustomIconButton(),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _LoadTrackingCard(controller: controller),
          ),
        ],
      ),
    );
  }

  Marker _buildOriginMarker(LatLng point) {
    return Marker(
      point: point,
      width: 28,
      height: 28,
      child: customSvgImage(
        imagePath: Assets.icons.locationFillIcon,
        width: 14,
        height: 14,
      ),
    );
  }

  Marker _buildDestinationMarker(LatLng point) {
    return Marker(
      point: point,
      width: 36,
      height: 44,
      alignment: Alignment.topCenter,
      child: customSvgImage(
        imagePath: Assets.icons.locationPinIcon,
        width: 36,
        height: 44,
        color: const Color(0xFFFF6B00),
      ),
    );
  }

  Marker _buildEtaMarker(LatLng point, int minutes) {
    return Marker(
      point: point,
      width: 72,
      height: 72,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFF6B00),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF6B00).withAlpha(80),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTextStyle(
              text: '$minutes',
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1,
            ),
            AppTextStyle(
              text: 'MIN',
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.2,
            ),
          ],
        ),
      ),
    );
  }

  Marker _buildVehicleMarker(LatLng point) {
    return Marker(
      point: point,
      width: 44,
      height: 44,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF9C80E),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(30),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: customSvgImage(
            imagePath: Assets.icons.truckFillIcon,
            width: 22,
            height: 22,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Marker _buildDriverMarker(LatLng point) {
    return Marker(
      point: point,
      width: 16,
      height: 16,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.primary,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
      ),
    );
  }
}

class _LoadTrackingCard extends StatelessWidget {
  final TrackLoadController controller;

  const _LoadTrackingCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    final load = controller.load;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextStyle(
                          text: '# ${load.loadId}',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        4.height,
                        AppTextStyle(
                          text: '${load.miles} miles',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColor.hintText,
                        ),
                      ],
                    ),
                  ),
                  AppTextStyle(
                    text: load.date,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              14.height,
              const Divider(height: 1, color: Color(0xFFEEEEEE)),
              14.height,
              IntrinsicHeight(
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
                          child: Container(
                            width: 1.5.w,
                            color: const Color(0xFFDDDDDD),
                          ),
                        ),
                        customSvgImage(
                          imagePath: Assets.icons.locationPinIcon,
                          width: 18.w,
                          height: 20.w,
                          color: Colors.red,
                        ),
                      ],
                    ),
                    12.width,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextStyle(
                            text: controller.originCity,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          2.height,
                          AppTextStyle(
                            text: controller.originStreet,
                            fontSize: 12.sp,
                            color: AppColor.hintText,
                          ),
                          4.height,
                          Row(
                            children: [
                              customSvgImage(
                                imagePath: Assets.icons.stopwatchIcon,
                                width: 12.w,
                                height: 12.w,
                                color: AppColor.hintText,
                              ),
                              4.width,
                              AppTextStyle(
                                text: load.pickupTime,
                                fontSize: 12.sp,
                                color: AppColor.hintText,
                              ),
                            ],
                          ),
                          14.height,
                          AppTextStyle(
                            text: controller.destinationCity,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          2.height,
                          AppTextStyle(
                            text: controller.destinationStreet,
                            fontSize: 12.sp,
                            color: AppColor.hintText,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
