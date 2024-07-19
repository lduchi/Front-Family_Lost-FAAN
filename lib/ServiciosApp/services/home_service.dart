import 'package:dio/dio.dart';
import 'package:familylost_faan/ServiciosApp/dto/page_response.dart';
import 'package:familylost_faan/ServiciosApp/dto/save_post.dart';
import 'package:familylost_faan/ServiciosApp/utils/dio_client.dart';
import 'package:familylost_faan/environment/environment.dart';
import 'package:flutter/material.dart';

class HomePageProvider with ChangeNotifier {
  final String type;
  List<SavePost> result = List.empty(growable: true);

  late final Dio _dio;

  HomePageProvider(this.type) {
    _dio = DioClient().instance;
    getPostsByType(type);
  }

  Future<void> getPostsByType(String postType) async {
    final String endPointUrl = baseUrl + '/post';
    final String url = '$endPointUrl/type';
    try {
      final response = await _dio.get(
        url,
        queryParameters: {
          'postType': postType,
          'pageSize': 100,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final PageResponse pageResponse = PageResponse.fromJson(response.data);
        result = pageResponse.content.map((e) => SavePost.fromJson(e)).toList();
        notifyListeners();
      } else {
        throw Exception('Error al obtener las publicaciones');
      }
    } catch (e) {
      rethrow;
    }
  }

}
