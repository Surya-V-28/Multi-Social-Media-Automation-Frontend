import 'package:backend_api_client/src/enums/post_target_type.dart';
import 'post_target_details.dart';

export 'post_target_details.dart';

class SchedulePostRequest {
  const SchedulePostRequest({
    required this.userId,
    required this.scheduledTime,
    required this.targets,

    required this.title,
    required this.caption,
    required this.media,
    required this.accessToken,
  });


  final String userId;
  final DateTime scheduledTime;
  final List<SchedulePostRequestPostTarget> targets;

  final String title;
  final String caption;
  final List<String> media;

  final String accessToken;
}

class SchedulePostRequestPostTarget {
  const SchedulePostRequestPostTarget({
    required this.platformConnectionId,
    required this.targetType,
    required this.details,
  });

  Map<String, dynamic> toJson() {
    return {
      'platformConnectionId': platformConnectionId,
      'targetType': targetType.name,
      'details': details.toJson(),
    };
  }

  final String platformConnectionId;
  final PostTargetType targetType;
  final SchedulePostRequestPostTargetDetails details;
}