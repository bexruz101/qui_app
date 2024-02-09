import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_quiz_app/data/firebase/topics_service.dart';
import 'package:new_quiz_app/data/universal_data.dart';
import 'package:new_quiz_app/models/topic_model.dart';
import 'package:new_quiz_app/utils/ui_utils/loading_dialog.dart';

class TopicProvider with ChangeNotifier {
  TopicProvider({required this.topicsService});

  final TopicsService topicsService;

  TextEditingController topicNameController = TextEditingController();
  TextEditingController topicDescController = TextEditingController();

  Future<void> addTopic({required BuildContext context}) async {
    String name = topicNameController.text;
    String desc = topicDescController.text;

    if (name.isNotEmpty && desc.isNotEmpty) {
      TopicModel topicModel = TopicModel(
          topicId: "",
          name: name,
          desc: desc,
          createdAt: DateTime.now().toString());
      showLoading(context: context);
      UniversalData universalData =
          await topicsService.addTopic(topicModel: topicModel);
      if (context.mounted) {
        hideLoading(dialogContext: context);
      }
      if (universalData.error.isEmpty) {
        if (context.mounted) {
          showMessage(context, universalData.data as String);
          clearTexts();
          Navigator.pop(context);
        } else {
          if (context.mounted) {
            showMessage(context, universalData.error);
          }
        }
      } else {
        showMessage(context,"Maydonlar to'liq emas!!!");
      }
    }
  }

  Future<void> updateTopic(
      {required BuildContext context, required TopicModel currentTopic}) async {
    String name = topicNameController.text;
    String desc = topicDescController.text;
    if (name.isNotEmpty && desc.isNotEmpty) {
      showLoading(context: context);
      UniversalData universalData = await topicsService.updateTopic(
          topicModel: TopicModel(
              topicId: currentTopic.topicId,
              name: name,
              desc: desc,
              createdAt: currentTopic.createdAt));
      if (context.mounted) {
        hideLoading(dialogContext: context);
      }
      if (universalData.error.isEmpty) {
        if (context.mounted) {
          showMessage(context, universalData.data as String);
          clearTexts();
          Navigator.pop(context);
        }
      } else {
        if (context.mounted) {
          showMessage(context, universalData.error);
        }
      }
    }
  }

  Future<void> deleteTopic(
      {required BuildContext context, required String topicId}) async {
    showLoading(context: context);
    UniversalData universalData =
        await topicsService.deleteTopic(topicId: topicId);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
        clearTexts();
        Navigator.pop(context);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  showMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    notifyListeners();
  }

  Stream<List<TopicModel>> getTopics() =>
      FirebaseFirestore.instance.collection('topics').snapshots().map(
            (event) => event.docs
                .map((e) => TopicModel.fromMap(e.data()))
                .toList(),
          );


  Future<TopicModel> getTopicById({required String topicId}) async {
    var snapshot = await FirebaseFirestore.instance
        .collection('topics')
        .where('topicId', isEqualTo: topicId)
        .get();
    if (snapshot.docs.isNotEmpty){
      return TopicModel.fromMap(snapshot.docs.first.data() as Map<String, dynamic>);
    } else {
      // Handle the case where no matching document is found.
      throw Exception('No matching document found for topicId: $topicId');
    }
  }



  setInitialValues(TopicModel topicModel) {
    topicNameController = TextEditingController(text: topicModel.name);
    topicDescController = TextEditingController(text: topicModel.desc);
    notifyListeners();
  }

  clearTexts() {
    topicNameController.clear();
    topicDescController.clear();
  }
}
