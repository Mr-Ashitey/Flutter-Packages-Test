import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class RequstApi {
  late Dio _dio;
  final _baseUrl = "https://reqres.in/";

  RequstApi() {
    _dio = Dio();
    _dio.options.baseUrl = _baseUrl;
  }

  // get endpoint
  Future<Response> get(String endpoint) async {
    Response response;

    try {
      response = await _dio.get(endpoint);

      return response;
    } on DioError catch (e) {
      debugPrint(e.toString());
      throw Exception(e.message);
    }
  }

  // post endpoint
  Future<Response> post(String endpoint, {@required body}) async {
    Response response;

    try {
      response = await _dio.post(endpoint, data: body);

      return response;
    } on DioError catch (e) {
      debugPrint(e.toString());
      throw Exception(e.message);
    }
  }

  // patch/update endpoint
  Future<Response> patch(String endpoint, {@required body}) async {
    Response response;

    try {
      response = await _dio.patch(endpoint, data: body);

      return response;
    } on DioError catch (e) {
      debugPrint(e.toString());
      throw Exception(e.message);
    }
  }
}
