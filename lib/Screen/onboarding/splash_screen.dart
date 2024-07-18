import 'package:familylost_faan/Screen/onboarding/splash_screen2.dart';
import 'package:familylost_faan/ServiciosApp/services/home_service.dart';
import 'package:familylost_faan/utilities/Fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../Utils/colors.dart';
import '../../pages/cubit/bottom_nav_cubit.dart';
import '../../widgets/main_wrapper.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: backgroundColor5,
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Positioned(
                top: 100.0, // Ajusta este valor según la altura que desees
                left: 0.0,
                right: 0.0,
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeIn,
                  height: size.height * 0.3,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    color: backgroundColor5,
                    image: const DecorationImage(
                      image: AssetImage(
                        "images/Logo.png",
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: size.height *
                    0.4, // Ajusta la posición vertical de la imagen
                left: 0,
                right: 0,
                child: FadeTransition(
                  opacity: _animation,
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50.0),
                          child: Text(
                            "Cada mascota merece experimentar el amor y la alegría de un hogar. Únete a nosotros en nuestra misión de hacer que eso se convierta en una realidad para cada uno de ellos.\n¡Inicia sesión o regístrate ahora y sé parte de este viaje de amor y rescate!",
                            textAlign: TextAlign.start,
                            style: AppFonts.caption.copyWith(
                              fontSize: 15.5,
                              color: textColor2,
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.07),
                        // Empieza el código del botón
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 150,
                          ),
                          child: Container(
                            height: size.height * 0.09,
                            width: size.width,
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
                              padding: const EdgeInsets.only(right: 5),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MultiProvider(
                                            providers: [
                                              BlocProvider(
                                                  create: (context) =>
                                                      BottomNavCubit()),
                                              ChangeNotifierProvider(
                                                  create: (_) =>
                                                      HomePageProvider('LOST')),
                                            ],
                                            child:
                                                MainWrapper(isLoggedIn: false),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: size.height * 0.8,
                                      width: size.width / 2.2,
                                      decoration: BoxDecoration(
                                        color: general,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Omitir",
                                          style: AppFonts.button.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
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
                                          builder: (context) =>
                                              const MySplashScreen2(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Siguiente",
                                      style: AppFonts.button.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: textColor1,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Termina el código del botón
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
