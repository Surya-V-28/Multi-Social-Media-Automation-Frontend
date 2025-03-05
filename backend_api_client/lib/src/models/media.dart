import 'package:backend_api_client/src/enums/mime_type.dart';
import 'package:backend_api_client/src/json_serializable/custom_converters/duration.dart';
import 'package:json_annotation/json_annotation.dart';

part 'media.g.dart';

@JsonSerializable(explicitToJson: true, createFactory: false,)
@MyDurationJsonConverter.new()
class Media {
  const Media({
    required this.mediaInfo,
    required this.typeDetails,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    final mediaInfo = MediaInfo.fromJson(json['mediaInfo']);

    return Media(
      mediaInfo: mediaInfo,
      typeDetails: MediaTypeDetails.fromJson(json['typeDetails'], mediaInfo.mimeType.type),
    );
  }

  Map<String, dynamic> toJson() => _$MediaToJson(this); 

  final MediaInfo mediaInfo;
  final MediaTypeDetails typeDetails;
}

@JsonSerializable(explicitToJson: true)
class MediaInfo {
  const MediaInfo({
    required this.keyId,
    required this.name,
    required this.mimeType,
    required this.url,
    required this.size,
  });

  factory MediaInfo.fromJson(Map<String, dynamic> json) => _$MediaInfoFromJson(json);

  Map<String, dynamic> toJson() => _$MediaInfoToJson(this);

  final String keyId;
  final String name;
  final MimeType mimeType;
  final String url;
  final int size;
}

@JsonSerializable(explicitToJson: true, createFactory: false, createToJson: false,)
sealed class MediaTypeDetails {
  static fromJson(Map<String, dynamic> json, String type) {
    print(json);

    return switch (type) {
      'image' => ImageMediaTypeDetails.fromJson(json),
      'video' => VideoMediaTypeDetails.fromJson(json),
      _ => throw Exception('Cannot create MediaTypeDetails from mimetype with type of $type'),
    };
  }

  Map<String, dynamic> toJson();
}

@JsonSerializable(explicitToJson: true)
class ImageMediaTypeDetails implements MediaTypeDetails {
  const ImageMediaTypeDetails({
    required this.width,
    required this.height,
  });

  factory ImageMediaTypeDetails.fromJson(Map<String, dynamic> json) => _$ImageMediaTypeDetailsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ImageMediaTypeDetailsToJson(this);

  final int width;
  final int height;
}

@JsonSerializable(explicitToJson: true)
class VideoMediaTypeDetails implements MediaTypeDetails {
  const VideoMediaTypeDetails({
    required this.duration,
  });

  factory VideoMediaTypeDetails.fromJson(Map<String, dynamic> json) => _$VideoMediaTypeDetailsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VideoMediaTypeDetailsToJson(this);

  final Duration duration;
}
