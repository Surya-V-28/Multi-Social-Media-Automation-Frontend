import 'package:business_logic/src/access_token_repository/access_token_repository.dart';
import 'package:backend_api_client/backend_api_client.dart';
import 'package:business_logic/src/user_repository.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class InitializeLoggedInUserInteractor {
  const InitializeLoggedInUserInteractor(
    this._backendClient,
    this._accessTokenRepository,
    this._userRepository,
  );

  Future<void> perform() async {
    final accessToken = await _accessTokenRepository.getToken();
    if (accessToken == null) {
      return;
    }

    if (isAccessTokenExpired(accessToken)) {
      await _accessTokenRepository.remove();
      return;
    }

    final user = await _backendClient.authClient.me(accessToken);
    await _userRepository.setUser(user);
  }

  bool isAccessTokenExpired(String accessToken) {
    var jwt = JWT.decode(accessToken);
    var expiryDate = DateTime.fromMillisecondsSinceEpoch(jwt.payload['exp'] * 1000);

    return expiryDate.isBefore(DateTime.now());
  }

  final BackendClient _backendClient;
  final AccessTokenRepository _accessTokenRepository;
  final UserRepository _userRepository;
}
