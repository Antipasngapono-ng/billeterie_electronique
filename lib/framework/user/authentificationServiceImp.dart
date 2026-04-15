import 'dart:convert';

import 'package:billeterie_electronique/business/model/user/authentification.dart';
import 'package:billeterie_electronique/business/model/user/userModel.dart';
import 'package:billeterie_electronique/business/services/user/authentificationService.dart';
import 'package:http/http.dart' as http;

class AuthentificationServiceImpl implements AuthentificationService {
  final String baseUrl = 'https://127.0.0.1:8080/api';
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';

  // Singleton pattern
  static final AuthentificationServiceImpl _instance = AuthentificationServiceImpl._internal();
  factory AuthentificationServiceImpl() => _instance;
  AuthentificationServiceImpl._internal();

  // Cache simple en mémoire
  static String? _cachedToken;
  static Usermodel? _cachedUser;
  @override
  Future<Usermodel?> signIn(Authentification auth) async {
     try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': auth.email, 'password': auth.password}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final user = Usermodel.fromJson(data['user'] ?? data);
        final token = data['token'] as String?;

        if (token != null) {
          await _saveToken(token);
          await _saveUser(user);
        }

        return user;
      }
      return null;
    } catch (e) {
      print('Erreur login: $e');
      return null;
    }
  }

  @override
  Future<Usermodel?> signUp(Usermodel user) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': user.name,
          'email': user.email,
          'password': user.password,
          'phoneNumber': user.phoneNumber,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return Usermodel.fromJson(json.decode(response.body));
      }
      return null;
    } catch (e) {
      print('Erreur signup: $e');
      return null;
    }
  }

  // Méthodes de gestion des tokens et utilisateur
  Future<void> _saveToken(String token) async {
    _cachedToken = token;
  }

  Future<void> _saveUser(Usermodel user) async {
    _cachedUser = user;
  }

  Future<String?> getToken() async {
    return _cachedToken;
  }

  Future<Usermodel?> getCurrentUser() async {
    return _cachedUser;
  }

  Future<bool> isLoggedIn() async {
    return _cachedToken != null && _cachedToken!.isNotEmpty;
  }

  Future<void> logout() async {
    _cachedToken = null;
    _cachedUser = null;
  }
}

