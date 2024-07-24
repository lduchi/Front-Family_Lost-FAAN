import 'dart:convert';
import 'dart:io';
import 'package:familylost_faan/ServiciosApp/interceptors/store.dart';
import 'package:familylost_faan/ServiciosApp/models/NewUser.dart';
import 'package:familylost_faan/ServiciosApp/models/user.dart';
import 'package:familylost_faan/ServiciosApp/utils/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:familylost_faan/utilities/enum/dialog_type.dart';
import 'package:familylost_faan/environment/environment.dart';
import 'package:familylost_faan/pages/pages.dart';
import 'package:http_parser/http_parser.dart';

class UsuariosService {
  late final Dio _dio;

  UsuariosService() {
    _dio = DioClient().instance;
  }

  final String endPointUrlPhoto = baseUrl + '/auth';
  final String urlUsername = baseUrl + '/user';

  Future<User> Register(
    NewUser newUser,
    File image,
    BuildContext context,
  ) async {
    final String url = '$endPointUrlPhoto/register';

    final formData = FormData.fromMap(
      {
        'newUser': await MultipartFile.fromString(
          jsonEncode(newUser.toJson()),
          filename: 'newUser.json',
          contentType: MediaType('application', 'json'),
        ),
        'image': await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
          contentType: MediaType('image', image.path.split('.').last),
        ),
      },
    );

    try {
      final response = await _dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      final savedUser = User.fromJson(response.data as Map<String, dynamic>);
      await Store.setAccessToken(savedUser.jwt);
      if (response.statusCode != 201 || response.statusCode != 200) {
        throw Exception('An error occurred while saving the user');
      } else {
        CustomMaterialDialog.successOrError(
          context: context,
          type: DialogType.success,
          title: 'User saved',
          message: 'User has been saved successfully',
          dismissAndPop: true,
        );
        return savedUser;
      }
    } catch (e) {
      CustomMaterialDialog.successOrError(
        context: context,
        type: DialogType.error,
        title: 'Error',
        message: 'An error occurred while saving the user',
        dismissAndPop: true,
      );
      rethrow;
    }
  }

  Future<bool> isUsernameAvailable(String username) async {
    try {
      final String url = '$urlUsername/exists-username/$username';
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        // El backend indica que el nombre de usuario no está disponible
        return !response.data;
      } else {
        // El backend indica que el nombre de usuario está disponible
        return true;
      }
    } catch (e) {
      print('Error al verificar disponibilidad de username: $e');
      return false;
    }
  }
}
