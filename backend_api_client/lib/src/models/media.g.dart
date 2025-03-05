// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$MediaToJson(Media instance) => <String, dynamic>{
      'mediaInfo': instance.mediaInfo.toJson(),
      'typeDetails': instance.typeDetails.toJson(),
    };

MediaInfo _$MediaInfoFromJson(Map<String, dynamic> json) => MediaInfo(
      keyId: json['keyId'] as String,
      name: json['name'] as String,
      mimeType: $enumDecode(_$MimeTypeEnumMap, json['mimeType']),
      url: json['url'] as String,
      size: (json['size'] as num).toInt(),
    );

Map<String, dynamic> _$MediaInfoToJson(MediaInfo instance) => <String, dynamic>{
      'keyId': instance.keyId,
      'name': instance.name,
      'mimeType': _$MimeTypeEnumMap[instance.mimeType]!,
      'url': instance.url,
      'size': instance.size,
    };

const _$MimeTypeEnumMap = {
  MimeType.imageJpeg: 'image/jpeg',
  MimeType.imagePng: 'image/png',
  MimeType.imageWebp: 'image/webp',
  MimeType.videoMp4: 'video/mp4',
};

ImageMediaTypeDetails _$ImageMediaTypeDetailsFromJson(
        Map<String, dynamic> json) =>
    ImageMediaTypeDetails(
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
    );

Map<String, dynamic> _$ImageMediaTypeDetailsToJson(
        ImageMediaTypeDetails instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
    };

VideoMediaTypeDetails _$VideoMediaTypeDetailsFromJson(
        Map<String, dynamic> json) =>
    VideoMediaTypeDetails(
      duration: Duration(microseconds: (json['duration'] as num).toInt()),
    );

Map<String, dynamic> _$VideoMediaTypeDetailsToJson(
        VideoMediaTypeDetails instance) =>
    <String, dynamic>{
      'duration': instance.duration.inMicroseconds,
    };
