import 'dart:async';
import 'dart:io';

import 'package:minimal_http_client/http_service.dart';
import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info/package_info.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// A concrete implementation of the [HttpService] interface using the [dio] package.
class DioHttpService implements HttpService {
  factory DioHttpService() => instance;

  DioHttpService.internal() {
    /// Interceptor for pretty logging of Dio requests and responses
    final Interceptor prettyInterceptor = PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    );

    /// Initialize the Dio instance with default options and adapters
    _dio = Dio(BaseOptions(connectTimeout: const Duration(milliseconds: 10000)))
      ..httpClientAdapter = Http2Adapter(ConnectionManager())
      ..interceptors.add(
        LogInterceptor(
          request: true,
          requestBody: false,
          requestHeader: false,
          responseBody: false,
          responseHeader: false,
        ),
      );

    /// Add the pretty logger interceptor only in debug mode
    if (kDebugMode) {
      _dio.interceptors.add(prettyInterceptor);
    }
  }

  /// Singleton instance of DioHttpService
  static final DioHttpService instance = DioHttpService.internal();

  late Dio _dio;
  String? appVersion;
  String platform = "";
  String appId = "";

  /// Initializes the DioHttpService instance.
  /// Retrieves package information, sets platform details, and adds an optional auth interceptor.
  Future<void> init({Interceptor? authInterceptor}) async {
    if (Platform.isAndroid) {
      platform = "android";
    }
    if (Platform.isIOS) {
      platform = "ios";
    }
    if (authInterceptor != null) {
      _dio.interceptors.add(authInterceptor);
    }

    await PackageInfo.fromPlatform().then((packageInfo) {
      appVersion = packageInfo.version;
      appId = packageInfo.packageName;
    });
  }

  @override
  Future<Response> handleGetRequest(
    String path, {
    Map<String, String?>? headers,
  }) async {
    return await _dio.get(
      path,
      options: await getOptionWithToken(headers: headers),
    );
  }

  @override
  Future<Response> handlePostRequest(
    String path,
    dynamic data, {
    Map<String, String>? headers,
  }) async {
    return await _dio.post(
      path,
      data: data,
      options: await getOptionWithToken(headers: headers),
    );
  }

  @override
  Future<Response> handlePutRequest(
    String path, {
    Map<String, dynamic>? data,
    Map<String, String>? headers,
  }) async {
    return await _dio.put(
      path,
      data: data,
      options: await getOptionWithToken(headers: headers),
    );
  }

  @override
  Future<Response> handleDeleteRequest(
    String path, {
    Map<String, String>? headers,
  }) async {
    return _dio.delete(
      path,
      options: await getOptionWithToken(headers: headers),
    );
  }

  @override
  Future<Response> handleGetRequestWithoutToken(String path) async {
    return await _dio.get(
      path,
      options: getOptionWithoutToken(),
    );
  }

  @override
  Future<Response> handlePostRequestWithoutToken(String path,
      [Map<String, dynamic>? data]) async {
    return await _dio.post(
      path,
      data: data,
      options: getOptionWithoutToken(),
    );
  }

  @override
  Future<Response> handlePutRequestWithoutToken(String path,
      [Map<String, dynamic>? data]) async {
    return await _dio.put(
      path,
      data: data,
      options: getOptionWithoutToken(),
    );
  }

  @override
  Future<Response> handleDeleteRequestWithoutToken(String path) async {
    return _dio.delete(
      path,
      options: getOptionWithoutToken(),
    );
  }

  @override
  Future<Response> handlePostRequestList(String path, List<dynamic>? data,
      {Map<String, String>? headers}) async {
    return await _dio.post(
      path,
      data: data,
      options: await getOptionWithToken(headers: headers),
    );
  }

  /// Helper method to generate request options with authentication headers.
  Future<Options> getOptionWithToken({Map<String, String?>? headers}) async {
    final Map<String, String?> headers0 = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      'app_version': appVersion,
      'platform': platform,
      'app_id': appId,
    };

    if (headers != null) {
      headers0.addAll(headers);
    }

    /// Get the `AuthInterceptor` instance
    final authInterceptor =
        _dio.interceptors.whereType<AuthInterceptor>().firstOrNull;

    if (authInterceptor != null) {
      /// Retrieve the [header] through the callback
      final Map<String, String>? headerInfo = authInterceptor.headerCallback();
      if (headerInfo != null) {
        headers0.addAll(headerInfo);
      }
    }

    return Options(headers: headers0);
  }

  /// Helper method to generate request options without authentication headers.
  Options getOptionWithoutToken() {
    final header0 = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      'app_version': appVersion,
      'platform': platform,
      'app_id': appId,
    };
    return Options(headers: header0);
  }
}
