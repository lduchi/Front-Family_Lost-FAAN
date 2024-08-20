import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:familylost_faan/ServiciosApp/dto/save_post.dart';
import 'package:flutter/material.dart';
import '../../environment/environment.dart';
import '../dto/liked_post.dart';
import '../interceptors/store.dart';
import '../utils/dio_client.dart';

class LikePostProvider with ChangeNotifier {
  late final Dio dio;
  String? userId;

  LikePostProvider() {
    dio = DioClient().instance;
    _initializeUserId();
  }

  bool get isInitialized => userId != null;

  Future<void> _initializeUserId() async {
    userId = await Store.getUserId();
    notifyListeners();
  }

  printUserId() {
    print('userId: $userId');
  }

  Future<List<String>> likePost(LikedPost likedPost) async {
    final String endPointUrl = '$baseUrl/post';
    final String url = '$endPointUrl/like';

    try {
      print('likedPost: ${jsonEncode(likedPost.toJson())}');
      final response = await dio.post(
        url,
        data: jsonEncode(likedPost.toJson()),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final dataResponse = response.data;
        final List<String> updatedLikes = List<String>.from(dataResponse);

        notifyListeners();
        return updatedLikes;
      } else {
        throw Exception('Error al dar like al post');
      }
    } catch (e) {
      rethrow;
    }
  }

  bool isPostLiked(SavePost post) {
    return userId != null ? post.likes!.contains(userId) : false;
  }
}