import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/core/extensions/sizedbox_extension.dart';
import 'package:reedsexpressllc_flutter/app/core/theme/app_color.dart';
import 'package:reedsexpressllc_flutter/app/widgets/app_input_text_form_field.dart';
import 'package:reedsexpressllc_flutter/app/widgets/app_text_style.dart';
import 'package:reedsexpressllc_flutter/app/widgets/appbar_title.dart';
import 'package:reedsexpressllc_flutter/app/widgets/custom_icon_button.dart';
import 'package:reedsexpressllc_flutter/app/widgets/global_button.dart';

import '../controllers/add_team_member_controller.dart';

class AddTeamMemberView extends GetView<AddTeamMemberController> {
  const AddTeamMemberView({super.key});

  @override
  Widget build(BuildContext context) {
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
        title: appbarTitle(text: 'Add a Driver'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _NoticeBox(),
                    20.height,
                    InputFieldWithLabel(
                      label: 'Driver Name',
                      controller: controller.driverNameController,
                    ),
                    16.height,
                    InputFieldWithLabel(
                      label: 'Email Address',
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    16.height,
                    Obx(
                      () => InputFieldWithLabel(
                        label: 'Set a Password',
                        controller: controller.passwordController,
                        obscureText: controller.obscurePassword.value,
                        suffixIcon: IconButton(
                          onPressed: controller.togglePasswordVisibility,
                          icon: Icon(
                            controller.obscurePassword.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColor.hintText,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              child: Obx(
                () => GlobalButton(
                  onTap: controller.sendInvitation,
                  text: 'Send Invitation',
                  isDisabled: controller.isLoading.value,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoticeBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4FF),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 18.sp,
                color: AppColor.primary,
              ),
              8.width,
              AppTextStyle(
                text: 'Notice',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          8.height,
          AppTextStyle(
            text:
                'Add a driver via their mail/work email and send credential with a 4 digit PIN.',
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF555555),
            height: 1.5,
          ),
        ],
      ),
    );
  }
}
