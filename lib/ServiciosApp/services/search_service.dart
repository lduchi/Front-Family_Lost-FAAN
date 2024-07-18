import 'package:dio/dio.dart';
import 'package:familylost_faan/ServiciosApp/dto/page_response.dart';
import 'package:familylost_faan/ServiciosApp/dto/save_post.dart';
import 'package:familylost_faan/ServiciosApp/utils/dio_client.dart';
import 'package:familylost_faan/environment/environment.dart';
import 'package:flutter/material.dart';

class SearchService extends ChangeNotifier {
  String _searchTerm = '';
  List<SavePost> _searchResults = List.empty(growable: true);
  bool _isLoading = false;
  late final Dio _dio;

  String get searchTerm => _searchTerm;

  bool get isLoading => _isLoading;

  List<SavePost> get searchResults => _searchResults;

  SearchService() {
    _dio = DioClient().instance;
  }

  void setSearchTerm(String newTerm) {
    _searchTerm = newTerm;
    notifyListeners();
  }

  Future<void> performSearch() async {
    _isLoading = true;
    notifyListeners();
    final String endPointUrl = baseUrl + '/post';
    final String url = '$endPointUrl/find-by-title';
    try {
      final response = await _dio.get(
        url,
        queryParameters: {
          'title': _searchTerm,
          'pageSize': 50,
        },
      );

      if (response.statusCode == 200) {
        final PageResponse pageResponse = PageResponse.fromJson(response.data);
        _searchResults =
            pageResponse.content.map((e) => SavePost.fromJson(e)).toList();
        _isLoading = false;
        notifyListeners();
      } else {
        _isLoading = false;
        notifyListeners();
        throw Exception('Error al obtener las publicaciones');
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}
