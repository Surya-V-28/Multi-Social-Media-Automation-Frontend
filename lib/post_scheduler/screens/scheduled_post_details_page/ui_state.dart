import 'package:business_logic/business_logic.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:post_scheduler/utils/option.dart';

class ScheduledPostDetailsPageUiState {
  const ScheduledPostDetailsPageUiState({
    required this.isLoading,
    required this.id,
    required this.isFulfilled,
    required this.postTargets,
    required this.navigatingToPostTargetUrl,
  });

  const ScheduledPostDetailsPageUiState.initial() :
    isLoading = true,
    id = '',
    isFulfilled = false,
    postTargets = const IList.empty(),
    navigatingToPostTargetUrl = null;


  ScheduledPostDetailsPageUiState copyWith({bool? isLoading, String? id, bool? isFulfilled, IList<PostTargetUiState>? postTargets, Option<String?>? navigatingToPostTargetUrl}) {
    return ScheduledPostDetailsPageUiState(
      isLoading: isLoading ?? this.isLoading,
      id: id ?? this.id,
      isFulfilled: isFulfilled ?? this.isFulfilled,
      postTargets: postTargets ?? this.postTargets,
      navigatingToPostTargetUrl: Option.resolveWithFallback(navigatingToPostTargetUrl, this.navigatingToPostTargetUrl),
    );
  }


  final bool isLoading;
  final String id;
  final bool isFulfilled;

  final IList<PostTargetUiState> postTargets;
  final String? navigatingToPostTargetUrl;
}

class PostTargetUiState {
  const PostTargetUiState({required this.id, required this.type, required this.createdPostId,});

  final String id;
  final PostTargetType type;
  final String? createdPostId;
}
