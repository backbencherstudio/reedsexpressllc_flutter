import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

class AppInputTextFormField extends StatelessWidget {
  const AppInputTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.expands,
    this.labelText,
    this.validator,
    this.autoValidateMode,
    this.obscureText,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.enabled,
    this.readOnly,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.onChanged,
    this.onTap,
    this.onSaved,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.textInputAction,
    this.focusNode,
    this.autofocus,
    this.contentPadding,
    this.fillColor,
    this.cursorColor,
    this.borderColor,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.disabledBorderColor,
    this.errorBorderColor,
    this.errorTextColor,
    this.hintTextColor,
    this.labelTextColor,
    this.textColor,
    this.fontSize,
    this.borderWidth,
    this.borderRadius,
    this.height,
    this.width,
    this.suffix,
    this.prefix,
    this.fontWeight,
    this.errorFontWeight,
    this.errorFontSize,
    this.inputFormatters,
    this.prefixIconSize,
    this.suffixIconSize,
    this.prefixIconPadding,
    this.suffixIconPadding,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final AutovalidateMode? autoValidateMode;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? prefix;
  final bool? enabled;
  final bool? readOnly;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final void Function(String?)? onChanged;
  final void Function()? onTap;
  final void Function(String?)? onSaved;
  final void Function()? onEditingComplete;
  final void Function(String?)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool? autofocus;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final Color? cursorColor;
  final Color? borderColor;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Color? disabledBorderColor;
  final Color? errorBorderColor;
  final Color? errorTextColor;
  final Color? hintTextColor;
  final Color? labelTextColor;
  final Color? textColor;
  final double? fontSize;
  final double? borderWidth;
  final double? borderRadius;
  final double? height;
  final double? width;
  final bool? expands;
  final FontWeight? fontWeight;
  final FontWeight? errorFontWeight;
  final double? errorFontSize;

  /// Controls the tap/clickable area size of prefix/suffix icons.
  /// Defaults to 40x40. Increase if you need a larger hit area.
  final Size? prefixIconSize;
  final Size? suffixIconSize;

  /// Inner padding around the prefix/suffix icon widget.
  /// Use this to fine-tune icon position inside the constraint box.
  final EdgeInsetsGeometry? prefixIconPadding;
  final EdgeInsetsGeometry? suffixIconPadding;

  /// Wraps an icon widget so that:
  ///  - The outer BoxConstraints clamp the icon slot to [size]
  ///  - [padding] adds breathing room around the actual SVG/icon
  ///  - The icon is always centred inside its slot
  Widget _buildIconWrapper({
    required Widget icon,
    required Size size,
    EdgeInsetsGeometry? padding,
  }) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Center(
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: icon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double radius = borderRadius ?? 50.r;
    final double stroke = borderWidth ?? 1;

    // Resolved icon constraint sizes
    final Size resolvedPrefixSize = prefixIconSize ?? Size(40.w, 40.h);
    final Size resolvedSuffixSize = suffixIconSize ?? Size(40.w, 40.h);

    // Wrap icons only when provided
    final Widget? wrappedPrefix = prefixIcon != null
        ? _buildIconWrapper(
      icon: prefixIcon!,
      size: resolvedPrefixSize,
      padding: prefixIconPadding,
    )
        : null;

    final Widget? wrappedSuffix = suffixIcon != null
        ? _buildIconWrapper(
      icon: suffixIcon!,
      size: resolvedSuffixSize,
      padding: suffixIconPadding,
    )
        : null;

    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        expands: expands ?? false,
        key: key,
        maxLines: maxLines ?? 1,
        minLines: minLines ?? 1,
        controller: controller,
        obscureText: obscureText ?? false,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
        autovalidateMode:
        autoValidateMode ?? AutovalidateMode.onUserInteraction,
        enabled: enabled ?? true,
        readOnly: readOnly ?? false,
        maxLength: maxLength,
        onChanged: onChanged,
        onTap: onTap,
        onSaved: onSaved,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onFieldSubmitted,
        textInputAction: textInputAction,
        focusNode: focusNode,
        autofocus: autofocus ?? false,
        cursorColor: cursorColor ?? AppColors.primary,
        style: GoogleFonts.robotoFlex(
          textStyle: TextStyle(
            color: textColor ?? Colors.black,
            fontSize: fontSize ?? 14.sp,
            fontWeight: fontWeight ?? FontWeight.w400,
          ),
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),

          // ── Fill ────────────────────────────────────────────────────────────
          fillColor: fillColor ?? Colors.white,
          filled: true,

          // ── Hint ────────────────────────────────────────────────────────────
          hintText: hintText?.tr ?? "",
          hintStyle: GoogleFonts.robotoFlex(
            textStyle: TextStyle(
              color: hintTextColor ?? Colors.grey,
              fontSize: fontSize ?? 13.sp,
              fontWeight: fontWeight ?? FontWeight.w400,
            ),
          ),

          // ── Label ───────────────────────────────────────────────────────────
          labelText: labelText,
          labelStyle: GoogleFonts.robotoFlex(
            textStyle: TextStyle(
              color: labelTextColor ?? Colors.black,
              fontSize: fontSize ?? 14.sp,
              fontWeight: fontWeight ?? FontWeight.w400,
            ),
          ),

          // ── Error style ─────────────────────────────────────────────────────
          errorStyle: GoogleFonts.robotoFlex(
            textStyle: TextStyle(
              color: errorTextColor ?? AppColors.error,
              fontSize: errorFontSize ?? 11.sp,
              fontWeight: errorFontWeight ?? FontWeight.w400,
            ),
          ),

          // ── Icons (now size-constrained) ────────────────────────────────────
          prefixIcon: wrappedPrefix,
          prefixIconConstraints: BoxConstraints(
            minWidth: resolvedPrefixSize.width,
            minHeight: resolvedPrefixSize.height,
            maxWidth: resolvedPrefixSize.width,
            maxHeight: resolvedPrefixSize.height,
          ),
          suffixIcon: wrappedSuffix,
          suffixIconConstraints: BoxConstraints(
            minWidth: resolvedSuffixSize.width,
            minHeight: resolvedSuffixSize.height,
            maxWidth: resolvedSuffixSize.width,
            maxHeight: resolvedSuffixSize.height,
          ),

          suffix: suffix,
          prefix: prefix,

          // ── Borders ──────────────────────────────────────────────────────────
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: borderColor ?? Colors.grey.shade200,
              width: stroke,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: enabledBorderColor ?? Colors.grey.shade200,
              width: stroke,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: disabledBorderColor ?? Colors.grey.shade200,
              width: stroke,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: focusedBorderColor ?? AppColors.primary,
              width: stroke,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: errorBorderColor ?? AppColors.error,
              width: stroke,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: errorBorderColor ?? AppColors.error,
              width: stroke,
            ),
          ),
        ),
      ),
    );
  }
}
