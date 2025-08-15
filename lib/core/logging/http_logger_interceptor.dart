import 'package:dio/dio.dart';
import 'app_logger.dart';

/// Logs HTTP requests and responses without including bodies for PII safety.
class HttpLoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.d('REQ ${options.method} ${options.uri}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.d('RES ${response.statusCode} ${response.requestOptions.uri}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.e('HTTP ERR ${err.requestOptions.uri}', err, err.stackTrace);
    handler.next(err);
  }
}
