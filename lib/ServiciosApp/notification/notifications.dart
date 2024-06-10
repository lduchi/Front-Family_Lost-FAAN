import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:familylost_faan/ServiciosApp/interceptors/store.dart';
import 'package:familylost_faan/ServiciosApp/services/user_service.dart';
import 'package:familylost_faan/utilities/texts/app_strings.dart';

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

Future<void> createdPostNotification(Map<String, dynamic> post) async {
  String imageUrl = post['imageUrl'].toString().replaceFirst('http', 'https');

  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'basic_channel',
      title: '${Emojis.animals_paw_prints} ${AppStrings.notifTitleNewPost}',
      body: '${post['title']}',
      bigPicture: imageUrl,
      largeIcon: imageUrl,
      hideLargeIconOnExpand: true,
      notificationLayout: NotificationLayout.BigPicture,
      wakeUpScreen: true,
    ),
  );
}

Future<void> likedPostNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'basic_channel',
      title: '${Emojis.emotion_red_heart} ${AppStrings.notifTitleNewLike}',
      body: 'Someone liked your post',
    ),
  );
}

Future<void> scheduledNotification() async {
  String localTimeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'scheduled_channel',
      title: '${Emojis.animals_paw_prints} ${AppStrings.notifTitleScheduled}',
      body: '${AppStrings.notifBodyScheduled}',
      wakeUpScreen: true,
      category: NotificationCategory.Message,
    ),
    schedule: NotificationCalendar(
      weekday: DateTime.sunday,
      hour: 10,
      minute: 00,
      second: 00,
      millisecond: 0,
      timeZone: localTimeZone,
      repeats: true,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'OPEN',
        label: '${AppStrings.notifScheduledeAccept}',
      ),
    ],
  );
}

Future<void> cancelScheduledNotification() async {
  await AwesomeNotifications().cancelAllSchedules();
}

Future<void> getAndSetAuthor() async {
  final username = await Store.getUserName();

  final author = await UserService().getAuthorByUsername(username ?? '');

  Store.setAuthor(author);
}