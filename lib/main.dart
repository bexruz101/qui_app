import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_quiz_app/data/firebase/auth_service.dart';
import 'package:new_quiz_app/data/firebase/profile_service.dart';
import 'package:new_quiz_app/data/firebase/question_service.dart';
import 'package:new_quiz_app/data/firebase/topics_service.dart';
import 'package:new_quiz_app/data/local/storage_repo/storage_repo.dart';
import 'package:new_quiz_app/providers/auth_provider.dart';
import 'package:new_quiz_app/providers/profile_provider.dart';
import 'package:new_quiz_app/providers/questions_provider.dart';
import 'package:new_quiz_app/providers/topic_provider.dart';
import 'package:new_quiz_app/ui/app_routes.dart';
import 'package:new_quiz_app/utils/colors.dart';
import 'package:new_quiz_app/utils/theme.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProviderr(firebaseService: AuthService()),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) =>
              ProfileProvider(profileService: ProfileService()),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => TopicProvider(topicsService: TopicsService()),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) =>
              QuestionsProvide(questionService: QuestionService()),
          lazy: false,
        ),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            color: AppColors.white,
            theme: AppTheme.lightTheme,
            themeMode: ThemeMode.light,
            darkTheme: AppTheme.darkTheme,
            debugShowCheckedModeBanner: false,
            initialRoute: RouteNames.splashScreen,
            onGenerateRoute: AppRoutes.generateRoute,
          );
        });
  }
}
