import 'dart:convert';

import 'package:familylost_faan/ServiciosApp/dto/author.dart';
import 'package:jwt_decode_full/jwt_decode_full.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Store {
  const Store._();

  static const String _tokenKey = "TOKEN";

  static Future<void> setToken(String token) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.getString(_tokenKey);
  }

  static Future<void> removeToken() async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.clear();
  }

  static Future<void> setUserId(Author author) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString("AUTHOR", jsonEncode(author.toJson()));
  }

  static Future<Author?> getUserId() async {
    final preferences = await SharedPreferences.getInstance();

    final author = preferences.getString("AUTHOR");

    if (author == null) {
      return null;
    }

    return Author.fromJson(jsonDecode(author));
  }

  static Future<bool> getTokenTimeOut() async {
    final preferences = await SharedPreferences.getInstance();

    final token = preferences.getString(_tokenKey);

    if (token == null) {
      return true;
    }

    final jwtData = jwtDecode(token);

    return jwtData.isExpired!;
  }

  static Future<String> getTokenRole() async {
    final preferences = await SharedPreferences.getInstance();

    final token = preferences.getString(_tokenKey);

    if (token == null) {
      return '';
    }

    final payload = jwtDecode(token);

    if (payload.payload.containsKey('role')) {
      final roles = payload.payload['role'] as List<dynamic>;
      print(roles.first);
      return roles.isNotEmpty ? roles.first : '';
    }

    return '';
  }

  static Future<bool> hasAdminRole() async {
    final role = await getTokenRole();

    print(role == 'ROLE_ADMIN');

    return role == 'ROLE_ADMIN';
  }
}