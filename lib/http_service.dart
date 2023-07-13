library minimal_http_client;

import 'package:dio/dio.dart';
export 'dio_http_service.dart';
export 'interceptor/auth_interceptor.dart';

/// Abstract class that provides methods for handling HTTP requests.
abstract class HttpService {
  /// Performs a GET request to the specified [path] with optional [headers].
  Future<Response> handleGetRequest(
    String path, {
    Map<String, String>? headers,
  });

  /// Performs a POST request to the specified [path] with the given [data],
  /// and optional [headers].
  Future<Response> handlePostRequest(
    String path,
    dynamic data, {
    Map<String, String>? headers,
  });

  /// Performs a POST request to the specified [path] with a list of [data] items,
  /// and optional [headers].
  Future<Response> handlePostRequestList(
    String path,
    List<dynamic>? data, {
    Map<String, String>? headers,
  });

  /// Performs a PUT request to the specified [path] with optional [data] and [headers].
  Future<Response> handlePutRequest(
    String path, {
    Map<String, dynamic>? data,
    Map<String, String>? headers,
  });

  /// Performs a DELETE request to the specified [path] with optional [headers].
  Future<Response> handleDeleteRequest(
    String path, {
    Map<String, String>? headers,
  });

  /// Performs a GET request to the specified [path] without including any authentication token.
  Future<Response> handleGetRequestWithoutToken(String path);

  /// Performs a POST request to the specified [path] without including any authentication token.
  /// Accepts an optional [data] parameter.
  Future<Response> handlePostRequestWithoutToken(
    String path, [
    Map<String, dynamic>? data,
  ]);

  /// Performs a PUT request to the specified [path] without including any authentication token.
  /// Accepts an optional [data] parameter.
  Future<Response> handlePutRequestWithoutToken(
    String path, [
    Map<String, dynamic>? data,
  ]);

  /// Performs a DELETE request to the specified [path] without including any authentication token.
  Future<Response> handleDeleteRequestWithoutToken(String path);
}
