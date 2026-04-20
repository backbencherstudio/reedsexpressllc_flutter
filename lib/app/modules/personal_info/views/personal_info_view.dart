import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../gen/assets.gen.dart';
import '../../../core/extensions/sizedbox_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_input_text_form_field.dart';
import '../../../core/widgets/app_text_style.dart';
import '../../../core/widgets/appbar_title.dart';
import '../../../core/widgets/custom_icon_button.dart';
import '../../../core/widgets/custom_svg_image.dart';
import '../../../core/widgets/global_button.dart';
import '../controllers/personal_info_controller.dart';

class PersonalInfoView extends GetView<PersonalInfoController> {
  const PersonalInfoView({super.key});

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
        title: appbarTitle(text: 'Personal Info'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Edit button
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => controller.toggleEdit(),
                        child: Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: customSvgImage(
                            imagePath: Assets.icons.editIcon,
                            width: 22.w,
                            height: 22.w,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                    10.verticalSpace,

                    // Avatar
                    Center(
                      child: Stack(
                        children: [
                          Obx(() => Container(
                            height: 90.w,
                            width: 90.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF8B93B6), // Light blueish purple
                              image: controller.profileImage.value != null
                                  ? DecorationImage(
                                      image: FileImage(controller.profileImage.value!),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            alignment: Alignment.center,
                            child: controller.profileImage.value == null
                                ? AppTextStyle(
                                    text: "MJ",
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  )
                                : const SizedBox.shrink(),
                          )),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () => controller.pickProfilePicture(),
                              child: Container(
                                height: 30.w,
                                width: 30.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: customSvgImage(
                                    imagePath: Assets.icons.cameraIcon,
                                    width: 16.w,
                                    height: 16.w,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    40.verticalSpace,

                    InputFieldWithLabel(
                      label: 'Full Name',
                      controller: controller.fullNameController,
                    ),
                    16.verticalSpace,

                    InputFieldWithLabel(
                      label: 'Contact',
                      controller: controller.contactController,
                      keyboardType: TextInputType.phone,
                    ),
                    16.verticalSpace,

                    InputFieldWithLabel(
                      label: 'Email',
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    40.verticalSpace,

                    Obx(
                      () => controller.isEditing.value
                          ? globalButton(
                              onTap: () {
                                controller.toggleEdit();
                                // Save logic here
                              },
                              text: "Save Changes",
                              textColor: Colors.white,
                            )
                          : const SizedBox.shrink(),
                    ),
                    40.verticalSpace,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
