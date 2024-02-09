import 'package:flutter/material.dart';
import 'package:new_quiz_app/ui/auth/pages/login_page.dart';
import 'package:new_quiz_app/ui/auth/pages/sign_up_page.dart';
import 'package:new_quiz_app/utils/colors.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoginPage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.white,
        title: Text(
          isLoginPage ? "Login" : "Sign Up",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: isLoginPage
          ? LoginPage(onChanged: () {
              setState(() {
                isLoginPage = false;
              });
            })
          : SignUpPage(
              onChanged: () {
                setState(() {
                  isLoginPage = true;
                });
              },
            ),
      backgroundColor: AppColors.white,
    );
  }
}
