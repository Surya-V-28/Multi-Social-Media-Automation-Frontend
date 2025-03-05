import 'package:business_logic/business_logic.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:post_scheduler/utils/option.dart';
import 'package:rxdart/rxdart.dart';

import 'ui_state.dart';

class ScheduledPostDetailsPageViewModel {
  ScheduledPostDetailsPageViewModel(this.id, this._getScheduledPostInteractor,);

  void pageOpened() async {
    final scheduledPost = await _getScheduledPostInteractor.get(id);
    uiState.add(
      uiState.value.copyWith(
        id: scheduledPost.id,
        isFulfilled: scheduledPost.isFulfilled,
        postTargets: scheduledPost.targets
          .map((target) => PostTargetUiState(id: target.id, type: target.targetType, createdPostId: target.createdPostId),)
          .toIList(),
        isLoading: false,
      ),
    );
  }

  void postTargetButtonClicked(String id) {
    final postTarget = uiState.value.postTargets
        .firstWhere((postTarget) => postTarget.id == id);

    final String postTargetTypeUrl = switch (postTarget.type) {
      PostTargetType.facebookPage => 'facebook-page',
      PostTargetType.instagramFeed => 'instagram-feed',
      PostTargetType.instagramStory => 'instagram-story'
    };

    final pageUrl = 'application://post_scheduler/analytics/$postTargetTypeUrl/${uiState.value.id}/${postTarget.id}';
    uiState.add(uiState.value.copyWith(navigatingToPostTargetUrl: Option(pageUrl),));
  }

  void navigatedToPostTargetStatisticsPage() {
    uiState.add( uiState.value.copyWith(navigatingToPostTargetUrl: const Option(null)) );
  }

  final uiState = BehaviorSubject.seeded(const ScheduledPostDetailsPageUiState.initial());


  final String id;


  final GetScheduledPostInteractor _getScheduledPostInteractor;
}
