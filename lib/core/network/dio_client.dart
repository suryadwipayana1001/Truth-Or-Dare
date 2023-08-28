import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';
import '../core.dart';

class DioClient {
  static late Dio _dio;
  final AppInterceptor appInterceptor = AppInterceptor();
  addInterception() {
    _dio.interceptors.addAll([appInterceptor, dioLoggerInterceptor]);
  }

  DioClient() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      validateStatus: (status) => (status! >= 200) && (status < 400),
    ));
    addInterception();
  }

  Dio get dio => _dio;
}
