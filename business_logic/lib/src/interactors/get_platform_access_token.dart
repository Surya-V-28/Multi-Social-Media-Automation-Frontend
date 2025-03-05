import 'package:backend_api_client/backend_api_client.dart';

class GetPlatformAccessTokenInteractor {
  const GetPlatformAccessTokenInteractor(this.backendClient);

  Future<ExchangeAuthorizationCodeForAccessTokenResponseBody> getAccessToken(SocialMediaPlatform platform, String authorizationCode) async {
    return await backendClient.platformConnectionClient.exchangeAuthorizationCodeForAccessToken(platform, authorizationCode);
  }


  final BackendClient backendClient;
}
