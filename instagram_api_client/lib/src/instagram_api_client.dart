import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';

import 'models/media_insight.dart';


class InstagramApiClient {
  const InstagramApiClient(this._dio);

  Future<List<MediaInsight>> getMediaInsights(
    final String mediaId,
    final List<String> metrics,
    final String accessToken,
  ) async {
    final uri = Uri.parse('https://graph.facebook.com/v21.0/$mediaId/insights')
      .replace(
        queryParameters: {
          'access_token': accessToken,
          'metric': metrics.reduceIndexed((index, accumulated, element) {
            var result = accumulated;
            if (index != 0) {
              result += ',';
            }
            result += element;
            return result;
          }),
          'period': 'day'
        },
      );

    final response = await _dio.getUri(uri);
    final responseBody = jsonDecode(response.data);

    return (responseBody['data'] as List<dynamic>)
      .map((e) => MediaInsight.fromJson(e))
      .toList();
  }

  final Dio _dio;
}