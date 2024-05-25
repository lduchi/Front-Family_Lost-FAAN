import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:familylost_faan/ServiciosApp/interceptors/store.dart';
import 'package:familylost_faan/ServiciosApp/web_socket/web_socket.dart';
import 'package:familylost_faan/pages/cubit/bottom_nav_cubit.dart';
import 'package:familylost_faan/widgets/main_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'Screen/onboarding/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool isLoggedIn = await Store.isLogged() ?? false;

  AwesomeNotifications().initialize(
    'resource://drawable/res_app_icon',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel of FAAN',
        importance: NotificationImportance.High,
        soundSource: 'resource://raw/res_custom_sound',
      ),
      NotificationChannel(
        channelKey: 'scheduled_channel',
        channelName: 'Scheduled Notifications',
        channelDescription: 'Notification scheduled channel of FAAN',
        defaultColor: Colors.teal,
        importance: NotificationImportance.High,
        soundSource: 'resource://raw/res_custom_sound',
      ),
    ],
    debug: true,
  );

  runApp(
    MultiProvider(
      providers: [
        Provider<BottomNavCubit>(
          create: (_) => BottomNavCubit(),
        ),
      ],
      child: LostFamilyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class LostFamilyApp extends StatefulWidget {
  final bool isLoggedIn;

  const LostFamilyApp({super.key, required this.isLoggedIn});

  @override
  State<StatefulWidget> createState() => _LostFamilyAppState(isLoggedIn: isLoggedIn);
}

class _LostFamilyAppState extends State<LostFamilyApp> {
  final bool isLoggedIn;

  _LostFamilyAppState({required this.isLoggedIn});

  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? MainWrapper(isLoggedIn: isLoggedIn) : MySplashScreen(),
    );
  }
}
