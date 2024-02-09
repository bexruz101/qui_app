import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_quiz_app/data/firebase/auth_service.dart';
import 'package:new_quiz_app/data/universal_data.dart';
import 'package:new_quiz_app/utils/ui_utils/error_message_dialog.dart';
import 'package:new_quiz_app/utils/ui_utils/loading_dialog.dart';
import 'package:provider/provider.dart';

class AuthProviderr with ChangeNotifier {
  AuthProviderr({required this.firebaseService});

  final AuthService firebaseService;
  final TextEditingController passworController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  loginButtonPressed() {
    passworController.clear();
    emailController.clear();
    userNameController.clear();
  }

  signUpButtonPressed() {
    passworController.clear();
    emailController.clear();
  }

  Future<void> signUpUser(BuildContext context) async {
    String email = emailController.text;
    String password = passworController.text;
    showLoading(context: context);
    UniversalData universalData =
        await firebaseService.signUpUser(email: email, password: password);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showConfirmMessage(message: 'User Signed Up', context: context);
      }
    } else {
      if (context.mounted) {
        showErrorMessage(message: universalData.error, context: context);
      }
    }
  }

  Stream<User?> listenAuthState() => FirebaseAuth.instance.authStateChanges();

  Future<void> logInUser(BuildContext context) async {
    String email = emailController.text;
    String password = passworController.text;
    showLoading(context: context);
    UniversalData universalData =
        await firebaseService.loginUser(email: email, password: password);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showConfirmMessage(message: 'User logged!', context: context);
      } else {
        if (context.mounted) {
          showErrorMessage(message: universalData.error, context: context);
        }
      }
    }
  }

  Future<void> logOutUser(BuildContext context) async {
    showLoading(context: context);
    context.read<AuthProviderr>().loginButtonPressed();
    UniversalData universalData = await firebaseService.logOutUser();
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showConfirmMessage(
            message: universalData.data as String, context: context);
      } else {
        if (context.mounted) {
          showErrorMessage(message: universalData.error, context: context);
        }
      }
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    showLoading(context: context);
    UniversalData universalData = await firebaseService.signInWithGoogle();
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showConfirmMessage(
            message: 'User Signed Up with Google', context: context);
      } else {
        if (context.mounted) {
          showErrorMessage(message: universalData.error, context: context);
        }
      }
    }
  }
}
