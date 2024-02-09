import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_quiz_app/providers/auth_provider.dart';
import 'package:new_quiz_app/ui/auth/widgets/global_button.dart';
import 'package:new_quiz_app/ui/auth/widgets/global_text_field.dart';
import 'package:new_quiz_app/ui/auth/widgets/welcome_txt.dart';
import 'package:new_quiz_app/utils/colors.dart';
import 'package:new_quiz_app/utils/images.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.onChanged});

  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 10,
        ),
        WelcomeTxt(),
        SizedBox(
          height: 48.h,
        ),
        GlobalTextField(
            hintText: 'Email',
            controller: context.read<AuthProviderr>().emailController,
            textAlign: TextAlign.start,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress),
        SizedBox(
          height: 20.h,
        ),
        GlobalTextField(
            hintText: 'Password',
            controller: context.read<AuthProviderr>().passworController,
            textAlign: TextAlign.start,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress),
        SizedBox(
          height: 20.h,
        ),
        GlobalButton(
            title: 'Log In',
            onTap: () {
              context.read<AuthProviderr>().logInUser(context);
            }),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    onChanged.call();
                    context.read<AuthProviderr>().signUpButtonPressed();
                  },
                  child: Text(
                    'Sign Up',
                    style: Theme.of(context).textTheme.titleLarge,
                  )),
            ],
          ),
        ),
      ],
    ));
  }
}
