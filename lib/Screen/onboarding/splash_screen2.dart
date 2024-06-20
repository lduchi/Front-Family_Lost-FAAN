import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:familylost_faan/Screen/Sign_In_Up/sign_in.dart';
import 'package:familylost_faan/utilities/Fonts/app_fonts.dart';
import 'package:familylost_faan/utilities/Colors/app_colors.dart';
import 'package:familylost_faan/utilities/texts/app_strings.dart';
import '../../Utils/colors.dart';
import '../../pages/cubit/bottom_nav_cubit.dart';
import '../../widgets/main_wrapper.dart';
import 'splash_screen.dart';

class MySplashScreen2 extends StatelessWidget {
  const MySplashScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MySplashScreen(),
                ),
              );
            },
          ),
          title: Text(
            AppStrings.homeTitle,
            style: GoogleFonts.poppins(
              color: AppColors.secondaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: IconThemeData(
          color: AppColors.mainColor,
        ),
          backgroundColor: AppColors.secondaryMainColor,
          elevation: 0,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildRowContainer(
                  "Perdidos",
                  "En Family Lost FANN hemos podido registrar más de 50 mascotas perdidas en la ciudad de Cuenca.",
                  "images/pet1.png",
                  "Lola se ha perdido y está buscando su hogar",
                ),
                const SizedBox(height: 20),
                _buildRowContainer(
                  "Encontrados",
                  "Con Family Lost FANN hemos podido encontrar más de 40 mascotas en la ciudad de Cuenca.",
                  "images/pet2.png",
                  "Max fue encontrado gracias a Family Lost FANN",
                ),
                const SizedBox(height: 20),
                _buildRowContainer(
                  "Adopción",
                  "Con Family Lost FANN hemos podido dar en adopción a más de 60 mascotas en la ciudad de Cuenca.",
                  "images/pet3.png",
                  "Bella ahora ha sido adoptada gracias a Family Lost FANN",
                ),
              ],
            ),
          ),
        ),
        
floatingActionButton: Padding(
  padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
  child: Container(
    height: size.height * 0.07,
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
    child: Row(
      children: [
        GestureDetector(
          onTap: () {
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
          child: Container(
            height: size.height * 0.07,  // Adjust height to match parent container
            width: (size.width - 60) / 2,  // Adjust width considering padding
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
                builder: (context) => const SignIn(),
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
      
    );
  }

  Widget _buildRowContainer(String titulo, String descripcion, String imagePath, String caption) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    imagePath,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    caption,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            width: 150,
            height: 180,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 3),
              Container(
                decoration: BoxDecoration(
                  color: general,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Text(
                  titulo,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                width: 180,
                height: 40,
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Text(
                  descripcion,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                width: 220,
                height: 115,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
