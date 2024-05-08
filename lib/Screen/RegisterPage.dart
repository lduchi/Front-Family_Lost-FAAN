import 'package:familylost_faan/ServiciosApp/models/role.dart';
import 'package:familylost_faan/ServiciosApp/services/usuarios_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/RegisterPageAppBar.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController direccionController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rolController = TextEditingController();
//get para la imagen
  TextEditingController _datoFoto = new TextEditingController();
//Servicios
  final _apiService = UsuariosService();

  //Mensaje

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RegisterPageAppBar(),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          _buildTextFieldWithIcon(CupertinoIcons.person, "Nombres",
              nombreController), // Usa CupertinoIcons
          SizedBox(height: 10),
          _buildTextFieldWithIcon(
              CupertinoIcons.person, "Apellidos", apellidoController),
          SizedBox(height: 10),
          _buildTextFieldWithIcon(
              CupertinoIcons.location, "Direccion", direccionController),
          SizedBox(height: 10),
          _buildTextFieldWithIcon(
              CupertinoIcons.phone, "Número de teléfono", telefonoController),
          SizedBox(height: 10),
          _buildTextFieldWithIcon(
              CupertinoIcons.mail, "Correo electrónico", emailController),
          SizedBox(height: 10),
          _buildTextFieldWithIcon(
              CupertinoIcons.at, "Usuario", usernameController),
          SizedBox(height: 10),
          _buildPasswordFieldWithIcon(
              CupertinoIcons.lock, "Contraseña", passwordController),
          SizedBox(height: 10),
          _buildPasswordFieldRepeaWithIcont(
              CupertinoIcons.lock, "Repetir contraseña"),
          SizedBox(height: 20),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                String nombre = nombreController.text;
                String apellido = apellidoController.text;
                String direccion = direccionController.text;
                String telefono = telefonoController.text;
                String email = emailController.text;
                String username = usernameController.text;
                String password = passwordController.text;
                Role role = Role.USER;
                await _apiService.registerUser(nombre, apellido, direccion,
                    telefono, email, username, password, role);
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

  Widget _buildTextFieldWithIcon(
      IconData icon, String label, TextEditingController controller) {
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

  bool isPasswordVisible = true;

  Widget _buildPasswordFieldWithIcon(
      IconData icon, String label, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        obscureText: !isPasswordVisible,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
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

  Widget _buildPasswordFieldRepeaWithIcont(IconData icon, String label) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        obscureText: !isPasswordVisible,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
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
