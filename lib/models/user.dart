import 'package:flutter/cupertino.dart';

class User {
  final String id;
  final String username;
  final String jwt;
  final String email;

  User({
    @required this.email,
    @required this.id,
    @required this.username,
    @required this.jwt,
  });

  factory User.fromJson(Map json) {
    return User(
        email: json['email'],
        id: json['id'],
        username: json['username'],
        jwt: json['jwt']);
  }
}
