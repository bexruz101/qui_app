import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_quiz_app/models/answers_model.dart';
import '../universal_data.dart';

class QuestionService {
  Future<UniversalData> addQuestion(
      {required QuestionModel questionModel}) async {
    try {
      DocumentReference newQuestion = await FirebaseFirestore.instance
          .collection('questions')
          .add(questionModel.toMap());
      await FirebaseFirestore.instance
          .collection('questions')
          .doc(newQuestion.id)
          .update({
        'questionId': newQuestion.id,
      });
      return UniversalData(data: "Question added!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (e) {
      return UniversalData(error: e.toString());
    }
  }

  Future<UniversalData> updateQuestion(
      {required QuestionModel questionModel}) async {
    try {
      await FirebaseFirestore.instance
          .collection('questions')
          .doc(questionModel.questionId)
          .update(questionModel.toJson() as Map<Object, Object?>);
      return UniversalData(data: "Question updated!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (e) {
      return UniversalData(error: e.toString());
    }
  }

  Future<UniversalData> deleteQuestion({required String questionId}) async {
    try {
      await FirebaseFirestore.instance
          .collection('questions')
          .doc(questionId)
          .delete();
      return UniversalData(data: "Question deleted!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (e) {
      return UniversalData(error: e.toString());
    }
  }
}
