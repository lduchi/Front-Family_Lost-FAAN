import 'dart:io';

import 'package:dio/dio.dart';
import 'package:familylost_faan/ServiciosApp/dto/save_post.dart';
import 'package:familylost_faan/ServiciosApp/interceptors/store.dart';
import 'package:familylost_faan/ServiciosApp/notification/notifications.dart';
import 'package:familylost_faan/ServiciosApp/utils/form_data_helper.dart';
import 'package:familylost_faan/ServiciosApp/web_socket/web_socket.dart';
import 'package:familylost_faan/environment/environment.dart';
import 'package:familylost_faan/pages/pages.dart';
import 'package:familylost_faan/utilities/enum/dialog_type.dart';
import 'package:flutter/material.dart';

import '../../Screen/Sign_In_Up/sign_in.dart';

class DioInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await Store.getAccessToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Accept'] = '*/*';
      options.headers['Authorization'] = 'Bearer $token';
    }

    final context = options.extra['context'] as BuildContext?;

    if (context != null) {
      CustomMaterialDialog.simple(context: context, type: DialogType.loading);
      options.headers['Accept-Language'] = Localizations.localeOf(context).languageCode;
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');

    final context = response.requestOptions.extra['context'] as BuildContext?;

    if (context != null) {
      CustomMaterialDialog.close(context: context, type: DialogType.catLoading);
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    print('ERROR MESSAGE: ${err.response?.data} a ${err.requestOptions.extra}');

    final context = err.requestOptions.extra['context'] as BuildContext?;

    if ((err.response?.statusCode == 401 &&
        err.response?.data['error'] == 'Token JWT expirado')) {
      if (await Store.getRefreshToken() != null) {
        if (await refreshToken()) {
          final newOptions = err.requestOptions
            ..headers['Authorization'] =
                'Bearer ${await Store.getAccessToken()}';

          handler.resolve(await _retry(newOptions));
          CustomMaterialDialog.close(
              context: context!, type: DialogType.catLoading);
          return;
        }
      }
    } else {
      CustomMaterialDialog.close(
          context: context!, type: DialogType.catLoading);
    }

    super.onError(err, handler);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final dio = Dio();
    final accessToken = await Store.getAccessToken();

    final options = Options(
      method: requestOptions.method,
      headers: {
        'Accept': '*/*',
        'Authorization': 'Bearer $accessToken',
      },
      extra: requestOptions.extra,
    );

    if (requestOptions.data is FormData && requestOptions.path.contains('post')) {
      final SavePost newPost = requestOptions.extra['newPost'];
      final File image = requestOptions.extra['image'];

      final data = await FormDataHelper.createFormDataToPost(newPost, image);

      return dio.request(requestOptions.path,
          queryParameters: requestOptions.queryParameters,
          data: data,
          options: options);
    }

    return dio.request(requestOptions.path,
        queryParameters: requestOptions.queryParameters,
        data: await requestOptions.data,
        options: options);
  }

  Future<bool> refreshToken() async {
    final refreshToken = await Store.getRefreshToken();

    if (refreshToken == null) {
      return false;
    }

    final url = '$baseUrl/auth/refresh-token';

    final response = await Dio().post(
      url,
      data: {'refreshJwt': refreshToken},
    );

    if (response.statusCode == 200) {
      final accessToken = response.data['accessJwt'];
      await Store.setAccessToken(accessToken);
      return true;
    } else {
      await Store.removeToken();

      if (response.data['error'] == 'Token JWT expirado') {
        final context =
            response.requestOptions.extra['context'] as BuildContext?;

        CustomMaterialDialog.successOrError(
            type: DialogType.error,
            title: 'Error',
            message:
                'Su sesión ha expirado, por favor inicie sesión nuevamente',
            context: context!);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignIn()),
        );

        WebSocketChnl.instance.disconnect();
        cancelScheduledNotification();
      }

      return false;
    }
  }
}
