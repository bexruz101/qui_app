import 'dart:convert';

class QuestionModel {
  final String topicId;
  final String questionId;
  final String question;
  final String answer1;
  final String answer2;
  final String answer3;
  final String answer4;
  final String correctAnswer;
  final String creadetAt;
  QuestionModel({
    required this.topicId,
    required this.questionId,
    required this.question,
    required this.answer1,
    required this.answer2,
    required this.answer3,
    required this.answer4,
    required this.correctAnswer,
    required this.creadetAt,
  });
 

  QuestionModel copyWith({
    String? topicId,
    String? questionId,
    String? question,
    String? answer1,
    String? answer2,
    String? answer3,
    String? answer4,
    String? correctAnswer,
    String? creadetAt,
  }) {
    return QuestionModel(
      topicId: topicId ?? this.topicId,
      questionId: questionId ?? this.questionId,
      question: question ?? this.question,
      answer1: answer1 ?? this.answer1,
      answer2: answer2 ?? this.answer2,
      answer3: answer3 ?? this.answer3,
      answer4: answer4 ?? this.answer4,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      creadetAt: creadetAt ?? this.creadetAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'topicId': topicId,
      'questionId': questionId,
      'question': question,
      'answer1': answer1,
      'answer2': answer2,
      'answer3': answer3,
      'answer4': answer4,
      'correctAnswer': correctAnswer,
      'creadetAt': creadetAt,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      topicId: map['topicId'] as String,
      questionId: map['questionId'] as String,
      question: map['question'] as String,
      answer1: map['answer1'] as String,
      answer2: map['answer2'] as String,
      answer3: map['answer3'] as String,
      answer4: map['answer4'] as String,
      correctAnswer: map['correctAnswer'] as String,
      creadetAt: map['creadetAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromJson(String source) => QuestionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QuestionModel(topicId: $topicId, questionId: $questionId, question: $question, answer1: $answer1, answer2: $answer2, answer3: $answer3, answer4: $answer4, correctAnswer: $correctAnswer, creadetAt: $creadetAt)';
  }

  @override
  bool operator ==(covariant QuestionModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.topicId == topicId &&
      other.questionId == questionId &&
      other.question == question &&
      other.answer1 == answer1 &&
      other.answer2 == answer2 &&
      other.answer3 == answer3 &&
      other.answer4 == answer4 &&
      other.correctAnswer == correctAnswer &&
      other.creadetAt == creadetAt;
  }

  @override
  int get hashCode {
    return topicId.hashCode ^
      questionId.hashCode ^
      question.hashCode ^
      answer1.hashCode ^
      answer2.hashCode ^
      answer3.hashCode ^
      answer4.hashCode ^
      correctAnswer.hashCode ^
      creadetAt.hashCode;
  }
}
