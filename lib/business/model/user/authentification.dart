import 'dart:convert';

class Authentification {
  final String email;
  final String password;

  Authentification({
    required this.email,
    required this.password,
  });


  factory Authentification.fromRawJson(String str) =>
      Authentification.fromJson(json.decode(str));
      
      String toRawJson() => json.encode(toJson());

  factory Authentification.fromJson(Map<String, dynamic> json) =>
      Authentification(
        email: json['email'] as String,
        password: json['password'] as String,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };    

}
