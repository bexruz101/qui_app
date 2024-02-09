import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:new_quiz_app/data/local/storage_repo/storage_repo.dart';
import 'package:new_quiz_app/models/answers_model.dart';
import 'package:new_quiz_app/ui/app_routes.dart';
import 'package:new_quiz_app/ui/auth/widgets/global_button.dart';
import 'package:new_quiz_app/ui/questions/widgets/answer_detail.dart';
import 'package:new_quiz_app/ui/questions/widgets/my_dart.dart';
import 'package:new_quiz_app/utils/ui_utils/get_minute.dart';
import 'package:provider/provider.dart';
import '../../providers/questions_provider.dart';
import '../../utils/colors.dart';

class UserQuestionsScreen extends StatefulWidget {
  const UserQuestionsScreen(
      {super.key, required this.topicId, required this.topicName});

  final Map<String, String?> topicId;
  final Map<String, String?> topicName;

  @override
  State<UserQuestionsScreen> createState() => _UserQuestionsScreenState();
}

class _UserQuestionsScreenState extends State<UserQuestionsScreen> {
  int currentIndex = 0;
  String selectedAnswer = '';
  bool isSelected1 = false;
  bool isSelected2 = false;
  bool isSelected3 = false;
  bool isSelected4 = false;
  int numOfCorrAns = 0;
  List quests = [];

