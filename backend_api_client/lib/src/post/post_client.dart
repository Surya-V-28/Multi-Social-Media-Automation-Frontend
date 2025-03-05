import 'package:backend_api_client/src/enums/enums.dart';
import 'package:backend_api_client/src/models/schedule_post_request/schedule_post_request.dart';
import 'package:backend_api_client/src/models/scheduled_post/scheduled_post.dart';
import 'package:dart_scope_functions/dart_scope_functions.dart';
import 'package:dio/dio.dart';

import 'validate_post_request_body.dart';
export 'validate_post_request_body.dart';

/// Client for the Post module of the Backend API.
class PostClient {
  const PostClient._(this._backendUrl, this._dio);

  factory PostClient(Uri backendUri, Dio dio) {
    return PostClient._(
      backendUri.replace(path: "/api/post"),
      dio,
    );
  }

  Future<GetS3UploadUrlResponse> getS3UploadUrl(
    MimeType mimeType,
    String accessToken,
    {String? name}
  ) async {
    var url = _backendUrl.replace(path: '${_backendUrl.path}/s3');

    var requestBody = {
      'mimeType': mimeType.toString(),
      if (name != null) 'key' : mimeType.toString(),
    };

    var headers = { 'Authorization': 'Bearer $accessToken' };

    final response = await _dio.postUri(
      url,
      data: requestBody,
      options: Options(headers: headers)
    );

    return GetS3UploadUrlResponse.fromJson(response.data);
  }

  Future<String> schedulePost(SchedulePostRequest request) async {
    final uri = _backendUrl
      .replace(path: '${_backendUrl.path}/${request.userId}/posts');

    final headers = { 'Authorization': 'Bearer ${request.accessToken}' };

    final requestBody = {
      'scheduledTime': request.scheduledTime.toUtc()
        .let((it) {
          return DateTime.utc(
              it.year,
              it.month,
              it.day,
              it.hour,
              it.minute,
              it.second
          );
        })
        .toIso8601String(),
      'targets': request.targets
        .map((target) => target.toJson())
        .toList(),

      'title': request.title,
      'caption': request.caption,
      'media': request.media,
    };

    final response = await _dio.postUri(
      uri,
      data: requestBody,
      options: Options(headers: headers),
    );

    return response.data['id'];
  }

  Future<List<ScheduledPost>> getUsersScheduledPosts(
    String userId,
    String accessToken,
    {DateTime? fromTime,
    DateTime? toTime}
  ) async {
    final uriQueryParameters = <String, dynamic>{
      if (fromTime != null)
        'fromTime': fromTime.toUtc().toIso8601String(),
      if (toTime != null)
        'toTime': toTime.toUtc().toIso8601String(),
    };
    final uri = Uri.parse(_backendUrl.toString())
        .replace(
          path: '${_backendUrl.path}/$userId/posts',
          queryParameters: uriQueryParameters,
        );

    final headers = {
      'Authorization': 'Bearer $accessToken'
    };
    final response = await _dio.getUri(uri, options: Options(headers: headers));

    final List<dynamic> postRequestsResponseBody = response
        .data['data'];

    return postRequestsResponseBody
      .map((json) => ScheduledPost.fromJson(json))
      .toList();
  }

  /// Fetches a Scheduled Post with the id [id].
  Future<ScheduledPost> getScheduledPost(String userId, String id, String accessToken) async {
    final uri = Uri.parse(_backendUrl.toString())
        .replace(path: '${_backendUrl.path}/$userId/posts/$id',);

    final headers = { 'Authorization': 'Bearer $accessToken' };
    final response = await _dio.getUri(uri, options: Options(headers: headers));

    return ScheduledPost.fromJson(response.data);
  }

  /// Validates the input used to create a Scheduled Post.
  ///
  /// [postTargets] takes a record that indicates a id of a Post Target and a Post Target.
  ///
  Future<Map<PostTargetType, List<String>>> validatePost(ValidatePostRequest request) async {
    final url = _backendUrl.replace(path: '${_backendUrl.path}/posts/validate');
    final Map<String, dynamic> responseBody = (await _dio.putUri(url, data: request.toJson(),))
      .data;

    print('CustomLog: Response body = $responseBody');

    return responseBody
      .map((key, value) {
        final mappedValue = (value as List<dynamic>)
          .map((e) => e as String)
          .toList();

        return MapEntry(PostTargetType.parse(key), mappedValue);
      });
  }


  final Uri _backendUrl;
  final Dio _dio;
}

class GetS3UploadUrlResponse {
  const GetS3UploadUrlResponse({required this.key, required this.uploadUrl});

  factory GetS3UploadUrlResponse.fromJson(Map<String, dynamic> json) {
    return GetS3UploadUrlResponse(
      key: json['key'],
      uploadUrl: json['uploadUrl']
    );
  }

  final String key;
  final String uploadUrl;
}
