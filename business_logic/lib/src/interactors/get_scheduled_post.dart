import 'package:business_logic/src/access_token_repository/access_token_repository.dart';
import 'package:backend_api_client/backend_api_client.dart';
import 'package:business_logic/src/user_repository.dart';

class GetScheduledPostInteractor {
  const GetScheduledPostInteractor(this._backendClient, this._userRepository, this._accessTokenRepository,);

  Future<ScheduledPost> get(String id) async {
    final user = (await _userRepository.getUser())!;
    final accessToken = (await _accessTokenRepository.getToken())!;

    return await _backendClient.postClient.getScheduledPost(user.id, id, accessToken);
  }


  final BackendClient _backendClient;
  final UserRepository _userRepository;
  final AccessTokenRepository _accessTokenRepository;
}
