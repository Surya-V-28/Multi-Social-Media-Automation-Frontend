import 'post_target/post_target.dart';
import 'post_media.dart';

export 'post_media.dart';

export 'post_target/post_target.dart';
export 'post_target/post_target_details.dart';
export 'post_target/facebook_post_target_details.dart';
export 'post_target/instagram_feed_post_target_details.dart';

class ScheduledPost {
  const ScheduledPost({
    required this.id,
    required this.userId,
    required this.scheduledTime,
    required this.isFulfilled,

    required this.title,
    required this.caption,
    required this.media,
    required this.targets,
  });

  factory ScheduledPost.fromJson(Map<String, dynamic> json) {
    return ScheduledPost(
      id: json['id'],
      userId: json['userId'],
      scheduledTime: DateTime.parse(json['scheduledTime']),
      isFulfilled: json['isFulfilled'],

      targets: (json['targets'] as List<dynamic>)
        .map<PostTarget>((element) => PostTarget.fromJson(element))
        .toList(),

      title: json['title'] as String?,
      caption: json['caption'],
      media: (json['medias'] as List<dynamic>)
        .map<PostMedia>((element) => PostMedia.fromJson(element))
        .toList(),
    );
  }



  final String id;
  final String userId;
  final DateTime scheduledTime;
  final bool isFulfilled;

  final String? title;
  final String? caption;
  final List<PostMedia> media;
  final List<PostTarget> targets;
}
