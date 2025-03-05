import 'package:business_logic/src/access_token_repository/access_token_repository.dart';
import 'package:business_logic/src/user_repository.dart';

import 'package:backend_api_client/backend_api_client.dart';

class GetPlatformConnectionsInteractor {
  const GetPlatformConnectionsInteractor(
    this._backendClient,
    this._accessTokenRepository,
    this._userRepository,
  );

  Future<List<PlatformConnection>> perform({
    SocialMediaPlatform? platform,
  }) async {
    final user = (await _userRepository.getUser())!;
    final accessToken = (await _accessTokenRepository.getToken())!;

    return await _backendClient.platformConnectionClient
        .getPlatformConnections(user.id, accessToken, platform: platform);
  }



  final BackendClient _backendClient;
  final AccessTokenRepository _accessTokenRepository;
  final UserRepository _userRepository;
}