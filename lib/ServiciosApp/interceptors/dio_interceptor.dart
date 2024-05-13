import 'package:dio/dio.dart';
import 'package:familylost_faan/ServiciosApp/interceptors/store.dart';
import 'package:familylost_faan/pages/pages.dart';
import 'package:familylost_faan/utilities/enum/dialog_type.dart';
import 'package:familylost_faan/widgets/main_wrapper.dart';
import 'package:flutter/material.dart';

class DioInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await Store.getToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Accept'] = '*/*';
      options.headers['Authorization'] = 'Bearer $token';
    }

    final context = options.extra['context'] as BuildContext?;

    if (context != null) {
      CustomMaterialDialog.simple(
          context: context, type: DialogType.loading);
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');

    final context = response.requestOptions.extra['context'] as BuildContext?;

    if (context != null) {
      CustomMaterialDialog.close(context: context, type: DialogType.catLoading);
    }

    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}
