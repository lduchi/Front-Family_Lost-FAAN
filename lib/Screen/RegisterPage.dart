import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/RegisterPageAppBar.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RegisterPageAppBar(),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          _buildTextFieldWithIcon(
              CupertinoIcons.person, "Nombres"), // Usa CupertinoIcons
          SizedBox(height: 10),
          _buildTextFieldWithIcon(CupertinoIcons.person, "Apellidos"),
          SizedBox(height: 10),
          _buildTextFieldWithIcon(CupertinoIcons.phone, "Número de teléfono"),
          SizedBox(height: 10),
          _buildTextFieldWithIcon(CupertinoIcons.mail, "Correo electrónico"),
          SizedBox(height: 10),
          _buildTextFieldWithIcon(CupertinoIcons.at, "Usuario"),
          SizedBox(height: 10),
          _buildPasswordFieldWithIcon(CupertinoIcons.lock, "Contraseña"),
          SizedBox(height: 10),
          _buildPasswordFieldWithIcon(
              CupertinoIcons.lock, "Repetir contraseña"),
          SizedBox(height: 20),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // Implementar la lógica para validar y procesar el registro
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF009AB0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                "Registrarse",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldWithIcon(IconData icon, String label) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Color(0xFF707070)),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordFieldWithIcon(IconData icon, String label) {
    bool _obscureText = true;

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        obscureText: _obscureText,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          suffixIcon: IconButton(
            icon: _obscureText
                ? Icon(CupertinoIcons.eye_slash)
                : Icon(CupertinoIcons.eye_slash),
            onPressed: () {
              _obscureText = !_obscureText;
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Color(0xFF707070)),
          ),
        ),
      ),
    );
  }
}
