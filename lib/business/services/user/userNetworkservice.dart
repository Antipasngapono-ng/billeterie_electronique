import 'package:billeterie_electronique/business/model/user/userModel.dart';
import '../../model/user/authentification.dart';

abstract class UserNetworkService {
  
  Future<Usermodel?> signIn(Authentification auth);
  Future<Usermodel?> signUp(Usermodel user);
}