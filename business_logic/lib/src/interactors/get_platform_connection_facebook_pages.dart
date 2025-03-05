import 'package:business_logic/src/access_token_repository/access_token_repository.dart';
import 'package:backend_api_client/backend_api_client.dart';
import 'package:facebook_api_client/facebook_api_client.dart';
import 'package:business_logic/src/user_repository.dart';

class GetPlatformConnectionFacebookPagesInteractor {
  const GetPlatformConnectionFacebookPagesInteractor(
    this._backendApiClient,
    this._facebookApiClient,
    this._accessTokenRepository,
    this._userRepository,
  );

  Future<List<FacebookPage>> perform(String platformConnectionId) async {
    final user = (await _userRepository.getUser())!;
    final accessToken = (await _accessTokenRepository.getToken())!;

    final platformConnection = await _backendApiClient.platformConnectionClient
      .getPlatformConnection(user.id, platformConnectionId, accessToken);

    return await _facebookApiClient
        .getPages(platformConnection.platformUserId, platformConnection.accessToken!);
  }



  final BackendClient _backendApiClient;
  final FacebookApiClient _facebookApiClient;

  final UserRepository _userRepository;
  final AccessTokenRepository _accessTokenRepository;
}