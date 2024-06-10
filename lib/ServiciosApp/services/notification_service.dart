
import 'package:dio/dio.dart';
import 'package:familylost_faan/ServiciosApp/dto/page_response.dart';
import 'package:familylost_faan/ServiciosApp/interceptors/store.dart';
import 'package:familylost_faan/ServiciosApp/models/notification.dart' as notification;
import 'package:familylost_faan/ServiciosApp/utils/dio_client.dart';
import 'package:familylost_faan/environment/environment.dart';
import 'package:flutter/material.dart';

class NotificationService {
  late final Dio _dio;

  NotificationService() {
    _dio = DioClient().instance;
  }

  final String endPointUrl = baseUrl + '/notification';

  Future<List<notification.Notification>> getNotificationsByUser(BuildContext context, {int pageNumber = 0}) async {
    final String url = '$endPointUrl/by-user';
    String? username = await Store.getUserName();

    final response = await _dio.get(
      url,
      queryParameters: {'userId': username,
        'pageNumber': pageNumber,
        'pageSize': 10
      },
      options: Options(
        extra: {'context': context},
      ),
    );

    final PageResponse pageResponse = PageResponse.fromJson(response.data);

    return pageResponse.content.map((e) => notification.Notification.fromJson(e)).toList();
  }
}