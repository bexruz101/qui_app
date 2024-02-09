import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_quiz_app/data/local/storage_repo/storage_repo.dart';
import 'package:new_quiz_app/ui/app_routes.dart';
import 'package:new_quiz_app/utils/colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.C_004643,
      appBar: AppBar(
        backgroundColor: AppColors.C_004643,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 80.h,
            ),
            Text(
              'Welcome to Test',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: AppColors.C_EEEFF2),
            ),
            SizedBox(
              height: 120.h,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 35),
              child: TextField(
                cursorColor: AppColors.C_EEEFF2,
                style: TextStyle(color: AppColors.C_EEEFF2),
                controller: controller,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    labelText: 'Enter your name',
                    labelStyle: TextStyle(color: AppColors.C_EEEFF2),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.C_EEEFF2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.C_EEEFF2),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.C_EEEFF2),
                    )),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(
                onPressed: () {
                  if (controller.text.isNotEmpty){
                    StorageRepository.putString('username', controller.text);
                    Navigator.pushReplacementNamed(
                        context, RouteNames.homeScreen);
                  }else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill the field')));
                  }
                },
                child: const Text('Start')),
          ],
        ),
      ),
    );
  }
}
