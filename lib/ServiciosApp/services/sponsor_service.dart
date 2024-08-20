import 'package:dio/dio.dart';
import 'package:familylost_faan/ServiciosApp/dto/page_response.dart';
import 'package:familylost_faan/ServiciosApp/utils/dio_client.dart';
import 'package:familylost_faan/environment/environment.dart';
import 'package:flutter/material.dart';

import '../dto/saved_sponsor.dart';

class SponsorPageProvider with ChangeNotifier {
  List<SavedSponsor> result = List.empty(growable: true);

  late final Dio _dio;

  SponsorPageProvider() {
    _dio = DioClient().instance;
    getSponsors();
  }

  Future<void> getSponsors() async {
    final String endPointUrl = baseUrl + '/sponsor/get';
    final String url = '$endPointUrl';
    try {
      final response = await _dio.get(
        url,
        queryParameters: {
          'pageSize': 25,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final PageResponse pageResponse = PageResponse.fromJson(response.data);
        result = pageResponse.content.map((e) => SavedSponsor.fromJson(e)).toList();
        notifyListeners();
      } else {
        throw Exception('Error al obtener los patrocinadores');
      }
    } catch (e) {
      rethrow;
    }
  }
}