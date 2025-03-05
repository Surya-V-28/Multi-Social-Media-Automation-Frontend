import 'package:dio/dio.dart';

import '../models/notification.dart';

class NotificationClient {
  const NotificationClient._(this._uri, this._dio);

  factory NotificationClient(Uri backendUri, Dio dio) {
    return NotificationClient._(backendUri.replace(path: '${backendUri.path}/api/notification'), dio);
  }

  Future<Notification> getNotification(String userId, String id, String accessToken) async {
    final uri = _uri.replace(path: '${_uri.path}/$userId/notifications/$id');
    final response = await _dio.getUri(
      uri,
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );

    return Notification.fromJson(response.data);
  }

  Future<List<Notification>> getUsersNotifications(String userId, String accessToken) async {
    final uri = _uri.replace(path: '${_uri.path}/$userId/notifications');
    final response = await _dio.getUri(
      uri,
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );

    return (response.data['data'] as List<dynamic>)
      .map((e) => Notification.fromJson(e))
      .toList();
  }



  final Uri _uri;
  final Dio _dio;
}
