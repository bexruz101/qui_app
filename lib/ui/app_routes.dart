import 'package:flutter/material.dart';
import 'package:new_quiz_app/app/app.dart';
import 'package:new_quiz_app/models/answers_model.dart';
import 'package:new_quiz_app/ui/admin_panel/questions/questions_screen.dart';
import 'package:new_quiz_app/ui/admin_panel/questions/sub_screens/question_add_screen.dart';
import 'package:new_quiz_app/ui/admin_panel/questions/sub_screens/question_detail_screen.dart';
import 'package:new_quiz_app/ui/home/home_screen.dart';
import 'package:new_quiz_app/ui/onboarding/onboarding_screen.dart';
import 'package:new_quiz_app/ui/question_result/question_result_screen.dart';
import 'package:new_quiz_app/ui/questions/questions_screen.dart';
import 'package:new_quiz_app/ui/splash/splash_screen.dart';
import 'admin_panel/main/sub_screens/topic_add_screen.dart';
import 'desc/desc.dart';

class RouteNames {
  static const String splashScreen = '/';
  static const String homeScreen = '/home_screen';
  static const String onboardingScreen = '/onboarding_screen';
  static const String descScreen = '/desc';
  static const String app = '/app';
  static const String addTopicScreen = '/topic_add_screen';
  static const String adminQuestionScreen = '/question_screen';
  static const String adminQuestionAddScreen = '/question_add_screen';
  static const String adminQuestionDetail = '/question_detail_screen';
  static const String userQuestionScreen = '/questions_screen';
  static const String resultScreen = '/question_result_screen';
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RouteNames.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case RouteNames.onboardingScreen:
        return MaterialPageRoute(builder: (context) => const WelcomeScreen());
      case RouteNames.descScreen:
        return MaterialPageRoute(
            builder: (context) => DescScreen(
                  topicId: settings.arguments as Map<String, String?>,
                ));
      case RouteNames.app:
        return MaterialPageRoute(builder: (context) => const App());
      case RouteNames.addTopicScreen:
        return MaterialPageRoute(builder: (context) => const TopicAddScreen());
      case RouteNames.adminQuestionScreen:
        return MaterialPageRoute(
            builder: (context) => AdminQuestionScreen(
                  topicId: settings.arguments as Map<String, String>,
                ));
      case RouteNames.adminQuestionAddScreen:
        return MaterialPageRoute(
            builder: (context) => AdminQuestionAddScreen(
                topicId:
                    settings.arguments as Map<String, Map<String, String?>>));
      case RouteNames.adminQuestionDetail:
        return MaterialPageRoute(
            builder: (context) => AdminQuestionDetail(
                  questionModel:
                      settings.arguments as Map<String, QuestionModel>,
                ));
      case RouteNames.userQuestionScreen:
        return MaterialPageRoute(
            builder: (context) => UserQuestionsScreen(
              topicId: settings.arguments as Map<String, String?>, topicName: settings.arguments as Map<String,String?>,
            ));
      case RouteNames.resultScreen:
        return MaterialPageRoute(
            builder: (context) =>QuestionResult(topicId: settings.arguments as Map<String,String?>, spendTime: settings.arguments as Map<String,String?>, topicName: settings.arguments as Map<String,String?>,));
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text('Page Not Found'),
            ),
          );
        });
    }
  }
}
