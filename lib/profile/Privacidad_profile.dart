import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:familylost_faan/utilities/Fonts/app_fonts.dart'; // Importa la clase AppFonts

class PrivacidaProfile extends StatelessWidget {
  const PrivacidaProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cambiar Contraseña',
          style: AppFonts.title,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          SizedBox(height: 10),
          _buildPasswordFieldWithIcon(CupertinoIcons.lock,
              "Ingrese Contraseña nueva", AppFonts.TextField),
          SizedBox(height: 10),
          _buildPasswordFieldWithIcon(
              CupertinoIcons.lock, "Repetir contraseña", AppFonts.TextField),
          SizedBox(height: 20),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // Implementa la lógica para validar y procesar el registro
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF009AB0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                "Aceptar",
                style:
                    AppFonts.button, // Utiliza el estilo de botón de AppFonts
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordFieldWithIcon(
      IconData icon, String label, TextStyle textStyle) {
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
