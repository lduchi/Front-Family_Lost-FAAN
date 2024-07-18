import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../environment/environment.dart';
import '../dto/liked_post.dart';
import '../interceptors/store.dart';
import '../utils/dio_client.dart';

class LikePostProvider with ChangeNotifier {
  late final Dio dio;

  LikePostProvider() {
    dio = DioClient().instance;
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
        print(dataResponse);
        notifyListeners();

        return List<String>.from(dataResponse);
      } else {
        throw Exception('Error al dar like al post');
      }
    } catch (e) {
      rethrow;
    }
  }

  int _likes = 0;

  int get likes => _likes;

  void addLike() {
    _likes++;
    notifyListeners();
  }

  void removeLike() {
    _likes--;
    notifyListeners();
  }

  void resetLikes() {
    _likes = 0;
    notifyListeners();
  }
}