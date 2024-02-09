import 'package:flutter/material.dart';
import 'package:new_quiz_app/ui/app_routes.dart';
import '../../utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _init() async {
    await Future.delayed(const Duration(seconds: 3));
    if(context.mounted){
      Navigator.pushReplacementNamed(context,RouteNames.app);
    }
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.C_004643,
      body: Center(
        child: CircleAvatar(
          backgroundColor: AppColors.white,
          radius: 70,
          child: Text(
            'Tests',
            style: TextStyle(color: AppColors.C_004643, fontSize: 28),
          ),
        ),
      ),
    );
  }
}
