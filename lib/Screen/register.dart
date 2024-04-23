import 'package:flutter/material.dart';
import '../Utils/colors.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
              SizedBox(height: size.height * 0.1), // Top 1/3 for app icon

              // Centered App Icon
              Center(
                child: Image.asset(
                  "images/icon.jpg", // Replace with your app icon image path
                  height: size.height * 0.3,
                  width: size.height * 0.3,
                ),
              ),

              SizedBox(height: size.height * 0.05), // Spacing

              // User Input TextFields (Middle 1/3)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  myTextField("Nombre de usuario", Colors.white),
                  myTextField("Correo electrónico", Colors.white),
                  myTextField("Contraseña", Colors.black26),
                  myTextField("Confirmar contraseña", Colors.black26),
                  SizedBox(height: size.height * 0.05),
                ],
              ),

              // Registration Button (Middle 1/3)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: size.width,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Text(
                      "Registrarse",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.05), // Spacing

              // Divider and "O registrate con" Text (Bottom 1/3)
              const Divider(),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  "O registrate con:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: textColor2,
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.05), // Spacing

              // Social Login Buttons (Bottom 1/3)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  socialLoginButton("images/google.png"),
                  SizedBox(height: size.height * 0.02),
                  socialLoginButton("images/facebook.png"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Existing helper functions (myTextField and socialLoginButton)
  Container myTextField(String hint, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 10,
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
            borderRadius: BorderRadius.circular(15),
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.black45,
            fontSize: 19,
          ),
          suffixIcon: Icon(
            Icons.visibility_off_outlined,
            color: color,
          ),
        ),
      ),
    );
  }

  Container socialLoginButton(image) {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 25,
          ),
          const SizedBox(width: 10),
          Text(
            "Google",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
