import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_status.dart';

class RequestApi {
  late Dio _dio;
  final _baseUrl = "https://reqres.in";

  RequestApi() {
    _dio = Dio();
    _dio.options.baseUrl = _baseUrl;
  }

  // named constructor for testing
  RequestApi.test({required Dio dio}) : _dio = dio;

  // get endpoint
  Future<Response> get(String endpoint, [queryParameters]) async {
    Response response;

    try {
      response = await _dio.get(endpoint, queryParameters: queryParameters);

      return response;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        debugPrint(e.response!.data['error']);
        debugPrint(e.response!.requestOptions.toString());
        throw Failure(errorResponse: e.response!.data['error']);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        debugPrint(e.requestOptions.toString());
        debugPrint(e.message is SocketException
            ? 'Connection Problem'
            : 'Unknown Error');
        throw Failure(
            errorResponse: e.message is SocketException
                ? 'Connection Problem'
                : 'Unknown Error');
      }
    }
  }

  // post endpoint
  Future<Response> post(String endpoint, {@required body}) async {
    Response response;

    try {
      response = await _dio.post(endpoint, data: body);

      return response;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        debugPrint(e.response!.data['error']);
        debugPrint(e.response!.requestOptions.toString());
        throw Failure(errorResponse: e.response!.data['error']);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        debugPrint(e.requestOptions.toString());
        debugPrint(e.message);
        throw Failure(
            errorResponse: e.message is SocketException
                ? 'Connection Problem'
                : 'Unknown Error');
      }
    }
  }

  // patch/update endpoint
  Future<Response> patch(String endpoint, {@required body}) async {
    Response response;

    try {
      response = await _dio.patch(endpoint, data: body);

      return response;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        debugPrint(e.response!.data['error']);
        debugPrint(e.response!.requestOptions.toString());
        throw Failure(errorResponse: e.response!.data['error']);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        debugPrint(e.requestOptions.toString());
        debugPrint(e.message);
        throw Failure(
            errorResponse: e.message is SocketException
                ? 'Connection Problem'
                : 'Unknown Error');
      }
    }
  }
}
