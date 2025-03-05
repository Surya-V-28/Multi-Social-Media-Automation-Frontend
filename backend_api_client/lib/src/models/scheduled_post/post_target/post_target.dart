import 'package:backend_api_client/src/enums/post_target_type.dart';
import 'package:dart_scope_functions/dart_scope_functions.dart';

import 'instagram_story_post_target_details.dart';
import 'post_target_details.dart';
import 'facebook_post_target_details.dart';
import 'instagram_feed_post_target_details.dart';

class PostTarget {
  const PostTarget({
    required this.id,
    required this.platformConnectionId,
    required this.targetType,
    required this.details,
    required this.createdPostId,
  });

  factory PostTarget.fromJson(Map<String, dynamic> json) {
    final PostTargetType targetType = PostTargetType.parse(json['targetType']);

    return PostTarget(
      id: json['id'],
      platformConnectionId: json['platformConnectionId'],
      targetType: targetType,
      details: (json['details'] as Map<String, dynamic>).let(
        (detailsJson) {
          return switch (targetType) {
            PostTargetType.facebookPage => FacebookPagePostTargetDetails.fromJson(detailsJson),
            PostTargetType.instagramFeed => InstagramFeedPostTargetDetails.fromJson(detailsJson),
            PostTargetType.instagramStory => InstagramStoryPostTargetDetails.fromJson(detailsJson),
          };
        }
      ),
      createdPostId: json['createdPostId'],
    );
  }


  final String id;
  final String platformConnectionId;
  final PostTargetType targetType;
  final PostTargetDetails details;
  final String? createdPostId;
}
