import 'package:flutter/material.dart';
import '../Utils/colors.dart';

class EditPost extends StatelessWidget {
const EditPost({super.key});
@override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              backgroundColor1,
              backgroundColor2,
              backgroundColor4,
            ],
          ),
        ),
        child: SafeArea(
          child: ListView(
            children: [
              SizedBox(height: size.height * 0.1),

              // Centered App Icon
              Center(
                child: Image.asset(
                  "images/icon.jpg", // Replace with your app icon image path
                  height: size.height * 0.1,
                  width: size.height * 0.1,
                ),
              ),

              SizedBox(height: size.height * 0.05), // Spacing

              // User Input TextFields (Middle 1/3)
             Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  myTextField("Nombre"),
                  SizedBox(height: size.height * 0.01),
                  myTextField("Ubicacion"),
                  SizedBox(height: size.height * 0.01),
                  myTextField("Fecha"),
                  SizedBox(height: size.height * 0.01),
                  myTextField("Tipo de publicacion"),
                  SizedBox(height: size.height * 0.01),
                  myTextField("Descripcion"),
                  SizedBox(height: size.height * 0.01),
                  myTextField("Imagen"),
                  SizedBox(height: size.height * 0.01),
                ],
              ),
              SizedBox(height: size.height * 0.05), // Spacing
              
            ],
            
          ),
          
        ),
        
      ),
    );
  }

  Container myTextField(String hint) {
  return Container(
    width: 354,
    height: 52.04,
    margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
    padding: const EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Color(0xFFC0C0C0),
      ),
    ),
    child: TextField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        hintText: hint,
        hintStyle: const TextStyle(
          color: Color(0xFFC0C0C0),
          fontSize: 19,
        ),
        border: InputBorder.none,
      ),
    ),
  );
}


}
