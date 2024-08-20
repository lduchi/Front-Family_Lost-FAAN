import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:familylost_faan/Screen/onboarding/on_boarding_screen.dart';
import 'package:familylost_faan/ServiciosApp/interceptors/store.dart';
import 'package:familylost_faan/ServiciosApp/services/home_service.dart';
import 'package:familylost_faan/ServiciosApp/services/notification_service.dart';
import 'package:familylost_faan/ServiciosApp/services/search_service.dart';
import 'package:familylost_faan/ServiciosApp/services/sponsor_service.dart';
import 'package:familylost_faan/pages/cubit/bottom_nav_cubit.dart';
import 'package:familylost_faan/widgets/main_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'ServiciosApp/services/liked_post_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
        ChangeNotifierProvider(create: (_) => NotificationPageProvider())
      ],
      child: LostFamilyApp(),
    ),
  );
}

class LostFamilyApp extends StatefulWidget {
  const LostFamilyApp({super.key});

  @override
  State<StatefulWidget> createState() => _LostFamilyAppState();
}

class _LostFamilyAppState extends State<LostFamilyApp> {
  bool? isLoggedIn;

  @override
  void initState() {
    _initializeLoggedIn();

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn!
          ? MultiProvider(
              providers: [
                BlocProvider(create: (context) => BottomNavCubit()),
                ChangeNotifierProvider(create: (_) => HomePageProvider('LOST')),
                ChangeNotifierProvider(create: (_) => LikePostProvider()),
                ChangeNotifierProvider(create: (_) => SearchService()),
              ],
              child: MainWrapper(isLoggedIn: isLoggedIn!),
            )
          : ChangeNotifierProvider(
              create: (_) => SponsorPageProvider(),
              child: OnBoardingScreen(),
            ),
    );
  }

  Future<void> _initializeLoggedIn() async {
    bool? loggedIn = await Store.isLogged();
    setState(() {
      isLoggedIn = loggedIn ?? false;
    });
  }
}
