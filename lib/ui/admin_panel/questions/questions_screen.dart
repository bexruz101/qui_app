import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:new_quiz_app/models/answers_model.dart';
import 'package:new_quiz_app/providers/questions_provider.dart';
import 'package:provider/provider.dart';
import '../../../utils/colors.dart';
import '../../app_routes.dart';

class AdminQuestionScreen extends StatefulWidget {
  const AdminQuestionScreen({super.key, required this.topicId});

  final Map<String,String?> topicId;

  @override
  State<AdminQuestionScreen> createState() => _AdminQuestionScreenState();
}

class _AdminQuestionScreenState extends State<AdminQuestionScreen> {
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
        title:const Text('Questions'),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context,RouteNames.adminQuestionAddScreen,arguments:{
              "topicId":widget.topicId,
            });
          }, icon: const Icon(Icons.add)),
        ],
      ),
      body: StreamBuilder<List<QuestionModel>>(
        stream: context.read<QuestionsProvide>().getQuestions(widget.topicId['topicId'].toString()),
        builder: (BuildContext context,AsyncSnapshot<List<QuestionModel>> snapshot){
          if(snapshot.hasData){
            return snapshot.data!.isNotEmpty ? ListView(children: List.generate(snapshot.data!.length, (index) {
              QuestionModel questionModel = snapshot.data![index];
              return ListTile(
                title: Text(questionModel.question),
                onTap: (){
                    Navigator.pushNamed(context, RouteNames.adminQuestionDetail,arguments: {
                      "questionModel":questionModel,
                    });
                },
                trailing:const Icon(Icons.arrow_forward_ios_outlined),
              );
            }),):const Center(child: Text('Questions Empty'),);
          }
          if(snapshot.hasError){
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return const Center(child: CircularProgressIndicator(),);
        },
      ),
      backgroundColor: AppColors.white,
    );
  }
}
