import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:post_scheduler/utils/option.dart';
import 'package:rxdart/rxdart.dart';

import 'post_request_retriever.dart';
import 'ui_state/post_request_ui_state.dart';
import 'ui_state/ui_state.dart';

class PostRequestsListPageViewModel {
  PostRequestsListPageViewModel({required PostRequestRetriever postRequestRetriever, PostRequestsListPageUiState? initialUiState}) :
    _postRequestRetriever = postRequestRetriever,
    uiState = BehaviorSubject<PostRequestsListPageUiState>.seeded(initialUiState ?? const InitialLoadingPostRequestsListPageUiState());

  Future<void> pageOpened(DateTime date) async {
    final IList<PostRequestUiState> postRequests = await _postRequestRetriever.retrieve(date);

    uiState.add( LoadedPostRequestsListPageUiState.initial(postRequests: postRequests) );
  }

  void postRequestClicked(String id) async {
    final LoadedPostRequestsListPageUiState loadedUiState = uiState.value as LoadedPostRequestsListPageUiState;
    uiState.add(loadedUiState.copyWith(navigateToPost: Option(id)));
  }

  void navigatedToPost() {
    final LoadedPostRequestsListPageUiState loadedUiState = uiState.value as LoadedPostRequestsListPageUiState;

    uiState.add( loadedUiState.copyWith(navigateToPost: const Option(null)) );
  }


  
  final BehaviorSubject<PostRequestsListPageUiState> uiState;

  final PostRequestRetriever _postRequestRetriever;
} 
