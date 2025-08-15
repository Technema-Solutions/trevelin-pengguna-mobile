import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../core/logging/http_logger_interceptor.dart';
import '../../core/utils/retry.dart';

/// Provides a simple [Dio] client with logging enabled.
class DioClient {
  DioClient._();

  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://mock.trevelin',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    // Only log HTTP traffic in debug builds.
    if (!kReleaseMode) {
      dio.interceptors.add(HttpLoggerInterceptor());
    }

    // Retry idempotent GET requests with backoff.
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (e, handler) async {
          if (e.requestOptions.method.toUpperCase() == 'GET' &&
              e.type != DioExceptionType.cancel &&
              e.requestOptions.extra['retries'] == null) {
            e.requestOptions.extra['retries'] = 1;
            try {
              final response = await retryWithBackoff(() => dio.fetch(e.requestOptions));
              return handler.resolve(response);
            } catch (_) {}
          }
          handler.next(e);
        },
      ),
    );

    return dio;
  }
}
