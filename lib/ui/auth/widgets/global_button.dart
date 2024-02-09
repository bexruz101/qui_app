import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_quiz_app/utils/colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class GlobalButton extends StatelessWidget {
  const GlobalButton({super.key, required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 7.h),
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          height: 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            color: AppColors.C_004643,
          ),
          child: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.white),
            ),
          ),
        ));
  }
}
