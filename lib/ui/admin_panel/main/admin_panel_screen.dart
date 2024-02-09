import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:new_quiz_app/models/topic_model.dart';
import 'package:new_quiz_app/providers/topic_provider.dart';
import 'package:new_quiz_app/ui/app_routes.dart';
import 'package:new_quiz_app/utils/colors.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
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
      drawer: Drawer(
        child: IconButton(
            onPressed: () {
              context.read<AuthProviderr>().logOutUser(context);
            },
            icon: const Icon(Icons.logout)),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Admin Panel'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.addTopicScreen);
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: StreamBuilder<List<TopicModel>>(
        stream: context.read<TopicProvider>().getTopics(),
        builder:
            (BuildContext context, AsyncSnapshot<List<TopicModel>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? ListView(
                    children: List.generate(snapshot.data!.length, (index) {
                      TopicModel topicModel = snapshot.data![index];
                      return ListTile(
                        title: Text(topicModel.name),
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouteNames.adminQuestionScreen,
                              arguments: {
                                "topicId": topicModel.topicId,
                              });
                        },
                        trailing: const Icon(Icons.arrow_forward_ios_outlined),
                      );
                    }),
                  )
                : const Center(
                    child: Text('Subject Empty'),
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
      ),
      backgroundColor: AppColors.white,
    );
  }
}
