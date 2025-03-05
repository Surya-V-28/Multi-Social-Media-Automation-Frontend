import 'package:injectable/injectable.dart';

import 'package:backend_api_client/backend_api_client.dart';

import 'package:business_logic/src/user_repository.dart';
import 'package:business_logic/src/access_token_repository/access_token_repository.dart';



@singleton
class GetPostRequestsInteractor {
  const GetPostRequestsInteractor({
    required UserRepository userRepository,
    required AccessTokenRepository accessTokenRepository,
    required BackendClient backendClient,
  }) :
    _userRepository = userRepository,
    _accessTokenRepository = accessTokenRepository,
    _backendClient = backendClient;

  Future<List<ScheduledPost>> get({DateTime? fromTime, DateTime? toTime}) async {
    final user = (await _userRepository.getUser())!;
    final accessToken = (await _accessTokenRepository.getToken())!;

    return await _backendClient.postClient
      .getUsersScheduledPosts(
        user.id,
        accessToken,
        fromTime: fromTime,
        toTime: toTime
      );
  }


  final UserRepository _userRepository;
  final AccessTokenRepository _accessTokenRepository;
  final BackendClient _backendClient;
}