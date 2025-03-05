import 'package:backend_api_client/backend_api_client.dart';
import 'package:business_logic/src/access_token_repository/access_token_repository.dart';
import 'package:business_logic/src/user_repository.dart';

class GetMediaInteractor {
  GetMediaInteractor(this._accessTokenRepository, this._userRepository, this._backendClient);

  Future<Media> perform(String id, String accessToken) async {
    final accessToken = (await _accessTokenRepository.getToken())!;
    final user = (await _userRepository.getUser())!;

    return await _backendClient.mediaLibrary.getMedia(user.id, id, accessToken);
  }

  final AccessTokenRepository _accessTokenRepository;
  final UserRepository _userRepository;
  final BackendClient _backendClient;
}
