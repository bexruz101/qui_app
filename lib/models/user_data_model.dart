import 'dart:convert';

class UserData {
  final String id;
  final String updatedAt;
  final String name;
  final String email;
  UserData({
    required this.id,
    required this.updatedAt,
    required this.name,
    required this.email,
  });
  

  UserData copyWith({
    String? id,
    String? updatedAt,
    String? name,
    String? email,
  }) {
    return UserData(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'updatedAt': updatedAt,
      'name': name,
      'email': email,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'] as String,
      updatedAt: map['updatedAt'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) => UserData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserData(id: $id, updatedAt: $updatedAt, name: $name, email: $email)';
  }

  @override
  bool operator ==(covariant UserData other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.updatedAt == updatedAt &&
      other.name == name &&
      other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      updatedAt.hashCode ^
      name.hashCode ^
      email.hashCode;
  }
}
