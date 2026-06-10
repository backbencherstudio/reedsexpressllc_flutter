import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/extensions/sizedbox_extension.dart';
import 'package:reedsexpressllc_flutter/app/core/theme/app_color.dart';
import 'package:reedsexpressllc_flutter/app/core/utils/helper_utils.dart';
import 'package:reedsexpressllc_flutter/app/routes/app_pages.dart';
import 'package:reedsexpressllc_flutter/app/widgets/app_text_style.dart';
import 'package:reedsexpressllc_flutter/app/widgets/cached_image_widget.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_icon_button.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_svg_image.dart';
import 'package:reedsexpressllc_flutter/app/widgets/global_button.dart';

import 'package:reedsexpressllc_flutter/gen/assets.gen.dart';
import '../../../core/constants/enums.dart';
import '../../../widgets/appbar_title.dart';
import '../../../data/models/tracking_status_model.dart';
import '../widgets/upload_documents_dialog.dart';
import '../controllers/load_details_controller.dart';

class LoadDetailsView extends GetView<LoadDetailsController> {
  const LoadDetailsView({super.key});

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
        title: appbarTitle(text: 'Load Details'),
      ),
      body: Obx(() {
        final load = controller.loadDetails.value;
        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Load ID header card ──────────────────────────
              _LoadHeaderCard(load: load),
              14.verticalSpace,

              // ── Upload Documents button (Delivered status only) ──
              if (HelperUtils.isDriverUser == true &&
                  load.status == LoadStatus.delivered) ...[
                _UploadButton(
                  onTap: () {
                    Get.dialog(
                      const UploadDocumentsDialog(),
                      barrierDismissible: false,
                    );
                  },
                ),
                14.verticalSpace,
              ],

              // ── Assigned Driver ─────────────────────────────
              HelperUtils.isCarrierUser
                  ? _SectionCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _CardTitle(title: 'Assigned Driver'),
                          10.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CachedImage(
                                imgUrl: HelperUtils.defaultProfileImage,
                                height: 30.h,
                                width: 30.h,
                                borderRadius: 50.r,
                              ),
                              10.width,
                              Expanded(
                                child: AppTextStyle(
                                  text: "David Johnson",
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : SizedBox.shrink(),
              14.verticalSpace,
              // ── Load Summary ─────────────────────────────────
              _SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CardTitle(title: 'Load Summery'),
                    12.verticalSpace,
                    _MilesPayRow(miles: load.miles, pay: load.pay),
                    14.verticalSpace,
                    const Divider(height: 1, color: Color(0xFFEEEEEE)),
                    14.verticalSpace,
                    _DetailRow(
                      iconPath: Assets.icons.locationIcon,
                      title: 'Pickup Details',
                      company: load.pickupCompany,
                      address: load.pickupAddress,
                      time: load.pickupTime,
                      date: load.pickupDate,
                    ),
                    14.verticalSpace,
                    const Divider(height: 1, color: Color(0xFFEEEEEE)),
                    14.verticalSpace,
                    _DetailRow(
                      iconPath: Assets.icons.locationIcon,
                      title: 'Delivery Details',
                      company: load.deliveryCompany,
                      address: load.deliveryAddress,
                      time: load.deliveryTime,
                      date: load.deliveryDate,
                    ),
                    14.verticalSpace,
                    const Divider(height: 1, color: Color(0xFFEEEEEE)),
                    14.verticalSpace,
                    _BrokerRow(
                      name: load.brokerName,
                      reference: load.brokerReference,
                      email: load.brokerEmail,
                      phone: load.brokerPhone,
                    ),

                    HelperUtils.isCarrierUser
                        ? GlobalButton(
                            padding: EdgeInsets.only(top: 16.h),
                            onTap: () {
                              Get.toNamed(
                                Routes.TRACK_LOAD,
                                arguments: load,
                              );
                            },
                            text: "Track Load",
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),

              14.verticalSpace,
              // ── Dispatcher ─────────────────────────────
              _SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CardTitle(title: 'Dispatcher'),
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CachedImage(
                          imgUrl: HelperUtils.defaultProfileImage,
                          height: 30.h,
                          width: 30.h,
                          borderRadius: 50.r,
                        ),
                        10.width,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextStyle(
                                text: "David Johnson",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              AppTextStyle(
                                text: 'burger@gmail.com',
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF555555),
                                height: 1.6,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: customSvgImage(
                            imagePath: Assets.icons.messageIcon,
                          ),
                        ),
                        15.width,
                        GestureDetector(
                          onTap: () {},
                          child: customSvgImage(
                            imagePath: Assets.icons.callIcon,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              14.verticalSpace,

              // ── Tracking Timeline ────────────────────────────
              _SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CardTitle(title: 'Tracking Timeline'),
                    12.verticalSpace,
                    _NoticeBox(),
                    16.verticalSpace,
                    _TrackingTimeline(
                      steps: load.trackingSteps,
                      onMarkDone: controller.markDone,
                    ),
                  ],
                ),
              ),
              14.verticalSpace,

              // ── APickup Details ─────────────────────────────
              // _SectionCard(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       _CardTitle(title: 'Pickup Details'),
              //       10.verticalSpace,
              //       AppTextStyle(
              //         text: load.additionalNotes,
              //         fontSize: 13.sp,
              //         fontWeight: FontWeight.w400,
              //         color: const Color(0xFF555555),
              //         height: 1.6,
              //       ),
              //       20.height,
              //       _CustomRow(
              //         icon: Assets.icons.companyIcon,
              //         title: "Company",
              //         subTitle: "Delta LTD",
              //       ),
              //       _CustomRow(
              //         icon: Assets.icons.locationIcon,
              //         title: "Address",
              //         subTitle: "Houston USA, 12 A Lane",
              //       ),
              //       _CustomRow(
              //         icon: Assets.icons.stopwatchIcon,
              //         title: "Company",
              //         subTitle: "27 March, 2026 at 3:20 PM",
              //       ),
              //     ],
              //   ),
              // ),
              //
              // 14.verticalSpace,
              // // ── Delivery Details ─────────────────────────────
              // _SectionCard(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       _CardTitle(title: 'Delivery Details'),
              //
              //       20.height,
              //       _CustomRow(
              //         icon: Assets.icons.companyIcon,
              //         title: "Company",
              //         subTitle: "Not specified",
              //       ),
              //       _CustomRow(
              //         icon: Assets.icons.locationIcon,
              //         title: "Address",
              //         subTitle: "Houston USA, 12 A Lane",
              //       ),
              //       _CustomRow(
              //         icon: Assets.icons.stopwatchIcon,
              //         title: "Appointment",
              //         subTitle: "27 March, 2026 at 3:20 PM",
              //       ),
              //     ],
              //   ),
              // ),
              14.verticalSpace,
              // ── Additional Notes ─────────────────────────────
              _SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CardTitle(title: 'Additional Notes'),
                    10.verticalSpace,
                    AppTextStyle(
                      text: load.additionalNotes,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF555555),
                      height: 1.6,
                    ),
                  ],
                ),
              ),
              14.verticalSpace,

              // ── Uploaded Documents ───────────────────────────
              _SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CardTitle(title: 'Uploaded Documents'),
                    12.verticalSpace,
                    ...load.uploadedDocuments.map(
                      (doc) => Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: _DocumentItem(doc: doc),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

// ── Load Header Card ──────────────────────────────────────────────────────────

class _LoadHeaderCard extends StatelessWidget {
  final LoadDetailsModel load;

  const _LoadHeaderCard({required this.load});

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
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextStyle(
                text: '# ${load.loadId}',
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              4.verticalSpace,
              AppTextStyle(
                text: load.date,
                fontSize: 12.sp,
                color: Colors.white.withAlpha(210),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: _statusColor.withAlpha(75),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: _statusColor),
            ),
            child: AppTextStyle(
              text: _statusLabel,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: _statusColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Upload Button ─────────────────────────────────────────────────────────────

class _UploadButton extends StatelessWidget {
  final VoidCallback onTap;

  const _UploadButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColor.primary,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.white, size: 18.sp),
            6.horizontalSpace,
            AppTextStyle(
              text: 'Upload Documents',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Section Card wrapper ──────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final Widget child;

  const _SectionCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ── Card Title ────────────────────────────────────────────────────────────────

class _CardTitle extends StatelessWidget {
  final String title;

  const _CardTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppTextStyle(
      text: title,
      fontSize: 15.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    );
  }
}

// ── Miles Pay Row ─────────────────────────────────────────────────────────────

class _MilesPayRow extends StatelessWidget {
  final int miles;
  final double pay;

  const _MilesPayRow({required this.miles, required this.pay});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            customSvgImage(
              imagePath: Assets.icons.milesIcon,
              width: 16.w,
              height: 16.w,
              color: AppColor.hintText,
            ),
            6.horizontalSpace,
            AppTextStyle(
              text: '$miles miles',
              fontSize: 13.sp,
              color: AppColor.hintText,
            ),
          ],
        ),
        AppTextStyle(
          text: '\$${pay.toStringAsFixed(2)}',
          fontSize: 15.sp,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ],
    );
  }
}

