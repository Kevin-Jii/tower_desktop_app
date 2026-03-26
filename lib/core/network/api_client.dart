import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'api_response.dart';
import '../config/app_config.dart';
class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  late final Dio dio;
  String get baseUrl => AppConfig.instance.apiBaseUrl;
  String? _token;
  int? _userId;
  int? _storeId;
  void setToken(String? token) {
    _token = token;
  }
  void setUserInfo({int? userId, int? storeId}) {
    _userId = userId;
    _storeId = storeId;
  }
  ApiClient._internal() {
    dio = Dio(BaseOptions(
      baseUrl: AppConfig.instance.apiBaseUrl,
      connectTimeout: Duration(milliseconds: AppConfig.instance.apiTimeout),
      receiveTimeout: Duration(milliseconds: AppConfig.instance.apiTimeout),
      headers: {
        'Content-Type': 'application/json',
      },
    ));
    dio.httpClientAdapter = IOHttpClientAdapter();
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (_token != null && _token!.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $_token';
        }
        if (_userId != null) {
          options.headers['X-User-Id'] = _userId.toString();
        }
        if (_storeId != null) {
          options.headers['X-Store-Id'] = _storeId.toString();
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (e, handler) {
        if (kDebugMode) {
          debugPrint(
              'API Error: ${e.type} ${e.response?.statusCode} => ${e.message}');
        }
        return handler.next(e);
      },
    ));
  }
  Future<T> get<T>(String path,
      {Map<String, dynamic>? queryParameters,
      T Function(dynamic json)? converter}) async {
    try {
      final resp = await dio.get(path, queryParameters: queryParameters);
      return _extractData<T>(resp, converter, method: 'GET');
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }
  Future<T> post<T>(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      T Function(dynamic json)? converter}) async {
    try {
      final resp =
          await dio.post(path, data: data, queryParameters: queryParameters);
      return _extractData<T>(resp, converter, method: 'POST');
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }
  Future<T> delete<T>(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      T Function(dynamic json)? converter}) async {
    try {
      final resp =
          await dio.delete(path, data: data, queryParameters: queryParameters);
      return _extractData<T>(resp, converter, method: 'DELETE');
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }
  Future<T> request<T>(String path,
      {required String method,
      Object? data,
      Map<String, dynamic>? queryParameters,
      T Function(dynamic json)? converter}) async {
    try {
      final resp = await dio.request(path,
          data: data,
          queryParameters: queryParameters,
          options: Options(method: method));
      return _extractData<T>(resp, converter, method: method.toUpperCase());
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }
  Future<PageResponse<T>> getPage<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic>) itemParser,
  }) async {
    try {
      final resp = await dio.get(path, queryParameters: queryParameters);
      final body = _validateResponse(resp);
      return PageResponse.fromEnvelope(body, itemParser);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }
  Future<PageResponse<T>> postPage<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic>) itemParser,
  }) async {
    try {
      final resp =
          await dio.post(path, data: data, queryParameters: queryParameters);
      final body = _validateResponse(resp);
      return PageResponse.fromEnvelope(body, itemParser);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }
  Future<T?> postSmart<T>({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic>) fromJson,
    bool filterNulls = false,
  }) async {
    try {
      Object? finalData = data;
      if (filterNulls && data is Map<String, dynamic>) {
        finalData = Map<String, dynamic>.from(data)
          ..removeWhere((key, value) => value == null);
      }
      final resp = await dio.post(path,
          data: finalData, queryParameters: queryParameters);
      final body = _validateResponse(resp);
      final responseData = body['data'];
      if (responseData == null) return null;
      if (responseData is Map<String, dynamic>) {
        return fromJson(responseData);
      }
      throw ApiException('响应 data 格式错误，期望 Map，实际为 ${responseData.runtimeType}');
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }
  Future<T?> putSmart<T>({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic>) fromJson,
    bool filterNulls = true,
  }) async {
    try {
      Object? finalData = data;
      if (filterNulls && data is Map<String, dynamic>) {
        finalData = Map<String, dynamic>.from(data)
          ..removeWhere((key, value) => value == null);
      }
      final resp = await dio.put(path,
          data: finalData, queryParameters: queryParameters);
      final body = _validateResponse(resp);
      final responseData = body['data'];
      if (responseData == null) return null;
      if (responseData is Map<String, dynamic>) {
        return fromJson(responseData);
      }
      throw ApiException('响应 data 格式错误，期望 Map，实际为 ${responseData.runtimeType}');
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }
  Future<T> getSmart<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final resp = await dio.get(path, queryParameters: queryParameters);
      final body = _validateResponse(resp);
      final responseData = body['data'];
      if (responseData == null) {
        throw ApiException('GET 请求响应 data 为空');
      }
      if (responseData is Map<String, dynamic>) {
        return fromJson(responseData);
      }
      throw ApiException('响应 data 格式错误，期望 Map，实际为 ${responseData.runtimeType}');
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }
  Future<void> deleteSmart({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      await dio.delete(path, data: data, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }
  Future<List<T>> getListSmart<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final resp = await dio.get(path, queryParameters: queryParameters);
      final body = _validateResponse(resp);
      final outerData = body['data'];
      if (outerData is! Map<String, dynamic>) {
        throw ApiException(
            '响应 data 格式错误，期望包含列表的对象，实际为 ${outerData.runtimeType}');
      }
      final responseData = outerData['list'];
      if (responseData == null) {
        return [];
      }
      if (responseData is List) {
        return responseData
            .map((item) => fromJson(Map<String, dynamic>.from(item)))
            .toList();
      }
      throw ApiException(
          '响应 data.list 格式错误，期望 List，实际为 ${responseData.runtimeType}');
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }
  Future<List<T>> getSimpleList<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final resp = await dio.get(path, queryParameters: queryParameters);
      final body = _validateResponse(resp);
      final responseData = body['data'];
      if (responseData == null) {
        return [];
      }
      if (responseData is List) {
        return responseData
            .map((item) => fromJson(Map<String, dynamic>.from(item)))
            .toList();
      }
      throw ApiException(
          '响应 data 格式错误，期望 List，实际为 ${responseData.runtimeType}');
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }
  ApiException _toApiException(DioException e) {
    String msg;
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        msg = '连接服务器超时';
        break;
      case DioExceptionType.sendTimeout:
        msg = '请求发送超时';
        break;
      case DioExceptionType.receiveTimeout:
        msg = '服务器响应超时';
        break;
      case DioExceptionType.badResponse:
        msg = e.response?.data is Map && (e.response?.data['message'] != null)
            ? e.response?.data['message']
            : '服务器返回错误(${e.response?.statusCode})';
        break;
      case DioExceptionType.cancel:
        msg = '请求已取消';
        break;
      default:
        msg = e.message ?? '网络错误';
    }
    return ApiException(msg, statusCode: e.response?.statusCode);
  }
  T _extractData<T>(Response resp, T Function(dynamic json)? converter,
      {required String method}) {
    final body = _validateResponse(resp);
    if (converter != null) {
      return converter(body);
    }
    final data = body['data'];
    if (T == dynamic) {
      return data as T;
    }
    if (data == null) {
      if (method == 'GET') {
        final typeStr = T.toString();
        if ((typeStr == 'Map<String, dynamic>' ||
                typeStr == 'Map<dynamic, dynamic>') &&
            body.isNotEmpty) {
          return body as T;
        }
        if (typeStr.contains('List') && body.isNotEmpty) {
          throw ApiException(
              'data 字段为空，但响应体无数据 (GET ${resp.requestOptions.path})');
        }
        throw ApiException('data 字段为空 (GET ${resp.requestOptions.path})');
      }
      return null as T;
    }
    final typeStr = T.toString();
    if (typeStr == 'Map<String, dynamic>' ||
        typeStr == 'Map<dynamic, dynamic>') {
      if (data is Map) {
        return Map<String, dynamic>.from(data) as T;
      }
      throw ApiException('data 字段格式不正确，期望 Map，实际为 ${data.runtimeType}');
    }
    if (typeStr.contains('List')) {
      if (data is List) {
        return data as T;
      }
      throw ApiException('data 字段格式不正确，期望 List，实际为 ${data.runtimeType}');
    }
    return data as T;
  }
  Map<String, dynamic> _validateResponse(Response resp) {
    final raw = resp.data;
    dynamic body = raw;
    if (raw is String) {
      try {
        body = json.decode(raw);
      } catch (_) {
        throw ApiException('响应数据格式错误，无法解析 JSON');
      }
    }
    if (body is! Map) {
      throw ApiException('响应格式错误，期望 JSON 对象');
    }
    final code = body['code'];
    if (code != null) {
      final codeInt =
          code is int ? code : (code is double ? code.toInt() : null);
      if (codeInt != null && codeInt != 200) {
        final message = body['message'];
        throw ApiException(message?.toString() ?? '请求失败', statusCode: codeInt);
      }
    }
    return body as Map<String, dynamic>;
  }
  Future<ApiResult<R>> safeCall<R>(Future<Response> Function() action,
      {R Function(dynamic json)? transform}) async {
    try {
      final resp = await action();
      final body = _validateResponse(resp);
      dynamic data = body['data'];
      if (transform != null) {
        data = transform(body);
      }
      return ApiResult.success(data as R);
    } on DioException catch (e) {
      final ex = _toApiException(e);
      return ApiResult.error(ex.message, ex.statusCode);
    } catch (e) {
      return ApiResult.error(e.toString(), null);
    }
  }
}
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  ApiException(this.message, {this.statusCode});
  @override
  String toString() => 'ApiException($statusCode): $message';
}
class ApiResult<T> {
  final T? data;
  final String? error;
  final int? statusCode;
  bool get isSuccess => error == null;
  ApiResult._({this.data, this.error, this.statusCode});
  factory ApiResult.success(T data) => ApiResult._(data: data);
  factory ApiResult.error(String message, int? code) =>
      ApiResult._(error: message, statusCode: code);
  R when<R>(
      {required R Function(T data) success,
      required R Function(String msg, int? code) error}) {
    if (isSuccess) return success(data as T);
    return error(this.error ?? '未知错误', statusCode);
  }
}
