// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TopicModel {
  final String topicId;
  final String name;
  final String desc;
  final String createdAt;
  TopicModel({
    required this.topicId,
    required this.name,
    required this.desc,
    required this.createdAt,
  });

  TopicModel copyWith({
    String? topicId,
    String? name,
    String? desc,
    String? createdAt,
  }) {
    return TopicModel(
      topicId: topicId ?? this.topicId,
      name: name ?? this.name,
      desc: desc ?? this.desc,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'topicId': topicId,
      'name': name,
      'desc': desc,
      'createdAt': createdAt,
    };
  }

  factory TopicModel.fromMap(Map<String, dynamic> map) {
    return TopicModel(
      topicId: map['topicId'] as String,
      name: map['name'] as String,
      desc: map['desc'] as String,
      createdAt: map['createdAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TopicModel.fromJson(String source) => TopicModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TopicModel(topicId: $topicId, name: $name, desc: $desc, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant TopicModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.topicId == topicId &&
      other.name == name &&
      other.desc == desc &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return topicId.hashCode ^
      name.hashCode ^
      desc.hashCode ^
      createdAt.hashCode;
  }
}
