import 'package:backend_api_client/src/enums/enums.dart';

class ValidatePostRequest {
  const ValidatePostRequest({required this.targets, required this.validatingPost,});

  Map<String, dynamic> toJson() {
    return {
      'targets': targets.map((e) => e.name).toList(),
      'validatingPost': validatingPost.toJson(),
    };
  }


  final List<PostTargetType> targets;
  final ValidatePostRequestValidatingPost validatingPost;
}

class ValidatePostRequestValidatingPost {
  const ValidatePostRequestValidatingPost({
    required this.title,
    required this.caption,
    required this.media,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'caption': caption,
      'media': media.map((e) => e.toJson()).toList(),
    };
  }


  final String title;
  final String caption;
  final List<ValidatePostRequestMedia> media;
}

class ValidatePostRequestMedia {
  const ValidatePostRequestMedia({required this.size, required this.mimeType, required this.details,});

  Map<String, dynamic> toJson() {
    return {
      'size': size,
      'mimeType': mimeType.toString(),
      'details': details.toJson(),
    };
  }


  final int size;
  final MimeType mimeType;
  final ValidatePostRequestMediaDetails details;
}

abstract class ValidatePostRequestMediaDetails {
  Map<String, dynamic> toJson();
}

class ValidatePostRequestImageMediaDetails implements ValidatePostRequestMediaDetails {
  const ValidatePostRequestImageMediaDetails({required this.width, required this.height});

  @override
  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
    };
  }


  final int width;
  final int height;
}

class ValidatePostRequestVideoMediaDetails implements ValidatePostRequestMediaDetails {
  const ValidatePostRequestVideoMediaDetails({required this.length,});

  @override
  Map<String, dynamic> toJson() {
    return {
      'length': length,
    };
  }


  final int length;
}
