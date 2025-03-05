import 'package:business_logic/src/access_token_repository/access_token_repository.dart';
import 'package:backend_api_client/backend_api_client.dart';
import 'package:business_logic/src/user_repository.dart';

class ConnectToPlatformInteractor {
  const ConnectToPlatformInteractor(this._backendClient, this._userRepository, this._accessTokenRepository);

  Future<void> add(SocialMediaPlatform platform, String accessToken, String refreshToken, DateTime expiresAt) async {
    final backendAccessToken = (await _accessTokenRepository.getToken())!;
    final user = (await _userRepository.getUser())!;

    await _backendClient.platformConnectionClient.connectToPlatform(user.id, platform, accessToken, refreshToken, expiresAt, backendAccessToken);
  }



  final BackendClient _backendClient;
  final UserRepository _userRepository;
  final AccessTokenRepository _accessTokenRepository;
}
