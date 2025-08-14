import 'package:dio/dio.dart';

/// Provides a simple [Dio] client with logging enabled.
class DioClient {
  DioClient._();

  static Dio create() {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://mock.trevelin',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ));
    dio.interceptors.add(LogInterceptor(responseBody: true));
    return dio;
  }
}
