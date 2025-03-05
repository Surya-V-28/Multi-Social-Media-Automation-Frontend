import 'package:business_logic/business_logic.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:post_scheduler/post_scheduler/common/widgets/post_request_list_tile/post_request_list_tile.dart';
import 'package:post_scheduler/post_scheduler/screens/post_requests_calendar_page/viewmodel/post_requests_calendar_page_view_model.dart';
import 'package:post_scheduler/utils/side_effect.dart';

import 'viewmodel/ui_state/post_requests_calendar_page_ui_state.dart';
import 'viewmodel/view_model_factory.dart';
import 'widgets/calendar/calendar.dart';

class PostRequestsCalendarPage extends StatefulWidget {
  const PostRequestsCalendarPage({super.key});

  @override
  State<PostRequestsCalendarPage> createState() => _PostRequestsCalendarPageState();
}

class _PostRequestsCalendarPageState extends State<PostRequestsCalendarPage> {
  @override
  void initState() {
    super.initState();

    _viewModel.opened();

    _navigateToPostRequestsListPageSideEffect = SideEffect<DateTime?>(
      observee: _viewModel.uiState.map((element) => element.navigatingToPostRequestsListPage),
      doWhen: (previous, current) => current != previous && current != null,
      sideEffect: (value) {
        GoRouter.of(context).push('/calendar/${value.toString()}')
          .then((result) => _viewModel.opened());

        _viewModel.navigatedToPostRequestsListPage();
      },
    );

    _navigateToPostRequestDetailsPageSideEffect = SideEffect<String?>(
      observee: _viewModel.uiState.map((element) => element.navigatingToPostRequestDetailsPage),
      doWhen: (previous, current) => current != previous && current != null,
      sideEffect: (value) {
        GoRouter.of(context).push('/post-requests/$value')
          .then((result) => _viewModel.opened());
        
        _viewModel.navigatedToPostRequestDetailsPage();
      }
    );

    _navigateToAddPostRequestPageSideEffect = SideEffect<bool>(
      observee: _viewModel.uiState.map((element) => element.navigatingToAddPostRequestPage),
      doWhen: (previous, current) => current != previous && current == true,
      sideEffect: (value) {
        GoRouter.of(context).push('/post-requests/add')
          .then((result) => _viewModel.opened());

        _viewModel.navigatedToAddPostRequestPage();
      },
    );

    _navigateToNotificationsPageSideEffect = SideEffect<bool>(
      observee: _viewModel.uiState.map((element) => element.navigatingToNotificationsPage),
      doWhen: (previous, current) => current != previous && current == true,
      sideEffect: (value) {
        GoRouter.of(context).push('/notifications')
          .then((result) => _viewModel.opened());

        _viewModel.navigatedToNotificationsPage();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return StreamBuilder<PostRequestsCalendarPageUiState>(
      stream: _viewModel.uiState,
      builder: (context, snapshot) {
        final PostRequestsCalendarPageUiState? uiState = snapshot.data;

        if (uiState == null) {
          return const SizedBox.shrink();
        }

        return Stack(
          children: [
            Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: const Text('Scheduled Posts'),
                actions: <Widget>[
                  IconButton(
                    onPressed: () => _viewModel.notificationsButtonClicked(),
                    icon: const Icon(Icons.notifications_on),
                  ),

                  IconButton(
                    onPressed: () => _viewModel.addPostRequestButtonClicked(),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              drawer: Drawer(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  children: [
                    ListTile(
                      onTap: () async {
                        GoRouter.of(context).push('/platform-connections');
                        _scaffoldKey.currentState!.closeDrawer();
                      },
                      title: const Text('Connections'),
                    ),

                    ListTile(
                      onTap: () async {
                        GoRouter.of(context).push('/media-library');
                        _scaffoldKey.currentState!.closeDrawer();
                      },
                      title: const Text('Media Library'),
                    ),
                
                    ListTile(
                      onTap: () async {
                        await GetIt.instance<SignOutInteractor>().signOut();
                        if (!context.mounted) return;
                
                        GoRouter.of(context).go('/auth/login');
                      },
                      title: const Text('Sign Out'),
                    ),
                  ],
                ),
              ),
              body: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Calendar(
                              year: uiState.month.year,
                              onYearChanged: (value) => _viewModel.changeMonth(DateTime(value, uiState.month.month)),
                              month: uiState.month.month,
                              onMonthChanged: (value) => _viewModel.changeMonth(DateTime(uiState.month.year, value)),
                              itemBuilder: (date) {
                                return DateButton(
                                  highlighted: uiState.highlightedDates.contains(date),
                                  onPressed: () => _viewModel.dateButtonClicked(date),
                                  child: Text(date.day.toString()),
                                );
                              }
                            ),
                          ),
                        ),
                          
                        const SizedBox(height: 32.0),
                          
                        Text("Today's Posts", style: theme.textTheme.headlineMedium),
                          
                        const SizedBox(height: 16.0),
                  
                        if (uiState.todaysPostRequests.isEmpty)
                          const Padding(
                            padding: EdgeInsets.only(top: 16.0),
                            child: Text("No posts today"),
                          ),
                          
                        ...uiState.todaysPostRequests
                          .map(
                            (element) => PostRequestListTile(
                              key: Key(element.id),
                              scheduledDateTime: element.scheduledDateTime,
                              isFulfilled: element.isFulfilled,
                              caption: element.caption, 
                              platforms: element.platforms.toList(),
                              onTap: () => _viewModel.postRequestOnClicked(element.id),
                            )
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            if (uiState.isLoading)
              Positioned.fill(
                child: ColoredBox(
                  color: Colors.black.withValues(alpha: 0.8),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        );
      }
    );
  }

  @override
  void dispose() {
    _navigateToPostRequestDetailsPageSideEffect.dispose();
    _navigateToPostRequestsListPageSideEffect.dispose();
    _navigateToAddPostRequestPageSideEffect.dispose();
    _navigateToNotificationsPageSideEffect.dispose();

    super.dispose();
  }


  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late final SideEffect<DateTime?> _navigateToPostRequestsListPageSideEffect;
  late final SideEffect<String?> _navigateToPostRequestDetailsPageSideEffect;
  late final SideEffect<bool> _navigateToAddPostRequestPageSideEffect;
  late final SideEffect<bool> _navigateToNotificationsPageSideEffect;

  final PostRequestsCalendarPageViewModel _viewModel = GetIt.instance<ViewModelFactory>().build();
}
