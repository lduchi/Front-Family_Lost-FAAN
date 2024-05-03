import 'package:familylost_faan/Screen/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Utils/colors.dart';
import 'Register.dart';

class MySplashScreen2 extends StatelessWidget {
  const MySplashScreen2({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Container Example',
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 130,),
                _buildRowContainer("Perdidos", "En Family Lost FANN hemos podido registrar más de 50 mascotas perdidas en la ciudad de Cuenca."),
                SizedBox(height: 20),
                _buildRowContainer("Encontrados", "Con Family Lost FANN hemos podido encontrar más de 40 mascotas en la ciudad de Cuenca."),
                SizedBox(height: 20),
                _buildRowContainer("Adopcion","Con Family Lost FANN hemos podido dar en adopción a más de 60 mascotas en la ciudad de Cuenca."),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRowContainer(String titulo, String descripcion) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.asset(
                    "images/pet1.png",
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            width: 150,
            height: 170,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: general,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
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
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
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
