import 'dart:convert';

import 'package:facebook_api_client/src/models/facebook_page.dart';
import 'package:facebook_api_client/src/models/user.dart';
import 'package:dio/dio.dart';

class FacebookApiClient {
  const FacebookApiClient(this._dio);

  Future<List<FacebookPage>> getPages(String userId, String accessToken) async {
    final uri = Uri.parse('https://graph.facebook.com/v20.0/$userId/accounts')
      .replace(
        queryParameters: { 
          'access_token': accessToken, 
          'fields': 'id,name,instagram_business_account,access_token', 
        }
      );
    final response = await _dio.getUri(uri);
    final responseBody = jsonDecode(response.data);

    return (responseBody['data'] as List<dynamic>)
      .map<FacebookPage>((element) => FacebookPage.fromJson(element))
      .toList();
  }

  Future<User> me(String accessToken) async {
    final uri = Uri.parse('https://graph.facebook.com/v21.0/me?access_token=$accessToken');
    final response = await _dio.getUri(uri);
    final responseBody = jsonDecode(response.data);

    return User.fromJson(responseBody);
  }


  final Dio _dio;
}
