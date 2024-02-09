import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/colors.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.height, required this.txt});

  final int height;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return  Container(
        height: height.h,
        width: 300.w,
        padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 15),
        margin: const EdgeInsets.symmetric(horizontal: 18),
        decoration:  BoxDecoration(color: AppColors.white,
          border:  Border.all(color: AppColors.C_ABD1C6),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Text(txt));
  }
}
