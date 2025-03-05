import 'package:backend_api_client/backend_api_client.dart';
import 'package:business_logic/src/access_token_repository/access_token_repository.dart';
import 'package:business_logic/src/user_repository.dart';

class DeleteMediaInteractor {
  DeleteMediaInteractor(this._accessTokenRepository, this._userRepository, this._backendClient);

  Future<void> perform(String id) async {
    final accessToken = (await _accessTokenRepository.getToken())!;
    final user = (await _userRepository.getUser())!;

    await _backendClient.mediaLibrary.deleteMedia(user.id, id, accessToken);
  }

  final AccessTokenRepository _accessTokenRepository;
  final UserRepository _userRepository;
  final BackendClient _backendClient;
}
