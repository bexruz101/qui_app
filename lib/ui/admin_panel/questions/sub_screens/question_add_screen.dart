import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:new_quiz_app/models/answers_model.dart';
import 'package:new_quiz_app/providers/questions_provider.dart';
import 'package:new_quiz_app/ui/admin_panel/widgets/math_keyboard.dart';
import 'package:provider/provider.dart';
import '../../../auth/widgets/global_button.dart';

class AdminQuestionAddScreen extends StatefulWidget {
  const AdminQuestionAddScreen(
      {super.key, this.questionModel, required this.topicId});

  final QuestionModel? questionModel;
  final Map<String, Map<String, String?>> topicId;

  @override
  State<AdminQuestionAddScreen> createState() => _AdminQuestionAddScreenState();
}

class _AdminQuestionAddScreenState extends State<AdminQuestionAddScreen> {
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
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
  @override
  void initState() {
    getConnectivity();
    if (widget.questionModel != null) {
      context.read<QuestionsProvide>().setInitialValues(widget.questionModel!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.questionModel == null ? "Question Add" : "Question Update"),
        leading: IconButton(
          onPressed: () {
            Provider.of<QuestionsProvide>(context, listen: false).clearTexts();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                MathKeyboard(
                  hintText: 'Question',
                  controller: context
                      .read<QuestionsProvide>()
                      .questionNameController,
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                    height: 100,
                    child: MathKeyboard(
                      hintText: 'Answer1',
                      controller: context
                          .read<QuestionsProvide>()
                          .answer1NameController,
                    )),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: 100,
                  child:  MathKeyboard(
                    hintText: 'Answer2',
                    controller: context
                        .read<QuestionsProvide>()
                        .answer2NameController,
                  )
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: 100,
                  child:  MathKeyboard(
                    hintText: 'Answer3',
                    controller: context
                        .read<QuestionsProvide>()
                        .answer3NameController,
                  )
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: 100,
                  child:  MathKeyboard(
                    hintText: 'Answer4',
                    controller: context
                        .read<QuestionsProvide>()
                        .answer4NameController,
                  )
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: 100,
                  child:  MathKeyboard(
                    hintText: 'Correct Answer',
                    controller: context
                        .read<QuestionsProvide>()
                        .correctAnswerNameController,
                  )
                ),
                const SizedBox(
                  height: 24,
                ),
                GlobalButton(
                    title: widget.questionModel == null
                        ? "Add Questions"
                        : "Update Questions",
                    onTap: () {
                      if (widget.questionModel == null) {
                        context.read<QuestionsProvide>().addQuestion(
                            context: context,
                            topicId: widget.topicId['topicId']!['topicId']
                                .toString());
                      } else {
                        context.read<QuestionsProvide>().updateQuestion(
                            context: context,
                            questionModel: widget.questionModel!);
                      }
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
