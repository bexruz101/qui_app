import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:new_quiz_app/models/answers_model.dart';

class AdminQuestionDetail extends StatefulWidget {
  const AdminQuestionDetail({super.key, required this.questionModel});

  final Map<String,QuestionModel> questionModel;

  @override
  State<AdminQuestionDetail> createState() => _AdminQuestionDetailState();
}

class _AdminQuestionDetailState extends State<AdminQuestionDetail> {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  getConnectivity() =>subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result)async{
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    if(!isDeviceConnected && isAlertSet == false){
      showDialogBox();
      setState(()=>isAlertSet = true);
    }
  });

  showDialogBox()=>showCupertinoDialog(context: context, builder: (BuildContext context)=>CupertinoAlertDialog(
    title: const Text('No Connection'),
    content: const Text('Please check your internet connectivity'),
    actions: [
      TextButton(onPressed: ()async{
        Navigator.pop(context,'Cancel');
        setState(()=> isAlertSet = false);
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if(!isDeviceConnected){
          showDialogBox();
          setState(()=> isAlertSet = true);

        }
      }, child: const Text('OK')),
    ],
  ));

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:const Text('Question Detail'),
      ),
      body: ListView(
        children: [
          Text("Question: ${widget.questionModel['questionModel']?.question}"),
          const SizedBox(height: 20,),
          Text("Answer1: ${widget.questionModel['questionModel']?.answer1}"),
          const SizedBox(height: 20,),
          Text("Answer1: ${widget.questionModel['questionModel']?.answer2}"),
          const SizedBox(height: 20,),
          Text("Answer1: ${widget.questionModel['questionModel']?.answer3}"),
          const SizedBox(height: 20,),
          Text("Answer1: ${widget.questionModel['questionModel']?.answer4}"),
          const SizedBox(height: 20,),
          Text("CorrectAnswer: ${widget.questionModel['questionModel']?.correctAnswer}"),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}
