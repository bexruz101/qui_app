import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_quiz_app/utils/colors.dart';

class MyTimer extends StatelessWidget {
  const MyTimer({super.key, required this.rate, required this.timeText});

  final double rate;
  final String timeText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.h,
      child:Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            Icon(Icons.timer_sharp),
            SizedBox(width: 4,),
            Text(timeText),
          ],),
        SizedBox(height: 8.h,),
        ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: LinearProgressIndicator(
            value: rate,
            valueColor:  AlwaysStoppedAnimation<Color>(AppColors.C_ABD1C6),
            backgroundColor: AppColors.C_004643,
          ),
        ),
      ],)
    );
  }
}
