import 'package:flutter/material.dart';
import '../Utils/colors.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isPasswordVisible = false; // State variable for password visibility

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
                  myTextField("Nombre de usuario"),
                  SizedBox(height: size.height * 0.01),
                  myTextField("Correo electrónico"),
                  SizedBox(height: size.height * 0.01),
                  myTextField("Nombres"),
                  SizedBox(height: size.height * 0.01),
                  myTextField("Apellidos"),
                  SizedBox(height: size.height * 0.01),
                  myTextField("Identificación"),
                  SizedBox(height: size.height * 0.01),
                  myTextField("Dirección"),
                  SizedBox(height: size.height * 0.01),
                  myTextField("Teléfono"),
                  SizedBox(height: size.height * 0.01),
                  myTextFieldPassword("Contraseña"),
                  SizedBox(height: size.height * 0.01),
                  myTextFieldPassword("Confirmar contraseña"),
                  SizedBox(height: size.height * 0.01),
                  myTextField("Rol"),
                  SizedBox(height: size.height * 0.03),
                ],
              ),


              // Registration Button (Middle 1/3)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: 151,
                  height: 45,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Color(0xFF04A1C4),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Registrarse",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF04A1C4),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.05), // Spacing

              // Divider and "O registrate con" Text (Bottom 1/3)
              const Divider(),
              const SizedBox(height: 15),
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

              SizedBox(height: size.height * 0.01), // Spacing

              // Social Login Buttons (Bottom 1/3)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  socialLoginButton("images/google.png", "Google", Color(0xFFFFFFFF), Color(0xFFE74C3C)),
                  SizedBox(height: size.height * 0.01),
                  socialLoginButton("images/facebook.png", "Facebook", Color(0xFFFFFFFF), Color(0xFF3498DB)),
                ],
              ),
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

Container myTextFieldPassword(String hint) {
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
      obscureText: !_isPasswordVisible, // Toggle visibility based on state
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        hintText: hint,
        hintStyle: const TextStyle(
          color: Color(0xFFC0C0C0),
          fontSize: 19,
        ),
        border: InputBorder.none,
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible; // Toggle state
            });
          },
        ),
      ),
    ),
  );
}



  Container socialLoginButton(String image, String text, Color backgroundColor, Color borderColor) {
    return Container(
      width: 354,
      height: 52.04,
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: borderColor,
        ),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 25,
          ),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: borderColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
