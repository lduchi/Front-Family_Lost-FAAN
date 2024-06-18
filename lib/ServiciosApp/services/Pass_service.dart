import 'dart:async';
import 'dart:convert';
import 'package:familylost_faan/Utils/colors.dart';
import 'package:familylost_faan/environment/environment.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PassService {
  String baseUrl1 = baseUrl;

  Future<bool> sendEmailResetPassword(String email) async {
    final url = Uri.parse('$baseUrl1/email/send-email-reset-password');

    final headers = {
      'Content-Type': 'application/json',
    };

    // Asegúrate de que todos los campos necesarios están presentes
    final body = jsonEncode({
      'to': email,
    });

    try {
      final response = await http
          .post(url, headers: headers, body: body)
          .timeout(
              const Duration(seconds: 30)); // Aumenta el timeout a 30 segundos
      var responseData = jsonDecode(response.body);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("userId", responseData['userId']);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "¡El token ha sido enviado a tu correo!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: general2,
          textColor: Colors.black,
          fontSize: 20.0,
        );
        return true; // Indicar éxito
      } else {
        Fluttertoast.showToast(
          msg: "¡Opps... Ya tienes un token activo!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: general2,
          textColor: Colors.black,
          fontSize: 20.0,
        );
        return true;
      }
    } on TimeoutException catch (e) {
      Fluttertoast.showToast(
        msg: "Estamos teniendo problemas, intenta mas tarde",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: general2,
        textColor: Colors.black,
        fontSize: 20.0,
      );
      return false;
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Revisa tu correo electronico ya tienes un token existente",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: general2,
        textColor: Colors.black,
        fontSize: 20.0,
      );
      return true;
    }
  }

  Future<bool> validateToken(String token) async {
    final url = Uri.parse('$baseUrl1/email/validate-token/$token');

    try {
      final response = await http.post(url).timeout(
          const Duration(seconds: 30)); // Aumenta el timeout a 30 segundos
      var responseData = jsonDecode(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        if (responseData.containsKey('active') &&
            responseData['active'] == true) {
          Fluttertoast.showToast(
            msg: "Token validado con éxito.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: general2,
            textColor: Colors.black,
            fontSize: 20.0,
          );
          return true; // Indicar éxito
        } else {
          Fluttertoast.showToast(
            msg: "Token inválido o expirado.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: general2,
            textColor: Colors.black,
            fontSize: 20.0,
          );
          return false;
        }
      } else {
        Fluttertoast.showToast(
          msg: "Hubo un incoveniente",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: general2,
          textColor: Colors.black,
          fontSize: 20.0,
        );
        return false;
      }
    } on TimeoutException catch (e) {
      Fluttertoast.showToast(
        msg: "Estamos teniendo problemas, intenta más tarde",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: general2,
        textColor: Colors.black,
        fontSize: 20.0,
      );
      return false;
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Ha ocurrido un error, por favor inténtalo de nuevo.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: general2,
        textColor: Colors.black,
        fontSize: 20.0,
      );
      return false;
    }
  }
}
