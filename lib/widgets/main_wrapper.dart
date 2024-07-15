import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:familylost_faan/Screen/Sign_In_Up/RegisterPage.dart';
import 'package:familylost_faan/Screen/Sign_In_Up/sign_in.dart';
import 'package:familylost_faan/ServiciosApp/dto/animal.dart';
import 'package:familylost_faan/ServiciosApp/dto/save_post.dart';
import 'package:familylost_faan/ServiciosApp/notification/notifications.dart';
import 'package:familylost_faan/ServiciosApp/services/post_service.dart';
import 'package:familylost_faan/ServiciosApp/web_socket/web_socket.dart';
import 'package:familylost_faan/pages/cubit/bottom_nav_cubit.dart';
import 'package:familylost_faan/pages/information_faan.dart';
import 'package:familylost_faan/pages/pages.dart';
import 'package:familylost_faan/profile/Menu_profile.dart';
import 'package:familylost_faan/utilities/AssetManager/asset_manager.dart';
import 'package:familylost_faan/utilities/Colors/app_colors.dart';
import 'package:familylost_faan/utilities/Fonts/app_fonts.dart';
import 'package:familylost_faan/utilities/enum/dialog_type.dart';
import 'package:familylost_faan/utilities/icons/app_icons.dart';
import 'package:familylost_faan/utilities/texts/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import '../Utils/colors.dart';

final postService = PostService();
late SavePost posts;

Animal animalDatas = Animal(name: "Otis", type: "Dog", race: "Bulldog", gender: "Macho");
//tipo de p[ost en home lost, found,adoption y el estado lost
// estaod de la publicacion found (rescatados)
///revisar si adpodet se puede integrar en rescatos
class MainWrapper extends StatefulWidget {
  final bool isLoggedIn;

  const MainWrapper({super.key, required this.isLoggedIn});

  @override
  State<MainWrapper> createState() => _MainWrapperState(isLoggedIn: isLoggedIn);
}

class _MainWrapperState extends State<MainWrapper> {
  final bool isLoggedIn;
  var _deviceHeight;
  var _deviceWidth;
  late PageController pageController;
  late WebSocketChnl webSocket;
  late List<Widget> pages;

  _MainWrapperState({required this.isLoggedIn});

