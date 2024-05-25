import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:familylost_faan/ServiciosApp/dto/save_post.dart';
import 'package:http_parser/http_parser.dart';

class FormDataHelper {
  static Future<FormData> createFormData(SavePost savePost, File photo) async {
    return FormData.fromMap({
      'post': await MultipartFile.fromString(
        jsonEncode(savePost.toJson()),
        filename: 'post.json',
        contentType: MediaType('application', 'json'),
      ),
      'image': await MultipartFile.fromFile(
        photo.path,
        filename: photo.path.split('/').last,
        contentType: MediaType('image', photo.path.split('.').last),
      ),
    });
  }

  static Future<FormData> createFormDataToPost(SavePost savePost, File image) async {
    return createFormData(savePost, image);
  }
}