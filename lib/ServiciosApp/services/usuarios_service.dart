import 'dart:convert';
import 'package:familylost_faan/ServiciosApp/models/role.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsuariosService {
  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.green,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<void> registerUser(
    String nombre,
    String apellido,
    String direccion,
    String telefono,
    String email,
    String username,
    String password,
    Role role,
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
        "role": role.toString(),
      };

      // Registro Usuarios
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
        print("Registro exitoso");
      } else {
        final errorBody = response.body;
        if (errorBody != null && errorBody.isNotEmpty) {
          final errorResponse = json.decode(errorBody);
          final errorMessage = errorResponse['message'];
          Fluttertoast.showToast(
            msg: errorMessage,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
          throw Exception('fallo el registro del usuario: $errorMessage');
        } else {
          throw Exception('Fallo el registro del usuario');
        }
      }
    } catch (e) {
      print(e);
      debugPrint(e.toString());
    }
  }

  /* Future<void> registerUser(
    String nombre,
    String apellido,
    String direccion,
    String telefono,
    String email,
    String username,
    String password,
    String role,
  ) async {
    final String apiUrl = "http://10.0.2.2:8080/auth/register";
    final http.Client client = http.Client();

    try {
      final Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      final Map<String, dynamic> body = {
        'nombre': nombre?? '',
        'apellido': apellido?? '' ,
        'direccion': direccion?? '',
        'telefono': telefono?? '',
        'email': email?? '',
        'username': username?? '' ,
        'password': password?? '' ,
        'role': role?? '' ,
      };

      final http.Response response = await client.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData);
        print("Registro exitoso");
      } else {
        print("Registro fallido");
      }
    } catch (e) {
      print(e);
      debugPrint(e.toString());

      // Show red SnackBar
      print("Error de conexión");
    } finally {
      client.close();
    }
  }*/
}