  @override
  void initState() {
    super.initState();
    pageController = PageController();

    if (isLoggedIn) {
      initializeWebSocket();

      scheduledNotification();

      getAndSetAuthor();

      AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Allow Notifications'),
              content: Text('Our app would like to send you notifications'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Don\'t Allow',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () => AwesomeNotifications()
                        .requestPermissionToSendNotifications()
                        .then((_) => Navigator.pop(context)),
                    child: Text(
                      'Allow',
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
              ],
            ),
          );
        }
      });
    }
    pages = [
      HomePage(
        animalData: animalDatas,
        isLogin: isLoggedIn,
      ),
      FavoritePage(),
      HomePage(
        animalData: animalDatas,
        isLogin: isLoggedIn,
      ),
      ProfilePage(),
    ];
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int page) {
    BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: //isLoggedIn
           _appBarBuilder(context.watch<BottomNavCubit>().state.toDouble()),
          //: _mainUnloggedWrapperAppBar(),
      drawer: MenuProfile(isLogged: isLoggedIn),
      body: CustomPaint(
        child: _mainWrapperBody(),
      ),
      bottomNavigationBar: _mainWrapperBottomNavBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _mainWrapperFab(context, isLoggedIn),
    );
  }

  AppBar _appBarBuilder(double indexPage) {
    return indexPage == 3 ? _profileAppBar() : _mainLoggedWrapperAppBar();
  }

  AppBar _profileAppBar() {
    return AppBar(
      backgroundColor: AppColors.secondaryMainColor,
      foregroundColor: AppColors.mainColor,
      elevation: 0,
      shadowColor: Colors.black.withOpacity(0.5),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NotificationPage()));
          },
          icon: AppIcons.notificationIconFill,
          color: AppColors.mainColor,
        ),
      ],
    );
  }

  AppBar _mainLoggedWrapperAppBar() {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return AppBar(
      title: Row(
        // Contains the logo of the app
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(
            image: AssetImage(AssetManager.largeLogo),
            height: _deviceHeight * 0.2,
            width: _deviceWidth * 0.4,
          ),
        ],
      ),
      automaticallyImplyLeading: false,
      // Delete white space in the left side of the AppBar - If you want to add a leading widget, set it to true
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: AppColors.secondaryMainColor,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(_deviceHeight * 0.1),
        child: Container(
          padding: EdgeInsets.all(_deviceWidth * 0.04),
          child: Row(
            children: [
              _buildOutlinedButton(
                AppStrings.navigationLost,
                () {},
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
                  animalDatas = Animal(
                      name: "",
                      type: "",
                      race: "",
                      gender: ""); // Inicializar+ aquí

                  // Navegar a la página HomePage con los nuevos datos
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => BottomNavCubit(),
                        child: const MainWrapper(isLoggedIn: true),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
     /* actions: [
        IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NotificationPage()));
          },
          icon: AppIcons.notificationIconFill,
          color: AppColors.mainColor,
        ),
      ],*/
    );
  }

  AppBar _mainUnloggedWrapperAppBar() {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Row(
        // Contains the logo of the app
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            AppStrings.homeTitle,
            style: GoogleFonts.poppins(
              color: AppColors.mainColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      iconTheme: IconThemeData(
        color: AppColors.mainColor,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: AppColors.secondaryMainColor,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(_deviceHeight * 0.1),
        child: Container(
          padding: EdgeInsets.all(_deviceWidth * 0.04),
          child: Row(
            children: [
              /*   _buildOutlinedButton(
                AppStrings.navigationLost,
                () {
                  // TODO: Implementar filtro de "Lost"
                },
              ),*/
              const SizedBox(width: 5),
              /* const Spacer(),
              _buildOutlinedButton(
                AppStrings.navigationFound,
                () {
                  // TODO: Implementar filtro de "Found"
                },
              ),*/
              const SizedBox(width: 5),
              const Spacer(),
              /*_buildOutlinedButton(
                AppStrings.navigationAdoption,
                () {
                  // TODO: Implementar filtro de "Adoption"
                },
              ),*/
            ],
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const InformationFaan()),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(7.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 249, 248, 248)
                        .withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Image.asset(
                "images/icon.png",
              ),
            ),
          ),
        ),
      ],
    );
  }

  OutlinedButton _buildOutlinedButton(String text, VoidCallback onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: AppFonts.primary.copyWith(
          color: AppColors.secondaryMainColor,
        ),
      ),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size(60, 45)),
        backgroundColor: MaterialStateProperty.all<Color>(
            AppColors.mainColor.withOpacity(0.6)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(
            color: AppColors.mainColor,
            width: 0.5,
          ),
        ),
        shadowColor: MaterialStateProperty.all<Color>(
          AppColors.mainColor.withOpacity(0.6),
        ),
      ),
    );
  }

  BottomAppBar _mainWrapperBottomNavBar(BuildContext context) {
    return BottomAppBar(
      notchMargin: 5,
      shape: CircularNotchedRectangle(),
      color: Colors.white,
      child: isLoggedIn ? _loggedIn() : _unLogged(),
    );
  }

  Row _loggedIn() {
    return Row(
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
                label: "Rescatados",
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
                page: 3,
                label: "Profile",
                filledIcon: IconlyBold.profile,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Padding _unLogged() {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 2,
      ),
      child: Container(
        height: size.height * 0.08,
        width: size.width / 2.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: backgroundColor3.withOpacity(0.9),
          border: Border.all(
            color: general,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 0,
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignIn(),
                    ),
                  );
                },
                child: Container(
                  height: size.height * 0.15, // Ajuste del tamaño del botón
                  width: size.width / 2.2,
                  decoration: BoxDecoration(
                    color: general,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      AppStrings.login,
                      style: AppFonts.button.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18, // Ajuste del tamaño del texto
                        color: textColor3,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ),
                  );
                },
                child: Text(
                  AppStrings.buttonRegister,
                  style: AppFonts.button.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Ajuste del tamaño del texto
                    color: textColor1,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  FloatingActionButton? _mainWrapperFab(BuildContext context, bool isLoggedIn) {
    return isLoggedIn
        ? FloatingActionButton(
            onPressed: () => CustomMaterialDialog.postOptions(
              context: context,
              type: DialogType.postOptions,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            backgroundColor: AppColors.mainColor,
            child: const Icon(Icons.add),
          )
        : null;
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

        pageController.animateToPage(
          page,
          duration: const Duration(milliseconds: 10),
          curve: Curves.fastLinearToSlowEaseIn,
        );
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

  Future<void> initializeWebSocket() async {
    webSocket = WebSocketChnl.instance;
    await webSocket.initialize();
  }
}
