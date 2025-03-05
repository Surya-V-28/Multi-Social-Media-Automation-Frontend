import 'package:business_logic/business_logic.dart';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:get_it/get_it.dart';

NotificationsPageViewModel useViewModel() {
  final getUsersNotificationsInteractor = GetIt.instance<GetUserNotificationsInteractor>();

  final loading = useState<bool>(true);
  final notifications = useState<IList<Notification>>(const IList.empty());
  final navigatingToScheduledPostPage = useState<String?>(null);

  return NotificationsPageViewModel(
    pageOpened: () async {
      final fetchedNotifications = await getUsersNotificationsInteractor.perform();
      notifications.value = fetchedNotifications.toIList();
    },
    postedScheduledPostNotificationClicked: (id) {
      navigatingToScheduledPostPage.value = notifications.value
        .firstWhere((e) => e.id == id)
        .details!['id'];
    },
    navigatedToScheduledPostPage: () => navigatingToScheduledPostPage.value = null,

    loading: loading.value,
    notifications: notifications.value,
    navigatingToScheduledPostPage: navigatingToScheduledPostPage.value,
  );
}

class NotificationsPageViewModel {
  const NotificationsPageViewModel({
    required this.pageOpened,
    required this.postedScheduledPostNotificationClicked,
    required this.navigatedToScheduledPostPage,

    required this.loading,
    required this.notifications,
    required this.navigatingToScheduledPostPage,
  });



  final void Function() pageOpened;
  final void Function(String id) postedScheduledPostNotificationClicked;
  final void Function() navigatedToScheduledPostPage;

  final bool loading;
  final IList<Notification> notifications;
  final String? navigatingToScheduledPostPage;
}
