import 'post_target_details.dart';

class FacebookPagePostTargetDetails implements PostTargetDetails {
  const FacebookPagePostTargetDetails({required this.pageId});

  factory FacebookPagePostTargetDetails.fromJson(Map<String, dynamic> json) {
    return FacebookPagePostTargetDetails(pageId: json['pageId']);
  }


  final String pageId;
}
