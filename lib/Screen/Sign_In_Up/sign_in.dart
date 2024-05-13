import 'package:familylost_faan/Screen/Sign_In_Up/RegisterPage.dart';
import 'package:familylost_faan/Screen/ResetPassword/RequestNP.dart';
import 'package:familylost_faan/ServiciosApp/interceptors/store.dart';
import 'package:familylost_faan/pages/cubit/bottom_nav_cubit.dart';
import 'package:familylost_faan/pages/pages.dart';
import 'package:familylost_faan/utilities/Colors/app_colors.dart';
import 'package:familylost_faan/utilities/enum/dialog_type.dart';
import 'package:familylost_faan/utilities/icons/app_icons.dart';
import 'package:familylost_faan/utilities/texts/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Utils/colors.dart';
import '../../widgets/main_wrapper.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
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
        actions: [
          IconButton(
            icon: AppIcons.closeIconBlack,
            onPressed: () {
              // Navegar a la página principal o a la pantalla deseada
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => BottomNavCubit(),
                    child: const MainWrapper(isLoggedIn: false),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              backgroundColor2,
              backgroundColor2,
              backgroundColor4,
            ],
          ),
        ),
        child: SafeArea(
            child: ListView(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: size.height * 0.30,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  color: Colors.transparent,
                  image: const DecorationImage(
                    image: AssetImage(
                      "images/Logo.png",
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            SizedBox(height: size.height * 0.04),
            // for username and password
            myTextField("Ingresa tu nombre de usuario", Colors.black26,
                Icons.alternate_email, null),

            myTextField("Ingresa tu contraseña", Colors.black26, Icons.password,
                Icons.visibility_off_outlined),

            SizedBox(height: size.height * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  // for sign in button
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                    create: (context) => BottomNavCubit(),
                                    child: const MainWrapper(isLoggedIn: true),
                                  )) //<-- Change this to the page you want to navigate to after login
                          );
                      _loggin(context);
                    },
                    child: Container(
                      width: size.width,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: general,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Center(
                        child: Text(
                          "Iniciar Sesion",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.07),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RequestNP(),
                        ),
                      );
                    },
                    child: Text.rich(
                      TextSpan(
                        text: "¿Has olvidado la contraseña? ",
                        style: TextStyle(
                          color: textColor2,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ),
                      );
                    },
                    child: Text.rich(
                      TextSpan(
                          text: "¿No tienes una cuenta? ",
                          style: TextStyle(
                            color: textColor2,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          children: const [
                            TextSpan(
                              text: "Registrate",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

  Container socialIcon(image) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Image.asset(
        image,
        height: 35,
      ),
    );
  }

  Container myTextField(
      String hint, Color color, IconData icono1, IconData? icono2) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 15,
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 22,
          ),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50),
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.black45,
            fontSize: 19,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(
              icono1,
              color: color,
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              icono2,
              color: color,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loggin(BuildContext context) async {
    Store.setToken('eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhc2QxIiwiaWF0IjoxNzE1NTY0MTczLCJleHAiOjE3MTU2NTA1NzMsInJvbGUiOlsiUk9MRV9BRE1JTiJdLCJ1c2VySWQiOiI2In0.qm9B38AKKGkL9oUJa3RIttjbvW9yU4S8erXEwOWHPkE'); // <-- Change this to the token you want to store || Change this to the token you want to store
    //This will have to change in the future
    //Importante - Español: CAMBIA ESTO CON OTRO TOKEN, USA POSTMAN, SWAGGER, INSOMNIA CON TUS CREDENCIALES PARA CONSEGUIR UNO.
  }
}
