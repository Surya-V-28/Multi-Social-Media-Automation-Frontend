sealed class SchedulePostRequestPostTargetDetails {
  Map<String, dynamic> toJson();
}

class FacebookPageSchedulePostRequestTargetDetails implements SchedulePostRequestPostTargetDetails {
  const FacebookPageSchedulePostRequestTargetDetails({required this.pageId});

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'pageId': pageId,
    };
  }

  final String pageId;
}

class InstagramFeedSchedulePostRequestTargetDetails implements SchedulePostRequestPostTargetDetails {
  const InstagramFeedSchedulePostRequestTargetDetails({required this.userId});

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userId': userId,
    };
  }

  final String userId;
}

class InstagramStorySchedulePostRequestTargetDetails implements SchedulePostRequestPostTargetDetails {
  const InstagramStorySchedulePostRequestTargetDetails({required this.userId});

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userId': userId,
    };
  }

  final String userId;
}
