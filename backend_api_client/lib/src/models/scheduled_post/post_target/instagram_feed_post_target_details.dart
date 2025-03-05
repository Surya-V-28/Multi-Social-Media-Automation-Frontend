import 'post_target_details.dart';

class InstagramFeedPostTargetDetails implements PostTargetDetails {
  const InstagramFeedPostTargetDetails({required this.userId});

  factory InstagramFeedPostTargetDetails.fromJson(final Map<String, dynamic> json) {
    return InstagramFeedPostTargetDetails(userId: json['userId']);
  }

  final String userId;
}
