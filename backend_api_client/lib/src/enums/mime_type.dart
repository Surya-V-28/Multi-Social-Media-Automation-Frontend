import 'package:json_annotation/json_annotation.dart';

enum MimeType {
  @JsonValue('image/jpeg')
  imageJpeg,
  @JsonValue('image/png')
  imagePng,
  @JsonValue('image/webp')
  imageWebp,
  @JsonValue('video/mp4')
  videoMp4;

  static MimeType parse(String textForm) {
    return switch (textForm) {
      'image/jpeg' => MimeType.imageJpeg,
      'image/png' => MimeType.imagePng,
      'image/webp' => MimeType.imageWebp,
      'video/mp4' => MimeType.videoMp4,
      String() => throw FormatException('$textForm cannot be parsed to a MimeType enum'),
    };
  }

  static MimeType fromFileExtension(String fileExtension) {
    return switch (fileExtension) {
      'jpg' => MimeType.imageJpeg,
      'jpeg' => MimeType.imageJpeg,
      'png' => MimeType.imagePng,
      'webp' => MimeType.imageWebp,

      'mp4' => MimeType.videoMp4,

      String() => throw FormatException('MimeType for extension $fileExtension does not exist')
    };
  }

  String get type => toString().split('/')[0];

  String get subType => toString().split('/')[1];

  @override
  String toString() {
    return switch (this) {
      MimeType.imageJpeg => 'image/jpeg',
      MimeType.imagePng => 'image/png',
      MimeType.imageWebp => 'image/webp',
      MimeType.videoMp4 => 'video/mp4',
    };
  }
}
