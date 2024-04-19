import 'package:familylost_faan/pages/dashboard_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const LostFamilyApp());

class LostFamilyApp extends StatelessWidget {
  const LostFamilyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.pink[900],
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.pink[900],
      ),
      home: const DashBoardPage(),
    );
  }
}
