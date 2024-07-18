import 'dart:convert';

import 'package:familylost_faan/ServiciosApp/dto/author.dart';
import 'package:jwt_decode_full/jwt_decode_full.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Store {
  const Store._();

  static const String _tokenAccessKey = "ACCESS_TOKEN";
  static const String _tokenRefreshKey = "REFRESH_TOKEN";

  static Future<void> setTokens(String accessToken, String refreshToken) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString(_tokenAccessKey, accessToken);
    await preferences.setString(_tokenRefreshKey, refreshToken);
  }

  static Future<void> setAccessToken(String token) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString(_tokenAccessKey, token);
  }

  static Future<String?> getAccessToken() async {
    final preferences = await SharedPreferences.getInstance();
print(preferences.getString(_tokenAccessKey));
    return preferences.getString(_tokenAccessKey);
  }

  static Future<void> setRefreshToken(String token) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString(_tokenRefreshKey, token);
  }

  static Future<String?> getRefreshToken() async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.getString(_tokenRefreshKey);
  }

  static Future<void> removeToken() async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.clear();
  }

  static Future<String?> getUserId() async {
    final preferences = await SharedPreferences.getInstance();

    final token = preferences.getString(_tokenAccessKey);

    if (token == null) {
      return null;
    }

    final jwtData = jwtDecode(token);

    if (jwtData.payload.containsKey('userId')) {
      final userId = jwtData.payload['userId'];

      return userId;
    }

    return null;
  }

  static Future<String?> getUserName() async {
    final preferences = await SharedPreferences.getInstance();

    final token = preferences.getString(_tokenAccessKey);

    if (token == null) {
      return null;
    }

    final payload = jwtDecode(token);

    if (payload.payload.containsKey('sub')) {
      final username = payload.payload['sub'] as String;

      return username;
    }

    return null;
  }

  static Future<bool> getAccessTokenTimeOut() async {
    final preferences = await SharedPreferences.getInstance();

    final token = preferences.getString(_tokenAccessKey);

    if (token == null) {
      return true;
    }

    final jwtData = jwtDecode(token);

    return jwtData.isExpired!;
  }

  static Future<bool> getRefreshTokenTimeOut() async {
    final preferences = await SharedPreferences.getInstance();

    final token = preferences.getString(_tokenAccessKey);

    if (token == null) {
      return true;
    }

    final jwtData = jwtDecode(token);

    return jwtData.isExpired!;
  }

  static Future<String> getTokenRole() async {
    final preferences = await SharedPreferences.getInstance();

    final token = preferences.getString(_tokenAccessKey);

    if (token == null) {
      return '';
    }

    final payload = jwtDecode(token);

    if (payload.payload.containsKey('role')) {
      final rol = payload.payload['role'];

      return rol;
    }

    return '';
  }

  static Future<bool> hasAdminRole() async {
    final role = await getTokenRole();

    return role == 'ADMIN';
  }

  static Future<void> setLogged(bool isLogged) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setBool('isLoggedIn', isLogged);
  }

  static Future<bool?> isLogged() async {
    final preferences = await SharedPreferences.getInstance();

    final bool isLogged = preferences.getBool('isLoggedIn') ?? false;

    return isLogged && !await getAccessTokenTimeOut();
  }

  static Future<void> setAuthor(Author author) async {
    final preferences = await SharedPreferences.getInstance();
    final authorJson = jsonEncode(author.toJson());
    await preferences.setString('author', authorJson);
  }

  static Future<Author?> getAuthor() async {
    final preferences = await SharedPreferences.getInstance();
    final authorJson = preferences.getString('author');
    if (authorJson != null) {
      final author = Author.fromJson(jsonDecode(authorJson));
      return author;
    }
    return null;
  }
}
