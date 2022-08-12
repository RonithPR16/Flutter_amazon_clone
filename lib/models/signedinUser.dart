import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SignInUser {
  final String username;
  final String password;
  SignInUser({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
    };
  }

  factory SignInUser.fromMap(Map<String, dynamic> map) {
    return SignInUser(
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignInUser.fromJson(String source) =>
      SignInUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
