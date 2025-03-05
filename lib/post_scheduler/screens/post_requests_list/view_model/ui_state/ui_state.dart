import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'package:post_scheduler/utils/option.dart';
import 'post_request_ui_state.dart';

abstract class PostRequestsListPageUiState {
  static PostRequestsListPageUiState intial() => const InitialLoadingPostRequestsListPageUiState();
}

class InitialLoadingPostRequestsListPageUiState implements PostRequestsListPageUiState {
  const InitialLoadingPostRequestsListPageUiState();
}

class LoadedPostRequestsListPageUiState implements PostRequestsListPageUiState {
  const LoadedPostRequestsListPageUiState({required this.isLoading, required this.postRequests, required this.navigateToPost});

  const LoadedPostRequestsListPageUiState.initial({required this.postRequests}) : isLoading = false, navigateToPost = null;

  LoadedPostRequestsListPageUiState copyWith({bool? isLoading, IList<PostRequestUiState>? postRequests, Option<String?>? navigateToPost}) {
    return LoadedPostRequestsListPageUiState(
      isLoading: isLoading ?? this.isLoading,
      postRequests: postRequests ?? this.postRequests,
      navigateToPost: Option.resolveWithFallback(navigateToPost, this.navigateToPost),
    );
  }


  final bool isLoading;
  final IList<PostRequestUiState> postRequests;
  final String? navigateToPost;
}
