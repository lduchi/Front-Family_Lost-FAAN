import 'dart:convert';

import 'package:familylost_faan/ServiciosApp/models/usuarios.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsuariosService {
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController direccionController = TextEditingController();
  TextEditingController celularController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rolController = TextEditingController();

  Future<void> registerUser(
    String nombre,
    String username,
    String password,
    String apellido,
    String direccion,
    String telefono,
    String email,
    String rol
  ) async {
    try {
   

      var data = {
        "nombre": nombre,
        "apellido": apellido,
        "direccion": direccion,
        "telefono": telefono,
        "email": email,
        "username": username,
        "password": password,
        "rol": rol,
      };
      

      // Send the POST request
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/auth/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      // Handle the response
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        // Handle successful registration
        print(responseData);
      } else {
        throw Exception('Failed to register user');
      }
    } catch (e) {
      print(e);
      debugPrint(e.toString());
    }
  }
}