// ── Detail Row (Pickup / Delivery) ────────────────────────────────────────────

class _DetailRow extends StatelessWidget {
  final String iconPath;
  final String title;
  final String company;
  final String address;
  final String time;
  final String date;

  const _DetailRow({
    required this.iconPath,
    required this.title,
    required this.company,
    required this.address,
    required this.time,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(4.r),
          decoration: BoxDecoration(
            color: AppColor.primary.withAlpha(25),
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Center(
            child: customSvgImage(
              imagePath: iconPath,
              width: 18.w,
              height: 18.w,
              color: AppColor.primary,
            ),
          ),
        ),
        10.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextStyle(
                text: title,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              4.verticalSpace,
              AppTextStyle(
                text: company,
                fontSize: 12.sp,
                color: AppColor.hintText,
              ),
              AppTextStyle(
                text: address,
                fontSize: 12.sp,
                color: AppColor.hintText,
              ),
              6.verticalSpace,
              Row(
                children: [
                  customSvgImage(
                    imagePath: Assets.icons.stopwatchIcon,
                    width: 12.w,
                    height: 12.w,
                    color: AppColor.hintText,
                  ),
                  4.horizontalSpace,
                  AppTextStyle(
                    text: time,
                    fontSize: 11.sp,
                    color: AppColor.hintText,
                  ),
                  8.horizontalSpace,
                  Container(
                    width: 4.w,
                    height: 4.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFFAAAAAA),
                      shape: BoxShape.circle,
                    ),
                  ),
                  8.horizontalSpace,
                  AppTextStyle(
                    text: date,
                    fontSize: 11.sp,
                    color: AppColor.hintText,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Broker Row ────────────────────────────────────────────────────────────────

class _BrokerRow extends StatelessWidget {
  final String name;
  final String reference;
  final String email;
  final String phone;

  const _BrokerRow({
    required this.name,
    required this.reference,
    required this.email,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(4.r),
          decoration: BoxDecoration(
            color: AppColor.primary.withAlpha(25),
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Center(
            child: customSvgImage(
              imagePath: Assets.icons.personsIcon,
              width: 18.w,
              height: 18.w,
              color: AppColor.primary,
            ),
          ),
        ),
        10.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextStyle(
                text: 'Broker Information',
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              4.verticalSpace,
              AppTextStyle(
                text: name,
                fontSize: 12.sp,
                color: AppColor.hintText,
              ),
              AppTextStyle(
                text: reference,
                fontSize: 12.sp,
                color: AppColor.hintText,
              ),
              8.verticalSpace,
              Row(
                children: [
                  customSvgImage(
                    imagePath: Assets.icons.messageIcon,
                    width: 12.w,
                    height: 12.w,
                    color: AppColor.hintText,
                  ),
                  4.horizontalSpace,
                  AppTextStyle(
                    text: email,
                    fontSize: 11.sp,
                    color: AppColor.hintText,
                  ),
                ],
              ),
              4.verticalSpace,
              Row(
                children: [
                  customSvgImage(
                    imagePath: Assets.icons.phoneIcon,
                    width: 12.w,
                    height: 12.w,
                    color: AppColor.hintText,
                  ),
                  4.horizontalSpace,
                  AppTextStyle(
                    text: phone,
                    fontSize: 11.sp,
                    color: AppColor.hintText,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Notice Box ────────────────────────────────────────────────────────────────

class _NoticeBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColor.primary.withAlpha(18),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextStyle(
            text: 'Notice',
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          4.verticalSpace,
          AppTextStyle(
            text: 'Without "Mark Done", your billing won\'t be tracked.',
            fontSize: 12.sp,
            color: const Color(0xFF555555),
            height: 1.5,
          ),
        ],
      ),
    );
  }
}

// ── Tracking Timeline ─────────────────────────────────────────────────────────

class _TrackingTimeline extends StatelessWidget {
  final List<TrackingStepModel> steps;
  final VoidCallback onMarkDone;

  const _TrackingTimeline({required this.steps, required this.onMarkDone});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(steps.length, (index) {
        final step = steps[index];
        final isLast = index == steps.length - 1;
        return _TimelineStep(
          step: step,
          isLast: isLast,
          onMarkDone: onMarkDone,
        );
      }),
    );
  }
}

class _TimelineStep extends StatelessWidget {
  final TrackingStepModel step;
  final bool isLast;
  final VoidCallback onMarkDone;

  const _TimelineStep({
    required this.step,
    required this.isLast,
    required this.onMarkDone,
  });

  @override
  Widget build(BuildContext context) {
    final isDimmed = !step.isDone && !step.isActive;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Dot + line ───────────────────────────────────
          SizedBox(
            width: 24.w,
            child: Column(
              children: [
                // Dot
                Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: step.isDone
                        ? AppColor.primary
                        : step.isActive
                        ? Colors.white
                        : Colors.white,
                    border: Border.all(
                      color: step.isDone
                          ? AppColor.primary
                          : step.isActive
                          ? AppColor.primary
                          : const Color(0xFFCCCCCC),
                      width: 2,
                    ),
                  ),
                ),
                // Line
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1.5.w,
                      color: step.isDone
                          ? AppColor.primary
                          : const Color(0xFFDDDDDD),
                    ),
                  ),
              ],
            ),
          ),
          12.horizontalSpace,

          // ── Content ──────────────────────────────────────
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextStyle(
                          text: step.title,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: isDimmed
                              ? const Color(0xFFAAAAAA)
                              : Colors.black,
                        ),
                        if (step.subNote != null) ...[
                          2.verticalSpace,
                          AppTextStyle(
                            text: step.subNote!,
                            fontSize: 11.sp,
                            color: const Color(0xFFAAAAAA),
                          ),
                        ],
                        4.verticalSpace,
                        AppTextStyle(
                          text: step.dateTime,
                          fontSize: 11.sp,
                          color: isDimmed
                              ? const Color(0xFFBBBBBB)
                              : AppColor.hintText,
                        ),
                      ],
                    ),
                  ),

