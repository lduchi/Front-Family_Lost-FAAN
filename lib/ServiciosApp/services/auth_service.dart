import 'package:dio/dio.dart';
import 'package:familylost_faan/ServiciosApp/dto/login_request.dart';
import 'package:familylost_faan/environment/environment.dart';
import 'package:familylost_faan/pages/pages.dart';
import 'package:familylost_faan/utilities/enum/dialog_type.dart';
import 'package:familylost_faan/utilities/texts/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:familylost_faan/ServiciosApp/interceptors/dio_interceptor.dart';

class AuthService {
  late final Dio _dio;

  AuthService() {
    _dio = Dio();
    _dio.interceptors.add(DioInterceptor());
  }

  String endPointUrl = baseUrl + '/auth';

  login(LoginRequest loginRequest, BuildContext context) async {
    var url = '$endPointUrl/signin';
    try {
      final response = await _dio.post(
        url,
        data: loginRequest.toJson(),
        options: Options(
          extra: {'context': context},
        ),
      );

      print(response.data);

      if (response.statusCode == 200) {
        return response.data['token'];
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        switch (e.response!.statusCode) {
          case 401:
            CustomMaterialDialog.close(
              context: context,
              type: DialogType.loading,
            );

            CustomMaterialDialog.successOrError(
              context: context,
              type: DialogType.error,
              title: AppStrings.error,
              message: AppStrings.errorLogin,
            );

            break;
        }
      } else if (e.type == DioExceptionType.connectionError) {
        CustomMaterialDialog.warning(
          context: context,
          type: DialogType.warning,
          title: AppStrings.error,
          message: AppStrings.errorConnection,
        );
      }
    } catch (e, stackTrace) {
      debugPrint('Failed to login: $e');
      debugPrint('Stack trace: $stackTrace');
      throw Exception('Failed to login: $e');
    }
  }
}
