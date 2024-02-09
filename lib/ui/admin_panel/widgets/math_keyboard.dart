import 'package:flutter/material.dart';
import 'package:math_keyboard/math_keyboard.dart';

import '../../../utils/colors.dart';

class MathKeyboard extends StatelessWidget {
  const MathKeyboard({super.key, required this.hintText, required this.controller});


  final String hintText;
  final MathFieldEditingController controller;



  @override
  Widget build(BuildContext context) {
    return MathField(
      keyboardType: MathKeyboardType.expression,
      variables: ['x','y','z','=','?',],
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
      controller: controller,
    );
  }
}
