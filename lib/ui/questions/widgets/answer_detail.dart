import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_quiz_app/utils/colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class AnswerDetail extends StatelessWidget {
  const AnswerDetail({super.key, required this.variantName, required this.answerTxt, required this.onTap, required this.isSelected});

  final String variantName;
  final String answerTxt;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: Container(
        width: 320.w,
        height: 53.h,
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        margin: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(color: isSelected ? AppColors.C_ABD1C6 : AppColors.white,borderRadius: BorderRadius.circular(16.r),boxShadow: [
          BoxShadow(
            color: AppColors.C_EEEFF2.withOpacity(0.6),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0,3),
          )
        ]),
        child: Row(
          children: [
            Text(variantName,style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w700),),
            SizedBox(width: 17.w,),
            Math.tex(answerTxt,mathStyle: MathStyle.display,),
            Spacer(),
            Icon(isSelected?Icons.check_circle:Icons.circle_outlined)
          ],
        ),
      ),
    );
  }
}
