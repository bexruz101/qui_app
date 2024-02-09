import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:new_quiz_app/data/local/storage_repo/storage_repo.dart';
import 'package:new_quiz_app/ui/app_routes.dart';
import 'package:new_quiz_app/ui/home/widgets/drawer.dart';
import 'package:new_quiz_app/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../models/topic_model.dart';
import '../../providers/topic_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;
  String username = StorageRepository.getString('username');


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
      drawer: DrawerWid(),
      appBar: AppBar(
        title: const Text('Topics'),
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
                      return ZoomTapAnimation(
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.descScreen,
                              arguments: {
                                "topicId": topicModel.topicId.toString(),
                              });
                        },
                        child: Container(
                          height: 90,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              border:  Border.all(color: AppColors.C_ABD1C6),
                              borderRadius: const BorderRadius.all(Radius.circular(18))),
                          child: Row(
                            children: [
                              Text(topicModel.name, style: Theme.of(context).textTheme.headlineSmall!
                                  .copyWith(fontWeight: FontWeight.w600,color: AppColors.C_004643),
                              ),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return Text('Something Error');
        },
      ),
    );
  }
}
