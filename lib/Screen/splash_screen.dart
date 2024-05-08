import 'package:familylost_faan/Screen/splash_screen2.dart';
import 'package:familylost_faan/utilities/Fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:familylost_faan/Screen/sign_in.dart';
import '../Utils/colors.dart';
import 'Register.dart';

class MySplashScreen extends StatelessWidget {
  const MySplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: backgroundColor5,
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: size.height * 0.53,
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
              top: size.height * 0.5,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              50.0), // Ajusta el valor según sea necesario
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      child: Container(
                        height: size.height * 0.08,
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
                                      builder: (context) => Register(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: size.height * 0.08,
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
                                        fontSize:
                                            18, // Ajuste del tamaño del botón
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
                                    fontSize: 18, // Ajuste del tamaño del botón
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
