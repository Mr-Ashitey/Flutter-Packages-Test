import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';

import 'api_status.dart';

class RequestApi {
  late Dio _dio;
  final _baseUrl = "https://reqres.in";

  RequestApi() {
    _dio = Dio();
    _dio.options.baseUrl = _baseUrl;
    _dio.interceptors.add(RetryInterceptor(
      dio: _dio,
      logPrint: print, // specify log function
      retries: 3, // retry count
      retryDelays: const [
        Duration(seconds: 1), // wait 1 sec before first retry
        Duration(seconds: 2), // wait 2 sec before second retry
        Duration(seconds: 3), // wait 3 sec before third retry
      ],
    ));
  }

  // named constructor for testing
  RequestApi.test({required Dio dio}) : _dio = dio;

  // handle error response
  Failure _handleError(DioError error) {
    // The request was made and the server responded with a status code
    // that falls out of the range of 2xx and is also not 304.
    if (error.response != null) {
      debugPrint(error.response!.data['error']);
      debugPrint(error.response!.requestOptions.toString());
      return Failure(errorResponse: error.response!.data['error']);
    } else {
      // Something happened in setting up or sending the request that triggered an Error
      debugPrint(error.requestOptions.toString());
      debugPrint(error.message is SocketException
          ? 'Connection Problem'
          : 'Unknown Error');
      return Failure(
          errorResponse: error.message is SocketException
              ? 'Connection Problem'
              : 'Unknown Error');
    }
  }

  // get endpoint
  Future<Response> get(String endpoint, [queryParameters]) async {
    Response response;

    try {
      response = await _dio.get(endpoint, queryParameters: queryParameters);

      return response;
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  // post endpoint
  Future<Response> post(String endpoint, {@required body}) async {
    Response response;

    try {
      response = await _dio.post(endpoint, data: body);

      return response;
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  // patch/update endpoint
  Future<Response> patch(String endpoint, {@required body}) async {
    Response response;

    try {
      response = await _dio.patch(endpoint, data: body);

      return response;
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }
}
