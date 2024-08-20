import 'package:familylost_faan/Screen/onboarding/intro_screen_1.dart';
import 'package:familylost_faan/Screen/onboarding/intro_screen_2.dart';
import 'package:familylost_faan/Screen/onboarding/intro_screen_3.dart';
import 'package:familylost_faan/Screen/onboarding/intro_screen_4.dart';
import 'package:familylost_faan/ServiciosApp/interceptors/store.dart';
import 'package:familylost_faan/ServiciosApp/services/home_service.dart';
import 'package:familylost_faan/ServiciosApp/services/liked_post_service.dart';
import 'package:familylost_faan/ServiciosApp/services/search_service.dart';
import 'package:familylost_faan/pages/cubit/bottom_nav_cubit.dart';
import 'package:familylost_faan/widgets/main_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _controller = PageController();
  bool onLastPage = false;
  String selectedLanguage = 'Español';

  void _onLanguageSelected(String language) {
    setState(() {
      selectedLanguage = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 3);
              });
            },
            children: [
              FirstIntroScreen(),
              SecondIntroScreen(),
              ThirdIntroScreen(),
              LastIntroScreen(onLanguageSelected: _onLanguageSelected,),
            ],
          ),
          !onLastPage ? GestureDetector(
            child: Container(
              alignment: Alignment(0.9, -0.9),
              child: Text(
                'Skip',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onTap: () {
              _controller.jumpToPage(3);
            },
          ) : Container(),
          Container(
              alignment: Alignment(0, 0.95),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SmoothPageIndicator(controller: _controller, count: 4),
                  onLastPage
                      ? GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            width: 100,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xFF009AB0).withOpacity(0.7),
                              borderRadius: BorderRadius.circular(25.0),
                              border: Border.all(
                                color: Colors.black.withOpacity(0.1),
                              ),
                            ),
                            child: Container(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onTap: () async{
                            await Store.saveLanguagePreference(selectedLanguage);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MultiProvider(
                                    providers: [
                                      BlocProvider(create: (context) => BottomNavCubit()),
                                      ChangeNotifierProvider(
                                          create: (_) =>
                                              HomePageProvider('LOST')),
                                      ChangeNotifierProvider(create: (_) =>
                                          LikePostProvider()),
                                      ChangeNotifierProvider(
                                          create: (_) => SearchService()),
                                    ],
                                  child: MainWrapper(isLoggedIn: false),
                                ),
                              ),
                            );
                          },
                        )
                      : GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            width: 100,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xFF009AB0).withOpacity(0.7),
                              borderRadius: BorderRadius.circular(25.0),
                              border: Border.all(
                                color: Colors.black.withOpacity(0.1),
                              ),
                            ),
                            child: Container(
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onTap: () {
                            _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                          },
                        ),
                ],
              ))
        ],
      ),
    );
  }
}
