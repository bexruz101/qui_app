import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_quiz_app/ui/auth/widgets/welcome_txt.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../widgets/global_button.dart';
import '../widgets/global_text_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key, required this.onChanged});

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
            title: 'Sign Up',
            onTap: () {
              context.read<AuthProviderr>().signUpUser(context);
              context.read<AuthProviderr>().signUpButtonPressed();
            }),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    onChanged.call();
                    context.read<AuthProviderr>().loginButtonPressed();
                  },
                  child: Text(
                    'Log In',
                    style: Theme.of(context).textTheme.titleLarge,
                  )),
            ],
          ),
        ),
      ],
    ));
  }
}