                  // Badge
                  if (step.isActive)
                    GestureDetector(
                      onTap: onMarkDone,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check, size: 12.sp, color: Colors.white),
                            4.horizontalSpace,
                            AppTextStyle(
                              text: 'Mark Done',
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: step.isDone
                            ? AppColor.primary.withAlpha(20)
                            : const Color(0xFFF0F0F0),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check,
                            size: 11.sp,
                            color: step.isDone
                                ? AppColor.primary
                                : const Color(0xFFAAAAAA),
                          ),
                          3.horizontalSpace,
                          AppTextStyle(
                            text: 'Done',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color: step.isDone
                                ? AppColor.primary
                                : const Color(0xFFAAAAAA),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Document Item ─────────────────────────────────────────────────────────────

class _DocumentItem extends StatelessWidget {
  final UploadedDocumentModel doc;

  const _DocumentItem({required this.doc});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customSvgImage(
          imagePath: Assets.icons.docIcon,
          width: 32.w,
          height: 32.w,
          color: AppColor.hintText,
        ),
        10.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextStyle(
                text: doc.fileName,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              4.verticalSpace,
              Row(
                children: [
                  AppTextStyle(
                    text: doc.fileSize,
                    fontSize: 11.sp,
                    color: AppColor.hintText,
                  ),
                  AppTextStyle(
                    text: '  •  ',
                    fontSize: 11.sp,
                    color: AppColor.hintText,
                  ),
                  AppTextStyle(
                    text: doc.uploadedAt,
                    fontSize: 11.sp,
                    color: AppColor.hintText,
                  ),
                ],
              ),
              6.verticalSpace,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: doc.tagColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: AppTextStyle(
                  text: doc.tag,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: doc.tagColor,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: customSvgImage(
            imagePath: Assets.icons.uploadIcon,
            width: 20.w,
            height: 20.w,
            color: AppColor.primary,
          ),
        ),
      ],
    );
  }
}

class _CustomRow extends StatelessWidget {
  final String icon;
  final String title;
  final String? subTitle;

  const _CustomRow({required this.icon, required this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(4.r),
            decoration: BoxDecoration(
              color: AppColor.primary.withAlpha(25),
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Center(
              child: customSvgImage(
                imagePath: icon,
                width: 18.w,
                height: 18.w,
                color: AppColor.primary,
              ),
            ),
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextStyle(
                  text: title,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                4.verticalSpace,
                if (subTitle != null)
                  AppTextStyle(
                    text: subTitle!,
                    fontSize: 12.sp,
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
