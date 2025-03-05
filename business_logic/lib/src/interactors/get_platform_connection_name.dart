import 'package:business_logic/business_logic.dart';
import 'package:business_logic/src/access_token_repository/access_token_repository.dart';
import 'package:business_logic/src/user_repository.dart';

class GetPlatformConnectionNameInteractor {
  const GetPlatformConnectionNameInteractor(
    this._userRepository,
    this._accessTokenRepository,
    this._backendClient,
    this._facebookApiClient,
  );

  Future<String> perform(String id) async {
    final user = (await _userRepository.getUser())!;
    final accessToken = (await _accessTokenRepository.getToken())!;
    
    final platformConnection = await _backendClient.platformConnectionClient
      .getPlatformConnection(user.id, id, accessToken);
      
    switch (platformConnection.platform) {
      case SocialMediaPlatform.facebook:
        return (await _facebookApiClient.me(platformConnection.accessToken!))
          .name;
      
      default:
        throw Exception("Unable to handle platform ${platformConnection.platform}");
    }
  }
  
  

  final UserRepository _userRepository;
  final AccessTokenRepository _accessTokenRepository;
  final BackendClient _backendClient;
  
  final FacebookApiClient _facebookApiClient;
}
