import 'dart:io';
import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:familylost_faan/ServiciosApp/dto/author.dart';
import 'package:familylost_faan/ServiciosApp/models/user.dart';
import 'package:familylost_faan/ServiciosApp/models/user_update.dart';
import 'package:familylost_faan/ServiciosApp/utils/dio_client.dart';
import 'package:familylost_faan/environment/environment.dart';
import 'dart:convert';

import 'package:flutter/material.dart';

class UserService {
  late final Dio _dio;

  PostService() {
    _dio = DioClient().instance;
  }

  String endPointUrl = baseUrl + '/user';

  String endPointUrlPhoto = baseUrl + '/file';

  Future<User> getUserById(String id, BuildContext context) async {
    var url = '$endPointUrl/$id';

    try {
      final response = await _dio.get(
        url,
        options: Options(
          extra: {'context': context},
        ),
      );
      if (response.statusCode == 200) {
        final userResponse = User.fromJson(response.data);
        return userResponse;
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e, stackTrace) {
      developer.log('Error fetching user: $e',
          name: '_getUser', stackTrace: stackTrace);
      throw Exception('Failed to load user $e.message');
    }
  }

  //Test is needed for this method
  Future<User> createUser(User user) async {
    var url = '$endPointUrl/crearUser';
    final response = await _dio.post(url, data: json.encode(user.toJson()));

    print(response.statusCode);

    if (response.statusCode == 200) {
      print(response.data);
      final userResponse = User.fromJson(json.decode(response.data));
      print(userResponse);
      return userResponse;
    } else {
      throw Exception('Failed to create user');
    }
  }

  //This method is working fine, or I think so :D
  Future<String> updateUser(String id, UpdateUser user) async {
    var url = '$endPointUrl/actualizarUser/$id';
    final response = await _dio.put(url, data: json.encode(user.toJson()));

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to update user');
    }
  }

  Future<void> updatePhoto(String username, File photo) async {
    var url = '$endPointUrlPhoto/update-user/$username';

    var formData = FormData.fromMap({
      'photo': await MultipartFile.fromFile(photo.path,
          filename: photo.path.split('/').last),
    });

    try {
      var response = await _dio.put(url,
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'multipart/form-data',
              'Accept': 'application/json',
            },
          ));

      if (response.statusCode == 200) {
        print('Photo uploaded successfully');
      } else {
        throw Exception('Failed to update photo');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Author> getAuthorByUsername(String username) async {
    var url = '$endPointUrl/get-author/$username';
    final response = await _dio.get(url);

    if (response.statusCode == 200) {
      final authorResponse = Author.fromJson(response.data);
      return authorResponse;
    } else {
      throw Exception('Failed to load author');
    }
  }

  Future<bool> updatePassword(String id, String password) async {
    var url = '$endPointUrl/update-password/$id';
    final response =
        await _dio.put(url, queryParameters: {'password': password});

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update password');
    }
  }

  Future<bool> existsByEmail(String email) async {
    var url = '$endPointUrl/exists-email/$email';
    final response = await _dio.get(url);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to check email');
    }
  }

  Future<bool> existsByUsername(String username) async {
    var url = '$endPointUrl/exists-username/$username';
    final response = await _dio.get(url);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to check username');
    }
  }

  Future<bool> existsByPhone(String phone) async {
    var url = '$endPointUrl/exists-phone/$phone';
    final response = await _dio.get(url);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to check phone');
    }
  }
}
