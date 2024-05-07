import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:familylost_faan/ServiciosApp/Validaciones/validaciones_usuario.dart';
import 'package:familylost_faan/ServiciosApp/models/usuarios.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsuariosService {
  // ValidacionesUsuario validaciones ;

  Future<void> registerUser(
    String nombre,
    String apellido,
    String direccion,
    String telefono,
    String email,
    String username,
    String password,
    String rol,
  ) async {
    try {
      var data = {
        'nombre': nombre,
        'apellido': apellido,
        'direccion': direccion,
        'telefono': telefono,
        'email': email,
        'username': username,
        'password': password,
        'rol': rol,
        /* nombre : json as String,
        apellido : json as String,
         direccion : json as String,
          telefono : json as String,
           email : json as String,
            username : json as String,
             password : json as String,
              rol : json as String,**/
      };

      // Send the POST request
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/auth/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);

        print(responseData);
      } else {
        final errorBody = response.body;
        if (errorBody != 'true' && errorBody.isNotEmpty) {
          final errorResponse = json.decode(errorBody);
          final errorMessage = errorResponse['message'];
          Fluttertoast.showToast(
            msg: errorMessage,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
          throw Exception('Failed to register user: $errorMessage');
        } else {
          throw Exception('Failed to register user');
        }
      }
    } catch (e) {
      print(e);
      //debugPrint();
    }
  }
}
