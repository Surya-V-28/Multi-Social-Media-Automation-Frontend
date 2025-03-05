import 'package:json_annotation/json_annotation.dart';

class MyDurationJsonConverter extends JsonConverter<Duration, int> {
  const MyDurationJsonConverter();

  @override
  Duration fromJson(int json) => Duration(milliseconds: json);

  @override
  int toJson(Duration object) => object.inMilliseconds;
}
