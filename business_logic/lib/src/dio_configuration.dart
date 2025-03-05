import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioConfiguration {
  @singleton
  Dio dio() => Dio();
}
