import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:familylost_faan/utilities/Fonts/app_fonts.dart'; // Importa la clase AppFonts

class ActualizarProfile extends StatelessWidget {
  const ActualizarProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Actualizar Perfil',
          style: AppFonts.title, // Usa el estilo de título de AppFonts
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          Container(
            height: 150,
            child: CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('images/pet5.png'),
            ),
          ),
          SizedBox(height: 16),
          _buildTextFieldWithIcon(
              CupertinoIcons.person, "Nombres", AppFonts.TextField),
          SizedBox(height: 5),
          _buildTextFieldWithIcon(
              CupertinoIcons.person, "Apellidos", AppFonts.TextField),
          SizedBox(height: 5),
          _buildTextFieldWithIcon(
              CupertinoIcons.phone, "Número de teléfono", AppFonts.TextField),
          SizedBox(height: 5),
          _buildTextFieldWithIcon(
              CupertinoIcons.mail, "Correo electrónico", AppFonts.TextField),
          SizedBox(height: 5),
          _buildTextFieldWithIcon(
              CupertinoIcons.at, "Usuario", AppFonts.TextField),
          SizedBox(height: 5),
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
                "Guardar Cambios",
                style: AppFonts.button,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldWithIcon(
      IconData icon, String label, TextStyle textStyle) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        style: textStyle, // Usa el estilo de texto proporcionado
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
}
