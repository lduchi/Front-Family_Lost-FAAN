import 'dart:convert';
import 'dart:io';

import 'package:familylost_faan/ServiciosApp/models/user.dart';
import 'package:familylost_faan/ServiciosApp/models/usuarios.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:familylost_faan/ServiciosApp/interceptors/dio_interceptor.dart';
import 'package:familylost_faan/utilities/enum/dialog_type.dart';
import 'package:familylost_faan/ServiciosApp/dto/save_post.dart';
import 'package:familylost_faan/environment/environment.dart';
import 'package:familylost_faan/pages/pages.dart';
import 'package:http_parser/http_parser.dart';

class UsuariosService {
  late final Dio _dio;

  UsuariosService() {
    _dio = Dio();
  }

  final String endPointUrlPhoto = baseUrl + '/file';

  /*Future<Usuarios> saveUser(
      Usuarios saveUser, File photo, BuildContext context) async {
    final String url = '$endPointUrlPhoto/register-user';

    final formData = FormData.fromMap(
      {
        'saveUser': await MultipartFile.fromString(
          jsonEncode(saveUser.toJson()),
          filename: 'saveUser.json',
          contentType: MediaType('application', 'json'),
        ),
        'photo': await MultipartFile.fromFile(
          photo.path,
          filename: photo.path.split('/').last,
          contentType: MediaType('image', photo.path.split('.').last),
        ),
      },
    );

    try {
      final response = await _dio.post(
        url,
        data: formData,
        options: Options(
          extra: {'context': context},
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        CustomMaterialDialog.successOrError(
          context: context,
          type: DialogType.success,
          title: 'User saved',
          message: 'User has been saved successfully',
          dismissAndPop: true,
        );

        final savedUser = await Usuarios.fromJson(response.data);

        return savedUser;
      } else if (response.statusCode == 500) {
        CustomMaterialDialog.successOrError(
          context: context,
          type: DialogType.error,
          title: 'Server Error',
          message: 'An error occurred on the server while saving the user',
          dismissAndPop: true,
        );

        // throw an exception to propagate the error to the caller
        throw Exception('Server Error');
      } else {
        CustomMaterialDialog.successOrError(
          context: context,
          type: DialogType.error,
          title: 'Error',
          message: 'An error occurred while saving the user',
          dismissAndPop: true,
        );

        // throw an exception to propagate the error to the caller
        throw Exception('An error occurred while saving the user');
      }
    } catch (e) {
      // handle the exception
      rethrow;
    }
  }*/

  Future<Usuarios> saveUser(
    Usuarios usuario,
    File photo,
    BuildContext context,
  ) async {
    final String url = '$endPointUrlPhoto/register-user';

    final formData = FormData.fromMap(
      {
        'usuario': await MultipartFile.fromString(
          jsonEncode(usuario.toJson()),
          filename: 'user.json',
          contentType: MediaType('application', 'json'),
        ),
        'photo': await MultipartFile.fromFile(
          photo.path,
          filename: photo.path.split('/').last,
          contentType: MediaType('image', photo.path.split('.').last),
        ),
      },
    );

    try {
      final response = await _dio.post(
        url,
        data: formData,
        options: Options(
          extra: {'context': context},
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        CustomMaterialDialog.successOrError(
          context: context,
          type: DialogType.success,
          title: 'User saved',
          message: 'User has been saved successfully',
          dismissAndPop: true,
        );

        final savedUser = await Usuarios.fromJson(response.data as Map<String, dynamic>);

        return savedUser;
      } else if (response.statusCode == 500) {
        CustomMaterialDialog.successOrError(
          context: context,
          type: DialogType.error,
          title: 'Server Error',
          message: 'An error occurred on the server while saving the user',
          dismissAndPop: true,
        );

        // throw an exception to propagate the error to the caller
        throw Exception('Server Error');
      } else {
        CustomMaterialDialog.successOrError(
          context: context,
          type: DialogType.error,
          title: 'Error',
          message: 'An error occurred while saving the user',
          dismissAndPop: true,
        );

        // throw an exception to propagate the error to the caller
        throw Exception('An error occurred while saving the user');
      }
    } catch (e) {
      // handle the exception
      rethrow;
    }
  }


  
}
