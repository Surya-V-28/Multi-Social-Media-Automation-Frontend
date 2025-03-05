
import 'package:business_logic/business_logic.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:post_scheduler/utils/option.dart';

class PostRequestsCalendarPageUiState {
  const PostRequestsCalendarPageUiState({
    required this.isLoading,
    required this.month,
    required this.highlightedDates,
    required this.todaysPostRequests,
    required this.navigatingToPostRequestDetailsPage,
    required this.navigatingToPostRequestsListPage,
    required this.navigatingToAddPostRequestPage,
    required this.navigatingToPlatformConnectionsPage,
    required this.navigatingToNotificationsPage,
  });

  PostRequestsCalendarPageUiState.initial() :
    isLoading = true,
    month = DateTime(DateTime.now().year, DateTime.now().month, 1),
    highlightedDates = const IList.empty(),
    todaysPostRequests = const IList.empty(),
    navigatingToPostRequestDetailsPage = null,
    navigatingToPostRequestsListPage = null,
    navigatingToAddPostRequestPage = false,
    navigatingToPlatformConnectionsPage = false,
    navigatingToNotificationsPage = false;

  PostRequestsCalendarPageUiState copyWith({
    bool? isLoading,
    DateTime? month,
    IList<DateTime>? highlightedDates,
    IList<PostRequestUiState>? todaysPostRequests,
    Option<String?>? navigatingToPostRequestDetailsPage,
    Option<DateTime?>? navigatingToPostRequestsListPage,
    bool? navigatingToAddPostRequestPage,
    bool? navigatingToPlatformConnectionsPage,
    bool? navigatingToNotificationsPage,
  }) {
    return PostRequestsCalendarPageUiState(
      isLoading: isLoading ?? this.isLoading,
      month: month ?? this.month,
      highlightedDates: highlightedDates ?? this.highlightedDates,
      todaysPostRequests: todaysPostRequests ?? this.todaysPostRequests,
      navigatingToPostRequestDetailsPage: Option.resolveWithFallback(
        navigatingToPostRequestDetailsPage,
        this.navigatingToPostRequestDetailsPage,
      ),
      navigatingToPostRequestsListPage: Option.resolveWithFallback(
        navigatingToPostRequestsListPage,
        this.navigatingToPostRequestsListPage
      ),
      navigatingToAddPostRequestPage: navigatingToAddPostRequestPage ?? this.navigatingToAddPostRequestPage,
      navigatingToPlatformConnectionsPage: navigatingToPlatformConnectionsPage ?? this.navigatingToPlatformConnectionsPage,
      navigatingToNotificationsPage: navigatingToNotificationsPage ?? this.navigatingToNotificationsPage,
    );
  }



  final bool isLoading;
  final DateTime month;
  final IList<DateTime> highlightedDates;
  final IList<PostRequestUiState> todaysPostRequests;
  final String? navigatingToPostRequestDetailsPage;
  final DateTime? navigatingToPostRequestsListPage;
  final bool navigatingToAddPostRequestPage;
  final bool navigatingToPlatformConnectionsPage;
  final bool navigatingToNotificationsPage;
}

class PostRequestUiState {
  const PostRequestUiState({
    required this.id,
    required this.scheduledDateTime,
    required this.isFulfilled,
    required this.caption,
    required this.platforms,
  });


  final String id;
  final DateTime scheduledDateTime;
  final bool isFulfilled;
  final String caption;
  final IList<SocialMediaPlatform> platforms;
}
