import 'package:backend_api_client/src/enums/mime_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_media_request_body.g.dart';

@JsonSerializable(explicitToJson: true, createFactory: false,)
class CreateMediaRequestBody {
  const CreateMediaRequestBody({
    required this.mediaInfo,
    required this.mediaTypeDetails,
  });
  
  Map<String, dynamic> toJson() => _$CreateMediaRequestBodyToJson(this);

  final CreateMediaMediaInfo mediaInfo;
  final CreateMediaRequestBodyMediaTypeDetails mediaTypeDetails;
}

@JsonSerializable(explicitToJson: true, createFactory: false,)
class CreateMediaMediaInfo {
  const CreateMediaMediaInfo({
    required this.id,
    required this.name,
    required this.mimeType,
    required this.size,
  });

  Map<String, dynamic> toJson() => _$CreateMediaMediaInfoToJson(this);

  final String id;
  final String name;
  final MimeType mimeType;
  final int size;
}

@JsonSerializable(explicitToJson: true, createFactory: false,)
sealed class CreateMediaRequestBodyMediaTypeDetails {
  Map<String, dynamic> toJson();
}

@JsonSerializable(explicitToJson: true, createFactory: false,)
class ImageCreateMediaRequestBodyMediaTypeDetails implements CreateMediaRequestBodyMediaTypeDetails {
  const ImageCreateMediaRequestBodyMediaTypeDetails({
    required this.width,
    required this.height,
  });

  @override
  Map<String, dynamic> toJson() => _$ImageCreateMediaRequestBodyMediaTypeDetailsToJson(this); 

  final int width;
  final int height;
}

@JsonSerializable(explicitToJson: true, createFactory: false,)
class VideoCreateMediaRequestBodyMediaTypeDetails implements CreateMediaRequestBodyMediaTypeDetails {
  const VideoCreateMediaRequestBodyMediaTypeDetails({
    required this.duration,
  });

  @override
  Map<String, dynamic> toJson() => _$VideoCreateMediaRequestBodyMediaTypeDetailsToJson(this); 

  final int duration;
}
