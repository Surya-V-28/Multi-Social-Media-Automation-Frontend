import 'post_target_details.dart';

class InstagramStoryPostTargetDetails implements PostTargetDetails {
  const InstagramStoryPostTargetDetails({required this.userId});

  factory InstagramStoryPostTargetDetails.fromJson(final Map<String, dynamic> json) {
    return InstagramStoryPostTargetDetails(userId: json['userId']);
  }

  final String userId;
}
