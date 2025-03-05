import 'package:backend_api_client/src/enums/enums.dart';
import 'package:backend_api_client/src/models/platform_connection/platform_connection.dart';
import 'package:dio/dio.dart';

class PlatformConnectionClient {
  const PlatformConnectionClient._(this._backendUrl, this._dio);

  factory PlatformConnectionClient(Uri backendUrl, Dio dio) {
    final platformConnectionBackendUrl = backendUrl.replace(path: "/api/platform-connection");

    return PlatformConnectionClient._(platformConnectionBackendUrl, dio);
  }

  Future<ExchangeAuthorizationCodeForAccessTokenResponseBody> exchangeAuthorizationCodeForAccessToken(SocialMediaPlatform platform, String authorizationCode) async {
    final url = _backendUrl.replace(path: '${_backendUrl.path}/exchange-authorization-code-for-access-token');

    final requestBody = {
      'platform': platform.toString(),
      'authorizationCode': authorizationCode,
    };

    final response = await _dio.postUri(url, data: requestBody,);

    return ExchangeAuthorizationCodeForAccessTokenResponseBody(response.data['accessToken'], response.data['refreshToken'], DateTime.parse(response.data['expiresAt']));
  }

  Future<String> connectToPlatform(String userId, SocialMediaPlatform platform, String accessToken, String refreshToken, DateTime expiresAt, String backendAccessToken) async {
    final url = _backendUrl.replace(path: '${_backendUrl.path}/$userId/connections');
    final response = await _dio.postUri(
      url,
      data: {
        'platform': platform.toString(),
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'expiresAt': expiresAt.toIso8601String(),
      },
      options: Options(headers: { 'Authorization': 'Bearer $backendAccessToken' },),
    );

    print("CustomLog: Connect to Platform:\n${response.data.toString()}");
    
    return response.data['id'];
  }

  Future<List<PlatformConnection>> getPlatformConnections(
    String userId,
    String accessToken,
    {SocialMediaPlatform? platform}
  ) async {
    final url = _backendUrl
      .replace(
        path: '${_backendUrl.path}/$userId/connections',
        queryParameters: {
          if (platform != null) 'platform': platform.name
        },
      );

    final headers = { 'Authorization': 'Bearer $accessToken' };

    final response = await _dio.getUri(url, options: Options(headers: headers));

    return (response.data['data'] as List<dynamic>)
      .map((json) => PlatformConnection.fromJson(json))
      .toList();
  }

  Future<PlatformConnection> getPlatformConnection(
    String userId,
    String platformConnectionId,
    String accessToken,
  ) async {
    final url = _backendUrl.replace(path: '${_backendUrl.path}/$userId/connections/$platformConnectionId',);

    final headers = { 'Authorization': 'Bearer $accessToken' };

    final response = await _dio.getUri(url, options: Options(headers: headers));

    return PlatformConnection.fromJson(response.data);
  }

  Future<void> removePlatformConnection(String userId, String platformConnectionId, String accessToken,) async {
    final url = _backendUrl.replace(path: '${_backendUrl.path}/$userId/connections/$platformConnectionId');
    final headers = { 'Authorization': 'Bearer $accessToken' };
    await _dio.deleteUri(url, options: Options(headers: headers));
  }


  final Dio _dio;
  final Uri _backendUrl;
}


class ExchangeAuthorizationCodeForAccessTokenResponseBody {
  const ExchangeAuthorizationCodeForAccessTokenResponseBody(this.accessToken, this.refreshToken, this.expiresAt);


  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;
}
