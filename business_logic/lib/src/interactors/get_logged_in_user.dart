import 'package:business_logic/src/access_token_repository/access_token_repository.dart';
import 'package:backend_api_client/backend_api_client.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetLoggedInUserInteractor {
  const GetLoggedInUserInteractor(
    this._accessTokenRepository,
    this._backendClient
  );

  Future<User?> perform() async {
    final String? accessToken = await _accessTokenRepository.getToken();
    if (accessToken == null) {
      return null;
    }

    return await _backendClient.authClient.me(accessToken);
  }


  final AccessTokenRepository _accessTokenRepository;
  final BackendClient _backendClient;
}