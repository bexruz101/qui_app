import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:new_quiz_app/data/local/storage_repo/storage_repo.dart';
import 'package:new_quiz_app/ui/app_routes.dart';
import 'package:new_quiz_app/ui/auth/widgets/global_button.dart';
import 'package:new_quiz_app/ui/question_result/widgets/result_container.dart';
import 'package:new_quiz_app/ui/question_result/widgets/test_result_view.dart';
import 'package:new_quiz_app/utils/colors.dart';

class QuestionResult extends StatefulWidget {
  const QuestionResult({super.key, required this.topicId, required this.spendTime, required this.topicName,});

  final Map<String, String?> topicId;
  final Map<String,String?> spendTime;
  final Map<String,String?> topicName;

  @override
  State<QuestionResult> createState() => _QuestionResultState();
}

class _QuestionResultState extends State<QuestionResult> {
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
    print('SPEEEND TIMEE:${widget.spendTime}');
    double time = double.parse(widget.spendTime['spendTime']!);
    int corrAns = StorageRepository.getInt('correctAnswer');
    int incAns = StorageRepository.getInt('incorrectAnswer');
    int timeMin = time<60?(time~/60):0;
    print('CORR ANS:${corrAns}');
    double timeSec = time<60?(time%60):time;
    double avrgTime = (time)/(corrAns+incAns);
    int avrgTimeMin = avrgTime ~/ 60;
    double avrgTimeSec = avrgTime % 60;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Result"),
      ),
      body: Column(
          children: [
            Container(
              width: 350.w,
              height: 60.h,
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              decoration: BoxDecoration(color: AppColors.C_ABD1C6,borderRadius: BorderRadius.circular(20)),
                child: Text(widget.topicName['topicName'] ?? "No name"),
            ),
            SizedBox(height: 20.h,),
            TestResultView(totalQuestionCount: corrAns+incAns, trueAnswerCount: corrAns),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RectangleCont(
                    count: corrAns,
                    color: Colors.greenAccent,
                    txt: 'Correct\nAnswers: ${corrAns}'),
                RectangleCont(
                    count: incAns,
                    color: Colors.redAccent,
                    txt: 'Incorrect\nAnswers:${incAns}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RectangleCont(
                    count: corrAns,
                    color: Colors.blueAccent,
                    txt: 'Time:\n${timeMin.toInt()} min ${timeSec.toInt()}sec'),
                RectangleCont(
                    count: 1,
                    color: Colors.amberAccent,
                    txt: 'Average time for\n1 question:\n${avrgTimeMin.toInt()}min ${avrgTimeSec.toInt()}sec'),
              ],
            ),
             SizedBox(height:64.h,),
            GlobalButton(
                title: 'Try Again',
                onTap: () {
                  Navigator.pushReplacementNamed(context, RouteNames.descScreen,
                      arguments: {
                        "topicId": widget.topicId['topicId'],
                      });
                }),
             SizedBox(
              height: 48.h,
            ),
          ]),
    );
  }
}
