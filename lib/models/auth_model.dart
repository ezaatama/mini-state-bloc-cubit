import 'dart:convert';

AuthLogin authLoginFromJson(String str) => AuthLogin.fromJson(json.decode(str));

String authLoginToJson(AuthLogin data) => json.encode(data.toJson());

class AuthLogin{
  final String? username;
  final String? password;
  final String? token;

  AuthLogin({
    this.username,
    this.password,
    this.token
  });

  factory AuthLogin.fromJson(Map<String, dynamic> json) => AuthLogin(
    username: json["username"],
    password: json["password"],
    token: json["accces_token"]
  );

  Map<String, dynamic> toJson() =>{
    "username": username,
    "password": password,
    "acces_token": token
  };
}