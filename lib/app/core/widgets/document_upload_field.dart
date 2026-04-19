import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:reedsexpressllc_flutter/app/core/theme/app_colors.dart';
import 'package:reedsexpressllc_flutter/app/core/widgets/app_text_style.dart';
import 'package:reedsexpressllc_flutter/app/core/widgets/custom_svg_image.dart';
import '../../../gen/assets.gen.dart';

class DocumentUploadField extends StatelessWidget {
  final String label;
  final RxnString filePathObs;
  final VoidCallback onTap;
  final VoidCallback onRemove;
  final bool isRequired;
  final Color? fieldColor;

  const DocumentUploadField({
    super.key,
    required this.label,
    required this.filePathObs,
    required this.onTap,
    required this.onRemove,
    this.isRequired = true, this.fieldColor,
  });

  String _formatFileSize(String filePath) {
    try {
      final bytes = File(filePath).lengthSync();
      if (bytes < 1024) return '$bytes B';
      if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    } catch (_) {
      return '';
    }
  }

  bool _isImage(String filePath) {
    final ext = p.extension(filePath).toLowerCase();
    return ext == '.jpg' || ext == '.jpeg' || ext == '.png';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Row(
          children: [
            AppTextStyle(
              text: label,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            if (isRequired)
              AppTextStyle(
                text: ' *',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.red.shade800,
              ),
          ],
        ),
        4.verticalSpace,

        // Upload box
        Obx(() {
          final filePath = filePathObs.value;
          final isUploaded = filePath != null;

          return GestureDetector(
            onTap: isUploaded ? null : onTap,
            child: DottedBorder(
              options: RoundedRectDottedBorderOptions(
                radius: Radius.circular(10.r),
                dashPattern: const [6, 4],
                strokeWidth: 1,
                color: isUploaded ? AppColors.primary : AppColors.hintText,
                padding: EdgeInsets.zero,
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 12.h,
                ),
                decoration: BoxDecoration(
                  color: isUploaded
                      ? AppColors.primary.withAlpha(10)
                      : fieldColor?? Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: isUploaded
                    ? _UploadedState(
                  filePath: filePath,
                  fileSize: _formatFileSize(filePath),
                  isImage: _isImage(filePath),
                  onRemove: onRemove,
                )
                    : const _EmptyState(),
              ),
            ),
          );
        }),
      ],
    );
  }
}

// ── Empty state ───────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        customSvgImage(
          imagePath: Assets.icons.uploadIcon,
          color: AppColors.hintText,
        ),
        6.horizontalSpace,
        AppTextStyle(
          text: 'Upload file (Image or PDF)',
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.hintText,
        ),
      ],
    );
  }
}

// ── Uploaded state ────────────────────────────────────────────────────────────

class _UploadedState extends StatelessWidget {
  final String filePath;
  final String fileSize;
  final bool isImage;
  final VoidCallback onRemove;

  const _UploadedState({
    required this.filePath,
    required this.fileSize,
    required this.isImage,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final fileName = p.basename(filePath);

    return Row(
      children: [
        // Thumbnail for image, doc icon for PDF
        if (isImage)
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: Image.file(
              File(filePath),
              width: 36.w,
              height: 36.w,
              fit: BoxFit.cover,
            ),
          )
        else
          customSvgImage(
            imagePath: Assets.icons.docIcon,
            color: AppColors.primary,
          ),

        10.horizontalSpace,

        // File name + size
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextStyle(
                text: fileName,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (fileSize.isNotEmpty)
                AppTextStyle(
                  text: fileSize,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.hintText,
                ),
            ],
          ),
        ),

        // Remove button
        GestureDetector(
          onTap: onRemove,
          child: customSvgImage(
            imagePath: Assets.icons.crossCircleIcon,
            color: AppColors.hintText,
          ),
        ),
      ],
    );
  }
}