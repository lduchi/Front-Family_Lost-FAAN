import 'package:dio/dio.dart';
import 'package:familylost_faan/ServiciosApp/dto/login_request.dart';
import 'package:familylost_faan/ServiciosApp/utils/dio_client.dart';
import 'package:familylost_faan/environment/environment.dart';
import 'package:familylost_faan/pages/pages.dart';
import 'package:familylost_faan/utilities/enum/dialog_type.dart';
import 'package:familylost_faan/utilities/texts/app_strings.dart';
import 'package:flutter/material.dart';

class AuthService {
  late final Dio _dio;

  AuthService() {
    _dio = DioClient().instance;
  }

  String endPointUrl = baseUrl + '/auth';

  Future<Map<String, dynamic>?> login(AuthenticationRequest loginRequest, BuildContext context) async {
    var url = '$endPointUrl/authenticate';
    try {
      final response = await _dio.post(
        url,
        data: loginRequest.toJson(),
        options: Options(
          extra: {'context': context},
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
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
    return null;  // no aseguramos que retorne null
  }
}
