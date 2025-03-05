// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_media_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$CreateMediaRequestBodyToJson(
        CreateMediaRequestBody instance) =>
    <String, dynamic>{
      'mediaInfo': instance.mediaInfo.toJson(),
      'mediaTypeDetails': instance.mediaTypeDetails.toJson(),
    };

Map<String, dynamic> _$CreateMediaMediaInfoToJson(
        CreateMediaMediaInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mimeType': _$MimeTypeEnumMap[instance.mimeType]!,
      'size': instance.size,
    };

const _$MimeTypeEnumMap = {
  MimeType.imageJpeg: 'image/jpeg',
  MimeType.imagePng: 'image/png',
  MimeType.imageWebp: 'image/webp',
  MimeType.videoMp4: 'video/mp4',
};

Map<String, dynamic> _$CreateMediaRequestBodyMediaTypeDetailsToJson(
        CreateMediaRequestBodyMediaTypeDetails instance) =>
    <String, dynamic>{};

Map<String, dynamic> _$ImageCreateMediaRequestBodyMediaTypeDetailsToJson(
        ImageCreateMediaRequestBodyMediaTypeDetails instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
    };

Map<String, dynamic> _$VideoCreateMediaRequestBodyMediaTypeDetailsToJson(
        VideoCreateMediaRequestBodyMediaTypeDetails instance) =>
    <String, dynamic>{
      'duration': instance.duration,
    };
