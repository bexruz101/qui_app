import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_quiz_app/providers/auth_provider.dart';
import 'package:new_quiz_app/ui/admin_panel/main/admin_panel_screen.dart';
import 'package:new_quiz_app/ui/home/home_screen.dart';
import 'package:provider/provider.dart';
import '../ui/auth/auth_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: context.read<AuthProviderr>().listenAuthState(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()),);
          }else if(snapshot.data == null){
            return AuthScreen();
          }else{
            return snapshot.data!.email == 'admin@gmail.com' ? AdminPanelScreen():HomeScreen();
          }
        },
      ),
    );
  }
}
