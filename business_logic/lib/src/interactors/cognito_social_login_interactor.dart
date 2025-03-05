import 'package:business_logic/src/access_token_repository/access_token_repository.dart';
import 'package:backend_api_client/backend_api_client.dart';
import 'package:business_logic/src/user_repository.dart';
import 'package:common/common.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class CognitoSocialLoginInteractor {
  const CognitoSocialLoginInteractor(
    this._dio,
    this._accessTokenRepository,
    this._userRepository,
    this._backendClient,
  );

  Future<void> login(String authorizationCode) async {
    final accessToken = await _exchangeAuthorizationCodeForAccessToken(authorizationCode);
    final user = await _backendClient.authClient.me(accessToken);

    await _accessTokenRepository.save(accessToken);
    await _userRepository.setUser(user);
  }

  Future<String> _exchangeAuthorizationCodeForAccessToken(String authorizationCode) async {
    final response = await _dio.postUri(
      Uri.parse('${ApplicationProperties.aws.cognito.cognitoUri}/oauth2/token'),
      data: {
        'grant_type': 'authorization_code',
        'client_id': ApplicationProperties.aws.cognito.clientId,
        'redirect_uri': ApplicationProperties.aws.cognito.redirectUri,
        'code': authorizationCode,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType,),
    );

    return response.data['access_token'];
  }




  final Dio _dio;
  final AccessTokenRepository _accessTokenRepository;
  final UserRepository _userRepository;
  final BackendClient _backendClient;
}
