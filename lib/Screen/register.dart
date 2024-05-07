import 'dart:io';

import 'package:familylost_faan/ServiciosApp/services/usuarios_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../Utils/colors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

//gets del registro
TextEditingController nombreController = TextEditingController();
TextEditingController apellidoController = TextEditingController();
TextEditingController direccionController = TextEditingController();
TextEditingController celularController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController usernameController = TextEditingController();
TextEditingController paswordController = TextEditingController();
TextEditingController rolController = TextEditingController();
//get para la imagen
TextEditingController _datoFoto = new TextEditingController();

class _RegisterState extends State<Register> {
  bool _isPasswordVisible = false; // Variable para la visibilidad del password

  //Se llama al servicio
  final _apiService = UsuariosService();

  //variable para almacenar imagen
  String? _path;

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
              /*Center(
                TextField (controller: _datoFoto),
                (_path == null)? Container() : Image.file(File(_path), width: 200,),
                RaisedButton
              ),*/

              SizedBox(height: size.height * 0.05), // Spacing

              // User Input TextFields (Middle 1/3)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  myTextField1("Ingrese nombre", nombreController
                      /* decoration: InputDecoration(           
                        errorText: errorTextNombre,
                      )*/
                      ),
                  SizedBox(height: size.height * 0.01),
                  myTextField1("Ingrese apellido", apellidoController),
                  SizedBox(height: size.height * 0.01),
                  myTextField1("Ingrese direccion", direccionController),
                  SizedBox(height: size.height * 0.01),
                  myTextField1("Ingrese telefono", celularController),
                  SizedBox(height: size.height * 0.01),
                  myTextField1("Ingrese email", emailController),
                  SizedBox(height: size.height * 0.01),
                  myTextField1("Ingrese username", usernameController),
                  SizedBox(height: size.height * 0.01),
                  myTextFieldPassword("Password", paswordController),
                  SizedBox(height: size.height * 0.01),
                  myTextFieldPassword("Repeat Password", paswordController),
                  SizedBox(height: size.height * 0.01),
                ],
              ),

              // Registration Button (Middle 1/3)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  onTap: () async {
                    await _apiService.registerUser(
                      nombreController.text,
                      apellidoController.text,
                      direccionController.text,
                      celularController.text,
                      emailController.text,
                      usernameController.text,
                      paswordController.text,
                      rolController.text = "USER" ,
                    );
                  },
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
                  socialLoginButton("images/google.png", "Google",
                      Color(0xFFFFFFFF), Color(0xFFE74C3C)),
                  SizedBox(height: size.height * 0.01),
                  socialLoginButton("images/facebook.png", "Facebook",
                      Color(0xFFFFFFFF), Color(0xFF3498DB)),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    //METODO
  }

  Container myTextField1(String hint, TextEditingController controller,
      {InputDecoration? decoration}) {
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
        controller: controller,
        decoration: decoration?.copyWith(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color(0xFFC0C0C0),
                fontSize: 19,
              ),
              border: InputBorder.none,
            ) ??
            InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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

  Container myTextFieldPassword(String hint, TextEditingController controller) {
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
        controller: controller,
        obscureText: !_isPasswordVisible,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
        ),
      ),
    );
  }

  String? selectedRol;

  Container myTextFieldRol(String hint, TextEditingController controller) {
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
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
        value: selectedRol,
        items: [
          DropdownMenuItem<String>(
            value: "USER",
            child: Text("USER"),
          ),
        ],
        onChanged: (value) {
          setState(() {
            selectedRol = value;
          });
        },
      ),
    );
  }

  Container socialLoginButton(
      String image, String text, Color backgroundColor, Color borderColor) {
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

