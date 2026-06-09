import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../core/theme/app_color.dart';

class GlobalLoading extends StatelessWidget {
  const GlobalLoading({super.key, this.size});

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.threeArchedCircle(
        color: AppColor.primary,
        size: size ?? 35.sp,
      ),
    );
  }
}
