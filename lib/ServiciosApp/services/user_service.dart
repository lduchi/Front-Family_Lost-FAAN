import 'dart:io';
import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:familylost_faan/ServiciosApp/dto/author.dart';
import 'package:familylost_faan/ServiciosApp/dto/reset_password_request.dart';
import 'package:familylost_faan/ServiciosApp/dto/user_dto.dart';
import 'package:familylost_faan/ServiciosApp/models/user.dart';
import 'package:familylost_faan/ServiciosApp/utils/dio_client.dart';
import 'package:familylost_faan/environment/environment.dart';
import 'package:familylost_faan/pages/pages.dart';
import 'package:familylost_faan/utilities/enum/dialog_type.dart';
import 'package:familylost_faan/utilities/texts/app_strings.dart';
import 'dart:convert';

import 'package:flutter/material.dart';

class UserService {
  late final Dio _dio;

  UserService() {
    _dio = DioClient().instance;
  }

  String endPointUrl = baseUrl + '/user';

  Future<UserDTO> getUserById(String id, BuildContext context) async {
    var url = '$endPointUrl/get/$id';

    try {
      final response = await _dio.get(
        url,
        options: Options(
          extra: {'context': context},
        ),
      );

      if (response.statusCode == 200) {
        final userResponse = UserDTO.fromJson(response.data);
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

  Future<void> updateUser(String id, UserDTO user, BuildContext context) async {
    var url = '$endPointUrl/update/$id';
    final response = await _dio.put(url, data: json.encode(user.toJson()));

   response.statusCode == 200 ? 
    CustomMaterialDialog.successOrError(
            context: context,
            type: DialogType.success,
            title: AppStrings.successTitle,
            message: AppStrings.successUserUpdate,
            dismissAndPop: true,
          )
        : CustomMaterialDialog.successOrError(
            context: context,
            type: DialogType.error,
            title: AppStrings.error,
            message: AppStrings.errorUpdateUser,
          );
  }

  Future<void> updatePhoto(String userId, File photo, BuildContext context) async {
    var url = '$endPointUrl/$userId';

    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(photo.path,
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

      response.statusCode == 200 ?
      CustomMaterialDialog.successOrError(
            context: context,
            type: DialogType.success,
            title: AppStrings.successTitle,
            message: AppStrings.successUserUpdate,
          )
        : CustomMaterialDialog.successOrError(
            context: context,
            type: DialogType.error,
            title: AppStrings.error,
            message: AppStrings.errorUpdateUser,
          );

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

  Future<bool> updatePassword(String id, ResetPasswordRequest request) async {
    var url = '$endPointUrl/profile-update-password/$id';
    final response =
        await _dio.put(url, data: json.encode(request.toJson()));

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

  Future<bool> changePassword(String uID, ResetPasswordRequest passwords) async {
    final url = '$endPointUrl/reset-password/$uID';
    try {
        final response = await _dio.put(url, data: json.encode(passwords.toJson()));
        if(response.statusCode == 200){
          return true;
        }else{
          return false;
        }
    }catch(e){
      return false;
    }
  }
}
