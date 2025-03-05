import 'package:business_logic/src/access_token_repository/access_token_repository.dart';
import 'package:backend_api_client/backend_api_client.dart';
import 'package:instagram_api_client/instagram_api_client.dart';
import 'package:business_logic/src/user_repository.dart';

class GetInstagramFeedPostInsightsInteractor {
  const GetInstagramFeedPostInsightsInteractor(
    this._userRepository,
    this._accessTokenRepository,

    this._instagramApiClient,
    this._backendClient,
  );

  Future<List<MediaInsight>> perform(String scheduledPostId, String postTargetId) async {
    final user = (await _userRepository.getUser())!;
    final accessToken = (await _accessTokenRepository.getToken())!;
    
    final scheduledPost = await _backendClient.postClient
      .getScheduledPost(user.id, scheduledPostId, accessToken);
      
    final postTarget = scheduledPost.targets
      .firstWhere((e) => e.id == postTargetId);
      
    final platformConnection = await _backendClient.platformConnectionClient
      .getPlatformConnection(user.id, postTarget.platformConnectionId, accessToken);

    return await _instagramApiClient.getMediaInsights(
      postTarget.createdPostId!, 
      metrics,
      platformConnection.accessToken!
    );
  }


  final UserRepository _userRepository;
  final AccessTokenRepository _accessTokenRepository;

  final InstagramApiClient _instagramApiClient;
  final BackendClient _backendClient;

  static const metrics = <String>[
    'clips_replays_count',
    'plays',
    'ig_reels_aggregated_all_plays_count',
    'ig_reels_avg_watch_time',
    'ig_reels_video_view_total_time',
    'comments',
    'likes',
    'reach',
    'saved',
    'shares',
    'total_interactions',
  ];
}
