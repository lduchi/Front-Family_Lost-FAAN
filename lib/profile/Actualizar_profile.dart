import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ActualizarProfile extends StatelessWidget {
  const ActualizarProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar Perfil'),
      ),
      //appBar: RegisterPageAppBar(),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          Container(
            height: 150,
            child: CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('images/persona.jpg'),
            ),
          ),
          SizedBox(height: 16),
          _buildTextFieldWithIcon(
              CupertinoIcons.person, "Nombres"), // Usa CupertinoIcons
          SizedBox(height: 5),
          _buildTextFieldWithIcon(CupertinoIcons.person, "Apellidos"),
          SizedBox(height: 5),
          _buildTextFieldWithIcon(CupertinoIcons.phone, "Número de teléfono"),
          SizedBox(height: 5),
          _buildTextFieldWithIcon(CupertinoIcons.mail, "Correo electrónico"),
          SizedBox(height: 5),
          _buildTextFieldWithIcon(CupertinoIcons.at, "Usuario"),
          SizedBox(height: 5),

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
                "Guardar Cambios",
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

//////////////////////////////////////////////////////////////////////////
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
}
