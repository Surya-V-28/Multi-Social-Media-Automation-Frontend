import 'package:backend_api_client/backend_api_client.dart';

class UserRepository {
  UserRepository();

  Future<User?> getUser() async {
    return _user;
  }

  Future<void> setUser(final User user) async {
    _user = user;
  }

  Future<void> removeUser() async {
    _user = null;
  }



  User? _user;
}