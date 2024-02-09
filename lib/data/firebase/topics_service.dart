import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_quiz_app/models/topic_model.dart';
import '../universal_data.dart';

class TopicsService {
  Future<UniversalData> addTopic({required TopicModel topicModel}) async {
    try {
      DocumentReference newTopic = await FirebaseFirestore.instance
          .collection('topics')
          .add(topicModel.toMap());
      await FirebaseFirestore.instance
          .collection('topics')
          .doc(newTopic.id)
          .update({"topicId": newTopic.id});
      return UniversalData(data: "Topic added!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> updateTopic({required TopicModel topicModel}) async {
    try {
      await FirebaseFirestore.instance
          .collection('topics')
          .doc(topicModel.topicId)
          .update({"topicId": topicModel.topicId});
      return UniversalData(data: "Topic updated!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }
  Future<UniversalData> deleteTopic({required String topicId}) async {
    try {
      await FirebaseFirestore.instance
          .collection('topics')
          .doc(topicId)
          .delete();
      return UniversalData(data: "Topic deleted!");
    } on FirebaseException catch (e) {
      return UniversalData(error:e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }
}
