import 'package:dio/dio.dart';
import 'package:familylost_faan/ServiciosApp/interceptors/dio_interceptor.dart';

class DioClient {
  static final DioClient _singleton = DioClient._internal();
  late final Dio _dio;

  factory DioClient() {
    return _singleton;
  }

  DioClient._internal() {
    _dio = Dio();
    _dio.interceptors.add(DioInterceptor());
  }

  Dio get instance => _dio;
}