import 'package:business_logic/src/user_repository.dart';
import 'package:injectable/injectable.dart';

import 'package:business_logic/src/access_token_repository/access_token_repository.dart';
import 'package:backend_api_client/backend_api_client.dart';

@singleton
class EmailPasswordLoginInteractor {
  const EmailPasswordLoginInteractor(
    this._accessTokenRepository,
    this._userRepository,
    this._backendClient
  );

  Future<void> perform({String? email, String? username, required String password}) async {
    final accessToken = await _backendClient.authClient.login(email: email, username: username, password: password);
    final user = await _backendClient.authClient.me(accessToken);

    await _accessTokenRepository.save(accessToken);
    await _userRepository.setUser(user);
  }


  final AccessTokenRepository _accessTokenRepository;
  final UserRepository _userRepository;
  final BackendClient _backendClient;
}