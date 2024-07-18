import 'package:familylost_faan/Screen/ResetPassword/ResetP.dart';
import 'package:familylost_faan/ServiciosApp/services/Pass_service.dart';
import 'package:familylost_faan/ServiciosApp/services/home_service.dart';
import 'package:familylost_faan/ServiciosApp/services/search_service.dart';
import 'package:familylost_faan/pages/cubit/bottom_nav_cubit.dart';
import 'package:familylost_faan/utilities/Colors/app_colors.dart';
import 'package:familylost_faan/utilities/icons/app_icons.dart';
import 'package:familylost_faan/utilities/texts/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../Utils/colors.dart';
import '../../widgets/main_wrapper.dart';

class VerifyC extends StatelessWidget {
  const VerifyC({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final tokenController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          // Contains the logo of the app
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              AppStrings.textResetP,
              style: GoogleFonts.poppins(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        iconTheme: IconThemeData(
          color: const Color.fromARGB(255, 0, 0, 0),
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
                  builder: (context) => MultiProvider(
                    providers: [
                      BlocProvider(create: (context) => BottomNavCubit()),
                      ChangeNotifierProvider(
                          create: (_) => HomePageProvider('LOST')),
                      ChangeNotifierProvider(create: (_) => SearchService()),
                    ],
                    child: MainWrapper(isLoggedIn: false),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        child: SafeArea(
            child: ListView(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: size.height * 0.35,
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

            SizedBox(height: size.height * 0.03),

            const SizedBox(height: 15),
            Text(
              "Ingrese a continuación el código enviado a su correo electrónico",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: general),
            ),
            SizedBox(height: size.height * 0.04),
            // for username and password
            myTextField("Ingresa el codigo", Colors.black26,
                Icons.security_rounded, null, tokenController),

            SizedBox(height: size.height * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  // for sign in button
                  GestureDetector(
                    onTap: () async {
                      String token = tokenController.text;
                      bool success = await PassService().validateToken(token);
                      if (success) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ResetP(),
                            ));
                      }
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
                          "Verificar Código",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 22),
                        ),
                      ),
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

  Container myTextField(String hint, Color color, IconData icono1,
      IconData? icono2, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 15,
      ),
      child: TextField(
        controller: controller, // Asigna el controlador al TextField
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 22,
          ),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: color, // Establece el color del borde
              width: 2.0, // Establece el ancho del borde
            ),
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
}
