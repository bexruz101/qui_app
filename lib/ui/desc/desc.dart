import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:new_quiz_app/models/topic_model.dart';
import 'package:new_quiz_app/providers/topic_provider.dart';
import 'package:new_quiz_app/ui/app_routes.dart';
import 'package:new_quiz_app/ui/auth/widgets/global_button.dart';
import 'package:new_quiz_app/utils/colors.dart';
import 'package:provider/provider.dart';
import '../../../data/local/storage_repo/storage_repo.dart';
import 'widgets/custom_container.dart';

class DescScreen extends StatefulWidget {
  const DescScreen({
    super.key,
    required this.topicId,
  });

  final Map<String, String?> topicId;

  @override
  State<DescScreen> createState() => _DescScreenState();
}

class _DescScreenState extends State<DescScreen> {
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
      backgroundColor: AppColors.C_ABD1C6,
      appBar: AppBar(
        backgroundColor: AppColors.C_ABD1C6,
        centerTitle: true,
        title: const Text('Description'),
      ),
      body: FutureBuilder<TopicModel>(
        future: context
            .read<TopicProvider>()
            .getTopicById(topicId: widget.topicId['topicId'].toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          } else {
            TopicModel topicModel = snapshot.data!;
            return Column(
              children: [
                Spacer(),
                Container(
                  height: 700,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60)),
                      color: AppColors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      CustomContainer(
                          height: 50, txt: topicModel.name.toUpperCase()),
                      const SizedBox(
                        height: 24,
                      ),
                      CustomContainer(height: 300, txt: topicModel.desc),
                      const Spacer(),
                      Container(
                          height: 40.h,
                          width: 120.w,
                          margin: EdgeInsets.symmetric(horizontal: 24),
                          padding: EdgeInsets.symmetric(
                              horizontal: 22, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            border: Border.all(color: AppColors.C_ABD1C6),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(
                            'Time: 5:00',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: AppColors.black),
                          )),
                      SizedBox(
                        height: 16.h,
                      ),
                      GlobalButton(
                        title: 'Start Test',
                        onTap: () async {
                          await StorageRepository.putInt('correctAnswer', 0);
                          await StorageRepository.putInt('incorrectAnswer', 0);
                          if (context.mounted) {
                            Navigator.pushReplacementNamed(
                                context, RouteNames.userQuestionScreen,
                                arguments: {
                                  'topicId': widget.topicId['topicId']!,
                                  "topicName":topicModel.name,
                                });
                          }
                        },
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                    ],
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
