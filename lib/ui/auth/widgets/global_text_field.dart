import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_quiz_app/utils/colors.dart';

class GlobalTextField extends StatelessWidget {
   GlobalTextField(
      {super.key,
      required this.hintText,
      this.obscureText = false,
      required this.controller,
      this.maxLine = 1,
      required this.textAlign,
      required this.textInputAction,
      required this.keyboardType});

  final String hintText;
  TextInputType keyboardType;
  TextInputAction textInputAction;
  final bool obscureText;
  TextAlign textAlign;
  final TextEditingController controller;
  final int maxLine;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w),
      decoration: BoxDecoration(
          color: AppColors.C_EEEFF2,
          boxShadow: [BoxShadow(color: AppColors.black.withOpacity(0.5))]),
      child: TextField(
        maxLines: maxLine,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20),
        textAlign: textAlign,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.C_EEEFF2,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.titleMedium,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 1,color: AppColors.C_EEEFF2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 1,color: AppColors.C_EEEFF2),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(width: 1,color: AppColors.C_EEEFF2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 1,color: AppColors.C_EEEFF2),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 1,color: AppColors.C_EEEFF2),
          ),
        ),
      ),
    );
  }
}
