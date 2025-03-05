
import 'package:backend_api_client/src/models/user.dart';
import 'package:dio/dio.dart';

class AuthClient {
  const AuthClient._(this.backendUri, this.dio);

  factory AuthClient(Uri backendUri, Dio dio) {
    final authBackendUri = Uri.parse(backendUri.toString())
      .replace(path: "/api/auth");

    return AuthClient._(authBackendUri, dio);
  }

  Future<void> signUp(String email, String username, String password) async {
    final signUpUri = Uri.parse(backendUri.toString())
      .replace(path: '${backendUri.path}/signup');

    final requestBody = {
      'username': username,
      'email': email,
      'password': password,
    };
    await dio.postUri(signUpUri, data: requestBody);
  }

  Future<String> login({String? email, String? username, required String password}) async {
    final loginUri = Uri.parse(backendUri.toString())
      .replace(path: '${backendUri.path}/login');

    final requestBody = {
      if (email != null) 'email': email,
      if (username != null) 'username': username,
      'password': password,
    };
    final response = await dio.postUri(loginUri, data: requestBody);

    return response.data['accessToken'];
  }

  Future<User> me(String accessToken) async {
    final meUri = Uri.parse(backendUri.toString())
        .replace(path: '${backendUri.path}/me');

    final headers = {
      'Authorization': 'Bearer $accessToken'
    };

    final response = await dio.getUri(meUri, options: Options(headers: headers));
    return User.fromJson(response.data);
  }



  final Uri backendUri;
  final Dio dio;
}
