import 'package:familylost_faan/ServiciosApp/dto/reset_password_request.dart';
import 'package:familylost_faan/ServiciosApp/services/home_service.dart';
import 'package:familylost_faan/ServiciosApp/services/search_service.dart';
import 'package:familylost_faan/ServiciosApp/services/user_service.dart';
import 'package:familylost_faan/pages/cubit/bottom_nav_cubit.dart';
import 'package:familylost_faan/pages/pages.dart';
import 'package:familylost_faan/utilities/Colors/app_colors.dart';
import 'package:familylost_faan/utilities/enum/dialog_type.dart';
import 'package:familylost_faan/utilities/icons/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/colors.dart';
import '../../widgets/main_wrapper.dart';

class ResetP extends StatelessWidget {
  const ResetP({super.key});

  @override
  Widget build(BuildContext context) {
    final password1 = TextEditingController();
    final password2 = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          // Contains the logo of the app
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "NUEVA CONTRASEÑA",
              style: GoogleFonts.poppins(
                color: AppColors.secondaryColor,
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
            SizedBox(height: size.height * 0.03),
            const SizedBox(height: 15),
            Text(
              "A continuación, ingrese su nueva contraseña",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: general),
            ),
            SizedBox(height: size.height * 0.04),
            // for username and password
            myTextField("Nueva Contraseña", Colors.black26, Icons.password,
                Icons.visibility_off_outlined, password1),

            myTextField("Repita su contraseña", Colors.black26, Icons.password,
                Icons.visibility_off_outlined, password2),

            SizedBox(height: size.height * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  // for sign in button
                  GestureDetector(
                    onTap: () async {
                      final sfps = await SharedPreferences.getInstance();
                      String uID = sfps.getString("userId").toString();

                      ResetPasswordRequest resetPasswordRequest =
                          ResetPasswordRequest(
                        newPassword: password1.text,
                        newRepeatedPassword: password2.text,
                      );

                      if (password1.text == password2.text) {
                        bool success = await UserService()
                            .changePassword(uID, resetPasswordRequest);
                        CustomMaterialDialog.successOrError(
                            context: context,
                            type: DialogType.success,
                            title: "¡Hey!",
                            message:
                                "Tu contraseña ha sido cambiada correctamente");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MultiProvider(
                              providers: [
                                BlocProvider(
                                    create: (context) => BottomNavCubit()),
                                ChangeNotifierProvider(
                                    create: (_) => HomePageProvider('LOST')),
                                ChangeNotifierProvider(create: (_) => SearchService()),
                              ],
                              child: MainWrapper(isLoggedIn: true),
                            ),
                          ),
                        );
                      } else {
                        CustomMaterialDialog.successOrError(
                            context: context,
                            type: DialogType.error,
                            title: "¡Hey!",
                            message: "Las contraseñas deben ser iguales");
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
                          "Aceptar",
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
        controller: controller,
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
}
