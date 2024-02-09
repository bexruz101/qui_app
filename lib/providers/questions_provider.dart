import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:math_keyboard/math_keyboard.dart';
import 'package:new_quiz_app/data/firebase/question_service.dart';
import 'package:new_quiz_app/data/universal_data.dart';
import 'package:new_quiz_app/models/answers_model.dart';
import 'package:new_quiz_app/utils/ui_utils/loading_dialog.dart';

class QuestionsProvide with ChangeNotifier {
  QuestionsProvide({required this.questionService});

  final QuestionService questionService;

  MathFieldEditingController questionNameController = MathFieldEditingController();
  MathFieldEditingController answer1NameController = MathFieldEditingController();
  MathFieldEditingController answer2NameController = MathFieldEditingController();
  MathFieldEditingController answer3NameController = MathFieldEditingController();
  MathFieldEditingController answer4NameController = MathFieldEditingController();
  MathFieldEditingController correctAnswerNameController = MathFieldEditingController();

  Future<void> addQuestion(
      {required BuildContext context, required String topicId}) async {
    String question = questionNameController.currentEditingValue();
    String answer1 = answer1NameController.currentEditingValue();
    String answer2 = answer2NameController.currentEditingValue();
    String answer3 = answer3NameController.currentEditingValue();
    String answer4 = answer4NameController.currentEditingValue();
    String correctAnswer = correctAnswerNameController.currentEditingValue();

    if (question.isNotEmpty &&
        answer1.isNotEmpty &&
        answer2.isNotEmpty &&
        answer3.isNotEmpty &&
        answer4.isNotEmpty &&
        correctAnswer.isNotEmpty) {
      QuestionModel questionModel = QuestionModel(
          topicId: topicId,
          questionId: "",
          question: question,
          answer1: answer1,
          answer2: answer2,
          answer3: answer3,
          answer4: answer4,
          correctAnswer: correctAnswer,
          creadetAt: DateTime.now().toString());
      showLoading(context: context);
      UniversalData universalData =
          await questionService.addQuestion(questionModel: questionModel);
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
    } else {
      showMessage(context, "Maydonlar to'liq emas!!!");
    }
  }

  Future<void> updateQuestion(
      {required BuildContext context,
      required QuestionModel questionModel}) async {
    String question = questionNameController.toString();
    String answer1 = answer1NameController.toString();
    String answer2 = answer2NameController.toString();
    String answer3 = answer3NameController.toString();
    String answer4 = answer4NameController.toString();
    String correctAnswer = correctAnswerNameController.toString();
    if (question.isNotEmpty &&
        answer1.isNotEmpty &&
        answer2.isNotEmpty &&
        answer3.isNotEmpty &&
        answer4.isNotEmpty &&
        correctAnswer.isNotEmpty) {
      showLoading(context: context);
      UniversalData universalData =
          await questionService.updateQuestion(questionModel: questionModel);

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

  Future<void> deleteQuestion(
      {required BuildContext context, required String questionId}) async {
    showLoading(context: context);
    UniversalData universalData =
        await questionService.deleteQuestion(questionId: questionId);
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

  Stream<List<QuestionModel>> getQuestions(String topicId) async* {
    if (topicId.isEmpty) {
      yield* FirebaseFirestore.instance.collection('questions').snapshots().map((event) =>event.docs.map((e) => QuestionModel.fromMap(e.data())).toList());
    } else {
      yield* FirebaseFirestore.instance
          .collection('questions')
          .where('topicId', isEqualTo: topicId)
          .snapshots()
          .map(
            (event) =>
                event.docs.map((e) => QuestionModel.fromMap(e.data())).toList(),
          );
    }
  }

  setInitialValues(QuestionModel questionModel) {
    questionNameController = convertMathExpressionToTeXNode(questionModel.question as Expression) as MathFieldEditingController;
    answer1NameController = convertMathExpressionToTeXNode(questionModel.answer1  as Expression) as MathFieldEditingController ;
    answer2NameController =  convertMathExpressionToTeXNode(questionModel.answer2  as Expression) as MathFieldEditingController;
    answer3NameController =  convertMathExpressionToTeXNode(questionModel.answer3 as Expression) as MathFieldEditingController ;
    answer4NameController =  convertMathExpressionToTeXNode(questionModel.answer4 as Expression) as MathFieldEditingController ;
    correctAnswerNameController =
    convertMathExpressionToTeXNode(questionModel.correctAnswer as Expression) as MathFieldEditingController ;
    notifyListeners();
  }

  clearTexts() {
    questionNameController.clear();
    answer1NameController.clear();
    answer2NameController.clear();
    answer3NameController.clear();
    answer4NameController.clear();
    correctAnswerNameController.clear();
  }
}
