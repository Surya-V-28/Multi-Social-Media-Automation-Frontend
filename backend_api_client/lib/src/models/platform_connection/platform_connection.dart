import 'package:backend_api_client/src/enums/enums.dart';

class PlatformConnection {
  const PlatformConnection({
    required this.id,
    required this.userId,
    required this.platform,
    required this.platformUserId,
    required this.accessToken,
  });

  factory PlatformConnection.fromJson(final Map<String, dynamic> json) {
    return PlatformConnection(
      id: json['id'],
      userId: json['userId'],
      platform: SocialMediaPlatform.parse(json['platform']),
      platformUserId: json['platformUserId'],
      accessToken: json['accessToken']
    );
  }


  final String id;
  final String userId;
  final SocialMediaPlatform platform;
  final String platformUserId;
  final String? accessToken;
}