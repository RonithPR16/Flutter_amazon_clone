// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String username;
  final String fullname;
  final String email;
  final String password;
  final String id;
  final String token;

  User({
    required this.username,
    required this.fullname,
    required this.email,
    required this.password,
    required this.id,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'fullname': fullname,
      'email': email,
      'password': password,
      'id': id,
      'token': token
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'] as String,
      fullname: map['fullname'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      id: map['_id'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
