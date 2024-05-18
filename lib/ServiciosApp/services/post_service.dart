import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:familylost_faan/ServiciosApp/dto/page_response.dart';
import 'package:familylost_faan/ServiciosApp/dto/save_post.dart';
import 'package:familylost_faan/ServiciosApp/interceptors/dio_interceptor.dart';
import 'package:familylost_faan/environment/environment.dart';
import 'package:familylost_faan/pages/pages.dart';
import 'package:familylost_faan/utilities/enum/dialog_type.dart';
import 'package:familylost_faan/utilities/texts/app_strings.dart';
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

  Future<SavePost> savePost(
      SavePost savePost, File photo, BuildContext context) async {
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

  Future<List<SavePost>> getPostsByUser(BigInt userId, BuildContext context,
      {int pageNumber = 0}) async {
    final String url = '$endPointUrl/author-id';

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

    return pageResponse.content.map((e) => SavePost.fromJson(e)).toList();
  }

  Future<List<SavePost>> getLikedPostsByUser(
      BigInt userId, BuildContext context,
      {int pageNumber = 0}) async {
    final String url = '$endPointUrl/get-liked-posts';

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
    print(response.data);
    final PageResponse pageResponse = PageResponse.fromJson(response.data);

    return pageResponse.content.map((e) => SavePost.fromJson(e)).toList();
  }

/**
 * Method to delete a post
 * Works weirdly, deletes the post but doesn't show the success message and throws an error message related to the response
 */
  Future<void> deletePost(String postId, BuildContext context) async {
    final String url = '$endPointUrl/delete/$postId';

    await _dio.delete(
      url,
      options: Options(
        extra: {'context': context},
      ),
    );

    // response.statusCode == 200
    //     ? CustomMaterialDialog.successOrError(
    //         context: context,
    //         type: DialogType.success,
    //         title: AppStrings.successTitle,
    //         message: AppStrings.deletePostSuccess,
    //         dismissAndPop: true,
    //       )
    //     : CustomMaterialDialog.successOrError(
    //         context: context,
    //         type: DialogType.error,
    //         title: AppStrings.deletePostErrorTitle,
    //         message: AppStrings.deletePostError,
    //       );

    // return response.data;
  }

  Future<String> updatePost(SavePost savePost, BuildContext context) async {
    final String url = '$endPointUrl/update';

    final response = await _dio.put(
      url,
      data: savePost.toJson(),
      options: Options(
        extra: {'context': context},
      ),
    );

    response.statusCode == 200
        ? CustomMaterialDialog.successOrError(
            context: context,
            type: DialogType.success,
            title: 'Post updated',
            message: 'Your post has been updated successfully',
            dismissAndPop: true,
          )
        : CustomMaterialDialog.successOrError(
            context: context,
            type: DialogType.error,
            title: 'Error',
            message: 'An error occurred while updating the post',
          );

    return response.data;
  }
}
