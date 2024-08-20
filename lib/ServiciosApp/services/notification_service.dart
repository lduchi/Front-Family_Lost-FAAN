import 'package:dio/dio.dart';
import 'package:familylost_faan/ServiciosApp/dto/notification_response.dart';
import 'package:familylost_faan/ServiciosApp/dto/page_response.dart';
import 'package:familylost_faan/ServiciosApp/interceptors/store.dart';
import 'package:familylost_faan/ServiciosApp/utils/dio_client.dart';
import 'package:familylost_faan/environment/environment.dart';
import 'package:flutter/material.dart';

class NotificationPageProvider with ChangeNotifier {
  late final Dio _dio;
  List<NotificationResponse> result = List.empty(growable: true);

  NotificationPageProvider() {
    _dio = DioClient().instance;
  }

  void initState() {
    getNotificationsByUser();
  }

  final String endPointUrl = baseUrl + '/notification';

  Future<void> getNotificationsByUser() async {
    final String url = '$endPointUrl/by-user';
    String? username = await Store.getUserName();

    try {
      final response = await _dio.get(
        url,
        queryParameters: {
          'userId': username,
          'pageSize': 15
        },
      );

      if (response.statusCode == 200) {
        final PageResponse pageResponse = PageResponse.fromJson(response.data);
        result = pageResponse.content.map((e) => NotificationResponse.fromJson(e)).toList();
        notifyListeners();
      } else {
        throw Exception('Error al obtener las notificaciones');
      }
    } catch (e) {
      rethrow;
    }
  }
}