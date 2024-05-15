import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:familylost_faan/ServiciosApp/dto/page_response.dart';
import 'package:familylost_faan/ServiciosApp/dto/save_post.dart';
import 'package:familylost_faan/ServiciosApp/interceptors/dio_interceptor.dart';
import 'package:familylost_faan/environment/environment.dart';
import 'package:familylost_faan/pages/pages.dart';
import 'package:familylost_faan/utilities/enum/dialog_type.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

class PostService {
  late final Dio _dio;

  PostService() {
    _dio = Dio();
    _dio.interceptors.add(DioInterceptor());
  }

  final String endPointUrl = baseUrl + '/posts';
  final String endPointUrlPhoto = baseUrl + '/file';

  Future<SavePost> savePost(SavePost savePost, File photo, BuildContext context) async {
    final String url = '$endPointUrlPhoto/register-post';

    final formData = FormData.fromMap(
      {
        'savePost': await MultipartFile.fromString(
          jsonEncode(savePost.toJson()),
          filename: 'savePost.json',
          contentType: MediaType('application', 'json'),
        ),
        'photo': await MultipartFile.fromFile(
          photo.path,
          filename: photo.path.split('/').last,
          contentType: MediaType('image', photo.path.split('.').last),
        ),
      },
    );

    final response = await _dio.post(
      url,
      data: formData,
      options: Options(
        extra: {'context': context},
      ),
    );

    response.statusCode == 201
        ? CustomMaterialDialog.successOrError(
            context: context,
            type: DialogType.success,
            title: 'Post saved',
            message: 'Your post has been saved successfully',
            dismissAndPop: true,
          )
        : CustomMaterialDialog.successOrError(
            context: context,
            type: DialogType.error,
            title: 'Error',
            message: 'An error occurred while saving the post',
          );

    final savedPost = await SavePost.fromJson(response.data);

    return savedPost;
  }

  Future<List<SavePost>> getPostsByUser(BigInt userId, BuildContext context) async {
    final String url = '$endPointUrl/author-id';

    final response = await _dio.get(
      url,
      options: Options(
        extra: {'context': context},
      ),
      queryParameters: {'authorId': userId},
    );

    final PageResponse pageResponse = PageResponse.fromJson(response.data);

    print(pageResponse.content);
    return pageResponse.content.map((e) => SavePost.fromJson(e)).toList();

  }
}
