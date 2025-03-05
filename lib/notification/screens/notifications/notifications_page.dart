import 'package:business_logic/business_logic.dart';
import 'package:dart_scope_functions/dart_scope_functions.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'components/notification_list_tile.dart';
import 'view_model.dart';

class NotificationsPage extends HookWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = useViewModel();

    useEffect(
      () {
        viewModel.pageOpened();
        return null;
      },
      [],
    );

    useEffect(
      () {
        print('CustoLog: Hooks running');

        if (viewModel.navigatingToScheduledPostPage == null) return null;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          GoRouter.of(context).push('/post-requests/${viewModel.navigatingToScheduledPostPage!}');
          viewModel.navigatedToScheduledPostPage();
        });

        return null;
      },
      [viewModel.navigatingToScheduledPostPage],
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: viewModel.notifications.let((notifications) {
        if (notifications.isEmpty) {
          return const Center(
            child: Text('No notifications'),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          itemCount: viewModel.notifications.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            return _buildListTile(viewModel, viewModel.notifications[index]);
          },
        );
      }),
    );
  }

  Widget _buildListTile(NotificationsPageViewModel viewModel, Notification notification) {
    if (notification.type == 'posted_scheduled_post') {
      return NotificationListTile(
        key: Key(notification.id),
        leading: const Icon(Icons.post_add),
        message: notification.message,
        createdAt: notification.createdAt,
        onTap: () => viewModel.postedScheduledPostNotificationClicked(notification.id),
      );
    }
    
    throw AssertionError("Invalid Notification type ${notification.type}");
  }
}
