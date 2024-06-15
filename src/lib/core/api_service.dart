import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

class ApiService {
  static final _instance = ApiService._internal();

  factory ApiService() {
    return _instance;
  }

  final Dio dio = Dio();
  late final Talker _talker = Talker();

  ApiService._internal() {
    final talkerDioLogger = TalkerDioLogger(
      talker: _talker,
      settings: const TalkerDioLoggerSettings(
        printRequestHeaders: kDebugMode,
        printRequestData: kDebugMode,
        printResponseMessage: kDebugMode,
        printResponseData: kDebugMode,
        printResponseHeaders: false,
      ),
    );

    dio.options
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 30);

    dio.interceptors
      ..add(talkerDioLogger)
      ..add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            // Do something before request is sent
            return handler.next(options); //continue
            // 如果你想完成请求并返回一些自定义数据，你可以resolve一个Response对象 `handler.resolve(response)`。
            // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
            //
            // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象,如`handler.reject(error)`，
            // 这样请求将被中止并触发异常，上层catchError会被调用。
          },
          onResponse: (response, handler) {
            // Do something with response data
            return handler.next(response); // continue
            // 如果你想终止请求并触发一个错误,你可以 reject 一个`DioError`对象,如`handler.reject(error)`，
            // 这样请求将被中止并触发异常，上层catchError会被调用。
          },
          onError: (DioException e, handler) {
            // Do something with response error
            return handler.next(e); //continue
            // 如果你想完成请求并返回一些自定义数据，可以resolve 一个`Response`,如`handler.resolve(response)`。
            // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
          },
        ),
      );
  }

  void setBaseUrl(String baseUrl) {
    dio.options.baseUrl = baseUrl;
  }

  void setToken(String token) {
    dio.options.headers['token'] = token;
  }

  Future get(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      dio.options.headers['operationID'] = DateTime.now().millisecondsSinceEpoch.toString();

      final response = await dio.get(path, queryParameters: queryParams);

      if (response.statusCode == 200) {
        final result = ApiResponse.fromJson(response.data as Map<String, dynamic>);

        if (result.errCode == 0) {
          return result.data;
        } else {
          return Future.error(result.errMsg);
        }
      }

      return Future.error(response.data);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future post(String path, {Map<String, dynamic>? data, String? token}) async {
    try {
      dio.options.headers['operationID'] = DateTime.now().millisecondsSinceEpoch.toString();

      final response = await dio.post(path, data: data);

      if (response.statusCode == 200) {
        final result = ApiResponse.fromJson(response.data as Map<String, dynamic>);

        if (result.errCode == 0) {
          return result.data;
        } else {
          return Future.error(result.errMsg);
        }
      }

      return Future.error(response.data);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future download(
    String url, {
    required String cachePath,
    CancelToken? cancelToken,
    Function(int count, int total)? onProgress,
  }) {
    return dio.download(
      url,
      cachePath,
      cancelToken: cancelToken,
      onReceiveProgress: onProgress,
    );
  }

  void _handleError(DioException error) {
    // Log the error using Talker
    _talker.error("DioError: ${error.message}", error);
  }
}

class ApiResponse {
  int errCode;
  String errMsg;
  String errDlt;
  dynamic data;

  ApiResponse.fromJson(Map<String, dynamic> map)
      : errCode = map["errCode"] ?? -1,
        errMsg = map["errMsg"] ?? '',
        errDlt = map["errDlt"] ?? '',
        data = map["data"];

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['errCode'] = errCode;
    data['errMsg'] = errMsg;
    data['errDlt'] = errDlt;
    data['data'] = data;
    return data;
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
