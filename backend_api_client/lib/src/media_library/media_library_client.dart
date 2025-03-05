import 'package:backend_api_client/src/enums/mime_type.dart';
import 'package:dio/dio.dart';
import '../models/media.dart';

import 'create_media_request_body.dart';

export 'create_media_request_body.dart';

class MediaLibraryClient {
  const MediaLibraryClient._(this._url, this._dio);

  factory MediaLibraryClient(Uri url, Dio dio) {
    return MediaLibraryClient._(
      url.replace(path: '${url.path}/api/media-library'),
      dio,
    );
  }

  Future<(String, Uri)> getUploadUrl(MimeType mimeType, String? keyId, String accessToken) async {
    final url = _url.replace(path: '${_url.path}/s3/uploadUrl');
    final requestBody = {
      'key': keyId,
      'mimeType': mimeType.toString(),
    };
    final response = await _dio.postUri(
      url, 
      data: requestBody, 
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );
    final responseBody = response.data;

    final key = responseBody['key'] as String;
    final uploadUrl = Uri.parse(responseBody['uploadUrl'] as String);
    return (key, uploadUrl);
  }

  Future<void> createMedia(CreateMediaRequestBody requestBody, String userId, String accessToken) async {
    final url = _url.replace(path: '${_url.path}/$userId/media');

    await _dio.postUri(
      url,
      data: requestBody.toJson(),
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );
  }

  Future<List<Media>> getUserMedias(final String userId, final String accessToken) async {
    final url = _url.replace(path: '${_url.path}/$userId/media');

    final response = await _dio.getUri(url, options: Options(headers: {'Authorization': 'Bearer $accessToken'}));

    return (response.data['data'] as List<dynamic>)
      .map((e) => Media.fromJson(e))
      .toList();
  }

  Future<Media> getMedia(String userId, String id, final String accessToken) async {
    final url = _url.replace(path: '${_url.path}/$userId/media/$id');

    final response = await _dio.getUri(url, options: Options(headers: {'Authorization': 'Bearer $accessToken'}));

    return Media.fromJson(response.data);
  }

  Future<void> deleteMedia(String userId, String id, String accessToken) async {
    final url = _url.replace(path: '${_url.path}/$userId/media/$id');
    await _dio.deleteUri(url, options: Options(headers: {'Authorization': 'Bearer $accessToken'}));
  }


  final Uri _url;
  final Dio _dio;
}
