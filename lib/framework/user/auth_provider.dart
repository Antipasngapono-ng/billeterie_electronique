import 'package:flutter/material.dart';
import 'package:billeterie_electronique/business/model/user/authentification.dart';
import 'package:billeterie_electronique/business/model/user/userModel.dart';
import 'package:billeterie_electronique/framework/user/authentificationServiceImp.dart';

class AuthProvider with ChangeNotifier {
  final AuthentificationServiceImpl _authService = AuthentificationServiceImpl();

  Usermodel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  Usermodel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;

  AuthProvider() {
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    _isLoading = true;
    notifyListeners();

    try {
      final isLoggedIn = await _authService.isLoggedIn();
      if (isLoggedIn) {
        _currentUser = await _authService.getCurrentUser();
      }
    } catch (e) {
      _errorMessage = 'Erreur lors de l\'initialisation: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final auth = Authentification(email: email, password: password);
      final user = await _authService.signIn(auth);

      if (user != null) {
        _currentUser = user;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Email ou mot de passe incorrect';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Erreur de connexion: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUp(String name, String email, String password, String phoneNumber) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final user = Usermodel(
        name: name,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
      );

      final result = await _authService.signUp(user);

      if (result != null) {
        _currentUser = result;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Erreur lors de l\'inscription';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Erreur d\'inscription: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.logout();
      _currentUser = null;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Erreur lors de la déconnexion: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}