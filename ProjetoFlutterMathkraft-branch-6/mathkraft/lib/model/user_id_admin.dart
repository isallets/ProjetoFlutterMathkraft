import 'dart:convert';

class UserIdAdmin {
  final int? id;

  UserIdAdmin({this.id});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id
    };
  }

  factory UserIdAdmin.fromMap(Map<String, dynamic> map) {
    return UserIdAdmin(
      id: map['id']
    );
  }

  String toJson() => json.encode(toMap());

  factory UserIdAdmin.fromJson(String source) => 
      UserIdAdmin.fromMap(json.decode(source) as Map<String, dynamic>);
}