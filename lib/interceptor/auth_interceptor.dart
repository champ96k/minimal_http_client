import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final TokenCallback headerCallback;

  AuthInterceptor({required this.headerCallback});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final Map<String, String>? header = headerCallback();

    if (header != null) {
      options.headers.addAll(header);
    }
    return super.onRequest(options, handler);
  }
}

typedef TokenCallback = Map<String, String>? Function();