  int count = 0;
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
    _timerLogic();
    super.initState();
  }

  Future<void> _timerLogic() async {
    for (int i = 0; i < 300; i++) {
      await Future.delayed(const Duration(seconds: 1));
      count = i + 1;
      setState(() {});
    }

    if (selectedAnswer == quests[currentIndex].correctAnswer) {
      numOfCorrAns = StorageRepository.getInt('correctAnswer');
      numOfCorrAns += 1;
      StorageRepository.putInt('incorrectAnswer', quests.length - numOfCorrAns);
      StorageRepository.putInt('correctAnswer', numOfCorrAns);
    }
    if (numOfCorrAns == 0) {
      StorageRepository.putInt('incorrectAnswer', quests.length);
    }
    Navigator.pushReplacementNamed(context, RouteNames.resultScreen,
        arguments: {
          'topicId': widget.topicId['topicId'],
          "spendTime": count != 0 ? count.toString() : '100',
          "topicName": widget.topicName['topicName']
        });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Questions'),
          actions: [
            Text('${currentIndex + 1}/${quests.length}'),
            GlobalButton(
                title: 'Finish',
                onTap: () async {
                  if (selectedAnswer == quests[currentIndex].correctAnswer) {
                    numOfCorrAns = StorageRepository.getInt('correctAnswer');
                    numOfCorrAns += 1;
                    StorageRepository.putInt(
                        'incorrectAnswer', quests.length - numOfCorrAns);
                    StorageRepository.putInt('correctAnswer', numOfCorrAns);
                  }
                  if (numOfCorrAns == 0) {
                    StorageRepository.putInt('incorrectAnswer', quests.length);
                  }
                  Navigator.pushReplacementNamed(
                      context, RouteNames.resultScreen,
                      arguments: {
                        'topicId': widget.topicId['topicId'],
                        "spendTime": count != 0 ? count.toString() : '100',
                        "topicName": widget.topicName['topicName']
                      });
                }),
          ],
        ),
        body: StreamBuilder<List<QuestionModel>>(
          stream: context
              .read<QuestionsProvide>()
              .getQuestions(widget.topicId['topicId']!),
          builder: (BuildContext context,
              AsyncSnapshot<List<QuestionModel>> snapshot) {
            if (snapshot.hasData) {
              List<QuestionModel> allQuestions = snapshot.data!;
              quests = allQuestions;
              return snapshot.data!.isNotEmpty
                  ? Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 13,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: MyTimer(
                              rate: (1 - count / 300),
                              timeText: getMinutelyText(300 - count),
                            ),
                          ),
                          SizedBox(
                            height: 11,
                          ),
                          Container(
                            width: 320.w,
                            height: 180.h,
                            padding: EdgeInsets.symmetric(horizontal: 18.w),
                            margin: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(16.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.C_EEEFF2.withOpacity(0.6),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3),
                                  )
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 3,
                                ),
                                Math.tex(
                                  allQuestions[currentIndex].question,
                                  mathStyle: MathStyle.display,
                                ),
                              ],
                            ),
                          ),
                          AnswerDetail(
                              variantName: '1.',
                              answerTxt: allQuestions[currentIndex].answer1,
                              onTap: () {
                                selectedAnswer = allQuestions[currentIndex].answer1.toString();
                                setState(() {
                                  isSelected1 = true;
                                  isSelected2 = false;
                                  isSelected3 = false;
                                  isSelected4 = false;
                                });
                              },
                              isSelected: isSelected1),
                          const SizedBox(
                            height: 16,
                          ),
                          AnswerDetail(
                              variantName: '2.',
                              answerTxt: allQuestions[currentIndex].answer2,
                              onTap: () {
                                selectedAnswer = allQuestions[currentIndex].answer2;
                                setState(() {
                                  isSelected1 = false;
                                  isSelected2 = true;
                                  isSelected3 = false;
                                  isSelected4 = false;
                                });
                              },
                              isSelected: isSelected2),
                          const SizedBox(
                            height: 16,
                          ),
                          AnswerDetail(
                              variantName: '3.',
                              answerTxt: allQuestions[currentIndex].answer3,
                              onTap: () {
                                selectedAnswer =
                                    allQuestions[currentIndex].answer3;
                                setState(() {
                                  isSelected1 = false;
                                  isSelected2 = false;
                                  isSelected3 = true;
                                  isSelected4 = false;
                                });
                              },
                              isSelected: isSelected3),
                          const SizedBox(
                            height: 16,
                          ),
                          AnswerDetail(
                              variantName: '4.',
                              answerTxt: allQuestions[currentIndex].answer4,
                              onTap: ()async{
                                 selectedAnswer =  allQuestions[currentIndex].answer4;
                                setState(() {
                                  isSelected1 = false;
                                  isSelected2 = false;
                                  isSelected3 = false;
                                  isSelected4 = true;
                                });
                              },
                              isSelected: isSelected4),
                          const Spacer(),
                          GlobalButton(
                              title: 'Next',
                              onTap: () async {
                                print('all :${selectedAnswer}');
                                print(
                                    'corrr:${allQuestions[currentIndex].correctAnswer}');
                                if (currentIndex + 1 == allQuestions.length) {
                                  Navigator.pushReplacementNamed(
                                      context, RouteNames.resultScreen,
                                      arguments: {
                                        'topicId': widget.topicId['topicId'],
                                        "spendTime": count.toString(),
                                        "topicName":
                                            widget.topicName['topicName']
                                      });
                                }
                                isSelected1 = false;
                                isSelected2 = false;
                                isSelected3 = false;
                                isSelected4 = false;
                                if (selectedAnswer ==
                                    allQuestions[currentIndex].correctAnswer) {
                                  print('SAVEDDD');
                                  numOfCorrAns =
                                      StorageRepository.getInt('correctAnswer');
                                  numOfCorrAns += 1;
                                  StorageRepository.putInt('incorrectAnswer',
                                      allQuestions.length - numOfCorrAns);
                                  StorageRepository.putInt(
                                      'correctAnswer', numOfCorrAns);
                                }
                                if (numOfCorrAns == 0) {
                                  StorageRepository.putInt(
                                      'incorrectAnswer', allQuestions.length);
                                }
                                if (currentIndex >= 0 &&
                                    currentIndex < allQuestions.length - 1) {
                                  currentIndex += 1;
                                  setState(() {});
                                }
                              }),
                          SizedBox(
                            height: 48.h,
                          ),
                        ],
                      ),
                    )
                  : const Center(
                      child: Text('No Questions'),
                    );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
