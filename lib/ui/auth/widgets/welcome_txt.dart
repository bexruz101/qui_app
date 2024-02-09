import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeTxt extends StatelessWidget {
  const WelcomeTxt({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.calculate_outlined,
          size: 48,
        ),
        SizedBox(width: 8.w,),
        Text('Welcome to Test', style: Theme
            .of(context)
            .textTheme
            .headlineLarge!
            .copyWith(fontWeight: FontWeight.w500),),
      ],
    );
  }
}
