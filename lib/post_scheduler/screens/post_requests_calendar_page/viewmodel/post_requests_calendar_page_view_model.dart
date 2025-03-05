import 'dart:async';

import 'package:business_logic/business_logic.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:post_scheduler/utils/option.dart';
import 'package:rxdart/rxdart.dart';

import 'ui_state/post_requests_calendar_page_ui_state.dart';

class PostRequestsCalendarPageViewModel {
  PostRequestsCalendarPageViewModel(this._getPostRequestsInteractor);

  void opened() async {
    final DateTime nowDateTime = DateTime.now();
    final List<ScheduledPost> entireMonthPostRequests = await _getPostRequestsInteractor.get(
      fromTime: DateTime(nowDateTime.year, nowDateTime.month, 1),
      toTime: DateTime(nowDateTime.year, nowDateTime.month + 1, 1),
    );

    final List<ScheduledPost> todaysPostRequests = entireMonthPostRequests
      .where(
        (element) {
          final DateTime todaysDate = DateTime(nowDateTime.year, nowDateTime.month, nowDateTime.day);
          final DateTime postRequestScheduledDate = DateTime(element.scheduledTime.year, element.scheduledTime.month, element.scheduledTime.day);

          return postRequestScheduledDate == todaysDate;
        }
      )
      .toList();
    
    _uiState.value = _uiState.value.copyWith(
      isLoading: false,
      highlightedDates: _getHighlightedDatesFromPostRequests(entireMonthPostRequests),
      todaysPostRequests: todaysPostRequests.map(_mapPostRequestToUiState).toIList(),
    );
  }

  void changeMonth(DateTime month) {
    _uiState.add(_uiState.value.copyWith(month: month),);

    _changeDateReactionTimer?.cancel();

    _changeDateReactionTimer = Timer(const Duration(seconds: 1), () async {
      _uiState.add(_uiState.value.copyWith(isLoading: true,),);

      final month = _uiState.value.month;
      final postRequests = await _getPostRequestsInteractor.get(fromTime: month, toTime: DateTime(month.year, month.month + 1, 1),);

      _uiState.add(_uiState.value.copyWith(highlightedDates: _getHighlightedDatesFromPostRequests(postRequests), isLoading: false,),);

      _changeDateReactionTimer = null;
    });
  }

  void postRequestOnClicked(String id) {
    _uiState.value = _uiState.value.copyWith(navigatingToPostRequestDetailsPage: Option(id));
  }

  void dateButtonClicked(DateTime date) {
    _uiState.value = _uiState.value.copyWith(navigatingToPostRequestsListPage: Option(date));
  }

  void addPostRequestButtonClicked() {
    _uiState.value = _uiState.value.copyWith(navigatingToAddPostRequestPage: true);
  }

  void navigatedToPostRequestsListPage() {
    _uiState.value = _uiState.value.copyWith(navigatingToPostRequestsListPage: const Option(null));
  }

  void navigatedToPostRequestDetailsPage() {
    _uiState.value = _uiState.value.copyWith(navigatingToPostRequestDetailsPage: const Option(null));
  }

  void navigatedToAddPostRequestPage() {
    _uiState.value = _uiState.value.copyWith(navigatingToAddPostRequestPage: false);
  }

  void toConnectionsPageButtonClicked() {
    _uiState.add(_uiState.value.copyWith(navigatingToPlatformConnectionsPage: true,));
  }

  void navigatedToPlatformConnectionsPage() {
    _uiState.add(_uiState.value.copyWith(navigatingToPlatformConnectionsPage: false,));
  }

  void notificationsButtonClicked() {
    _uiState.add(_uiState.value.copyWith(navigatingToNotificationsPage: true,));
  }

  void navigatedToNotificationsPage() {
    _uiState.add(_uiState.value.copyWith(navigatingToNotificationsPage: false,));
  }

  Stream<PostRequestsCalendarPageUiState> get uiState => _uiState;

  IList<DateTime> _getHighlightedDatesFromPostRequests(List<ScheduledPost> postRequests) {
    Set<DateTime> highlightedDates = <DateTime>{};
    for (final postRequest in postRequests) {
        final DateTime scheduledDate = DateTime(postRequest.scheduledTime.year, postRequest.scheduledTime.month, postRequest.scheduledTime.day);
        highlightedDates.add(scheduledDate);
    }

    return highlightedDates.toIList();
  }

  PostRequestUiState _mapPostRequestToUiState(ScheduledPost businessLogicModel) {
    return PostRequestUiState(
      id: businessLogicModel.id,
      scheduledDateTime: businessLogicModel.scheduledTime,
      caption: businessLogicModel.caption ?? "",
      isFulfilled: businessLogicModel.isFulfilled,
      platforms: businessLogicModel.targets
        .map((target) => target.targetType.platform)
        .toIList(),
    );
  }


  final BehaviorSubject<PostRequestsCalendarPageUiState> _uiState = BehaviorSubject.seeded(PostRequestsCalendarPageUiState.initial());

  Timer? _changeDateReactionTimer;

  final GetPostRequestsInteractor _getPostRequestsInteractor;
}
