
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsuariosService{

  /*static const baseUrl = "http://localhost:8080/auth/register";

  static agregarUusario (Map pdata) async{

    var url = Uri.parse("${baseUrl} agregar_usuario");
    try {
      final res = await http.post(url, body: pdata);
      if (res.statusCode == 200) {

        var data = jsonDecode(res.body.toString());
        print (data);
        
      }else{
        print("failed to get response");

      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }*/

  static const String baseUrl = 'http://localhost:8080/auth/register';

  Future<dynamic> postJson(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }



}