import 'package:familylost_faan/pages/cubit/bottom_nav_cubit.dart';
import 'package:familylost_faan/widgets/main_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Screen/splash_screen.dart';

void main() => runApp(const LostFamilyApp());

class LostFamilyApp extends StatelessWidget {
  const LostFamilyApp({super.key});
/*
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(13, 71, 161, 1),
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(13, 71, 161, 1),
          brightness: Brightness.dark,
        ),
      ),
      home: BlocProvider(
        create: (context) => BottomNavCubit(),
        child: const MainWrapper(),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MySplashScreen(),
    );
  }

}
