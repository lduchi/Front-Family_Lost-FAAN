import 'package:flutter/material.dart';
import 'package:familylost_faan/pages/cubit/bottom_nav_cubit.dart';
import 'package:familylost_faan/utilities/Colors/app_colors.dart';
import 'package:familylost_faan/utilities/app_painter.dart';
import 'package:familylost_faan/utilities/fonts/app_fonts.dart';
import 'package:familylost_faan/utilities/icons/app_icons.dart';
import 'package:familylost_faan/utilities/texts/app_strings.dart';
import 'package:familylost_faan/utilities/AssetManager/asset_manager.dart';
import 'package:familylost_faan/pages/pages.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:familylost_faan/pages/profile_page.dart'; // Importa la página del perfil

import '../Utils/colors.dart';
import '../Utils/colors.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  var _deviceHeight;
  var _deviceWidth;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  // List of Pages: Home, Search, Profile
  final List<Widget> pages = [
    HomePage(),
    FavoritePage(),
    HomePage(),
    HomePage(),
    ProfilePage(),
  ];

  void onPageChanged(int page) {
    BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _mainWrapperAppBar(),
      body: CustomPaint(
        // painter: AppPainter(),
        child: _mainWrapperBody(),
      ),
      bottomNavigationBar: _mainWrapperBottomNavBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _mainWrapperFab(),
    );
  }

  AppBar _mainWrapperAppBar() {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: Colors.transparent, // COLOR BACKGROUND
      title: const Text('Hola, Usuario!'),
      leading: Center(
        child: CircleAvatar(
          radius: 16,
          backgroundImage: AssetImage(AssetManager.exampleImage),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(_deviceHeight * 0.1),
        child: Container(
          padding: EdgeInsets.all(_deviceWidth * 0.04),
          child: Row(
            children: [
              _buildOutlinedButton(
                AppStrings.navigationLost,
                () {
                  // TODO: Implementar filtro de "Lost"
                },
              ),
              const SizedBox(width: 8),
              const Spacer(),
              _buildOutlinedButton(
                AppStrings.navigationFound,
                () {
                  // TODO: Implementar filtro de "Found"
                },
              ),
              const SizedBox(width: 8),
              const Spacer(),
              _buildOutlinedButton(
                AppStrings.navigationAdoption,
                () {
                  // TODO: Implementar filtro de "Adoption"
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: AppIcons.notificationIcon,
        ),
      ],
    );
  }

  OutlinedButton _buildOutlinedButton(String text, VoidCallback onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  BottomAppBar _mainWrapperBottomNavBar(BuildContext context) {
    return BottomAppBar(
      notchMargin: 5,
      shape: CircularNotchedRectangle(),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _bottomAppBarItem(
                  context,
                  defaultIcon: IconlyLight.home,
                  page: 0,
                  label: "Home",
                  filledIcon: IconlyBold.home,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _bottomAppBarItem(
                  context,
                  defaultIcon: IconlyLight.search,
                  page: 1,
                  label: "Search",
                  filledIcon: IconlyBold.search,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _bottomAppBarItem(
                  context,
                  defaultIcon: IconlyLight.notification,
                  page: 2,
                  label: "Third Page",
                  filledIcon: IconlyBold.notification,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _bottomAppBarItem(
                  context,
                  defaultIcon: IconlyLight.profile,
                  page: 4, // Cambia la página a 4 para el perfil
                  label: "Profile",
                  filledIcon: IconlyBold.profile,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  FloatingActionButton _mainWrapperFab() {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              insetPadding: EdgeInsets.zero,
              child: CreatePublicationPage(),
            );
          },
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      backgroundColor: AppColors.mainColor,
      child: const Icon(Icons.add),
    );
  }

  // Body - MainWrapper Widget
  PageView _mainWrapperBody() {
    return PageView(
      onPageChanged: (int page) => onPageChanged(page),
      controller: pageController,
      children: pages,
    );
  }

  // Bottom Navigation Bar Single item - MainWrapper Widget
  Widget _bottomAppBarItem(
    BuildContext context, {
    required defaultIcon,
    required page,
    required label,
    required filledIcon,
  }) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(page);

        pageController.animateToPage(page,
            duration: const Duration(milliseconds: 10),
            curve: Curves.fastLinearToSlowEaseIn);
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 5,
            ),
            Icon(
              context.watch<BottomNavCubit>().state == page
                  ? filledIcon
                  : defaultIcon,
              color: context.watch<BottomNavCubit>().state == page
                  ? AppColors.mainColor
                  : Colors.grey,
              size: 26,
            ),
            const SizedBox(
              height: 1,
            ),
            Text(
              label,
              style: AppFonts.navigation.copyWith(
                color: context.watch<BottomNavCubit>().state == page
                    ? AppColors.mainColor
                    : Colors.grey,
                fontWeight: context.watch<BottomNavCubit>().state == page
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
