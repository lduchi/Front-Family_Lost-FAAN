import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../environment/environment.dart';
import '../../utilities/enum/dialog_type.dart';
import '../../utilities/texts/app_strings.dart';
import '../../widgets/custom_quick_alert.dart';
import '../dto/page_response.dart';
import '../dto/reset_password_request.dart';
import '../dto/save_post.dart';
import '../dto/user_dto.dart';
import '../interceptors/store.dart';
import '../utils/dio_client.dart';

class ProfileProvider with ChangeNotifier {
  late final Dio _dio;
  UserDTO? _user;
  UserDTO? get user => _user;
  String? userId;
  List<SavePost> myPosts = List.empty(growable: true);
  List<SavePost> likedPosts = List.empty(growable: true);
  bool isLoading = true;

  ProfileProvider() {
    _dio = DioClient().instance;
  }

  final String endPointUrl = '$baseUrl/user';
  final String postEndPointUrl = '$baseUrl/post';

  Future<void> getUserById(BuildContext context) async {
    userId = await Store.getUserId();

    if (userId == null) {
      throw Exception('User ID is null');
    }

    var url = '$endPointUrl/get/$userId';

    try {
      final response = await _dio.get(
        url,
        options: Options(
          extra: {'context': context},
        ),
      );

      if (response.statusCode == 200) {
        final userResponse = UserDTO.fromJson(response.data);
        _user = userResponse;
        notifyListeners();
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      throw Exception('Failed to load user: ${e.toString()}');
    }
  }

  Future<void> updateUser(String id, UserDTO user, BuildContext context) async {
    var url = '$endPointUrl/update/$id';
    final response = await _dio.put(url, data: json.encode(user.toJson()));

    response.statusCode == 200
        ? CustomMaterialDialog.successOrError(
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

    notifyListeners();
  }

  Future<void> updatePhoto(
      String userId, File photo, BuildContext context) async {
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

      response.statusCode == 200
          ? CustomMaterialDialog.successOrError(
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

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updatePassword(String id, ResetPasswordRequest request) async {
    var url = '$endPointUrl/profile-update-password/$id';
    final response = await _dio.put(url, data: json.encode(request.toJson()));

    if (response.statusCode == 200) {
      notifyListeners();
      return true;
    } else {
      throw Exception('Failed to update password');
    }
  }

  Future<bool> existsByEmail(String email) async {
    var url = '$endPointUrl/exists-email/$email';
    final response = await _dio.get(url);

    if (response.statusCode == 200) {
      notifyListeners();
      return response.data;
    } else {
      throw Exception('Failed to check email');
    }
  }

  Future<bool> existsByUsername(String username) async {
    var url = '$endPointUrl/exists-username/$username';
    final response = await _dio.get(url);

    if (response.statusCode == 200) {
      notifyListeners();
      return response.data;
    } else {
      throw Exception('Failed to check username');
    }
  }

  Future<bool> existsByPhone(String phone) async {
    var url = '$endPointUrl/exists-phone/$phone';
    final response = await _dio.get(url);

    if (response.statusCode == 200) {
      notifyListeners();
      return response.data;
    } else {
      throw Exception('Failed to check phone');
    }
  }

  Future<bool> changePassword(
      String uID, ResetPasswordRequest passwords) async {
    final url = '$endPointUrl/reset-password/$uID';
    try {
      final response =
          await _dio.put(url, data: json.encode(passwords.toJson()));
      if (response.statusCode == 200) {
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<SavePost>> getLikedPostsByUser(BuildContext context,
      {int pageNumber = 0}) async {
    userId = await Store.getUserId();
    final String url = '$postEndPointUrl/get-liked-posts';

    final response = await _dio.get(
      url,
      options: Options(
        extra: {'context': context},
      ),
      queryParameters: {
        'authorId': userId,
        'pageNumber': pageNumber,
        'pageSize': 10,
      },
    );

    final PageResponse pageResponse = PageResponse.fromJson(response.data);

    likedPosts = pageResponse.content.map((e) => SavePost.fromJson(e)).toList();

    notifyListeners();

    return likedPosts;
  }

  Future<List<SavePost>> getPostsByUser(BuildContext context,
      {int pageNumber = 0}) async {
    userId = await Store.getUserId();
    final String url = '$postEndPointUrl/author-id';

    final response = await _dio.get(
      url,
      options: Options(
        extra: {'context': context},
      ),
      queryParameters: {
        'authorId': userId,
        'pageNumber': pageNumber,
        'pageSize': 10
      },
    );

    final PageResponse pageResponse = PageResponse.fromJson(response.data);

    myPosts = pageResponse.content.map((e) => SavePost.fromJson(e)).toList();

    notifyListeners();

    return myPosts;
  }

  Future<void> initializeData(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    await getUserById(context);
    await getPostsByUser(context);
    await getLikedPostsByUser(context);

    isLoading = false;

    notifyListeners();
  }
}
