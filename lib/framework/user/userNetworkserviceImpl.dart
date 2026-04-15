import 'package:billeterie_electronique/business/model/user/authentification.dart';
import 'package:billeterie_electronique/business/model/user/userModel.dart';
import 'package:billeterie_electronique/business/services/user/userNetworkservice.dart';

class Usernetworkserviceimpl implements UserNetworkService {
  @override
  Future<Usermodel?> signIn(Authentification auth) {
    // TODO: Implement sign-in logic
    throw UnimplementedError();
  }

  @override
  Future<Usermodel> signUp(Usermodel user) {
    // TODO: Implement sign-up logic
    throw UnimplementedError();
  }
}