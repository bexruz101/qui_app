import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_quiz_app/data/firebase/profile_service.dart';
import 'package:new_quiz_app/data/universal_data.dart';
import 'package:new_quiz_app/utils/ui_utils/loading_dialog.dart';

class ProfileProvider with ChangeNotifier{

  ProfileProvider({required this.profileService});

  final ProfileService profileService;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  User? currentUser;

  showMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    notifyListeners();
  }

  listenUserChanges(){
    FirebaseAuth.instance.userChanges().listen((User? user) {
      currentUser = user;
    });
  }

  Future<void> updateUsername(BuildContext context)async{
    String name = nameController.text;
    
    showLoading(context: context);
    UniversalData universalData = await profileService.updateUserName(username: name);
    if(context.mounted){
      hideLoading(dialogContext: context);
    }
    if(universalData.error.isEmpty){
      if(context.mounted){
        showMessage(context, universalData.data as String);
      }
    }else{
      if(context.mounted){
        showMessage(context, universalData.error);
      }
    }
  }

  Future<void> updateEmail(BuildContext context)async{
    String email = emailController.text;

    showLoading(context: context);
    UniversalData universalData = await profileService.updateUserEmail(email: email);
    if(context.mounted){
      hideLoading(dialogContext: context);
    }
    if(universalData.error.isEmpty){
      if(context.mounted){
        showMessage(context, universalData.data as String);
      }
    }else{
      if(context.mounted){
        showMessage(context, universalData.error);
      }
    }
  }


}