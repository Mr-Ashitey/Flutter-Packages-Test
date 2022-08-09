import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:packages_flutter/core/services/api_request.dart';
import 'package:packages_flutter/core/services/api_status.dart';

void main() {
  late RequestApi mockRequestApi;
  late final DioAdapter dioAdapter;
  late final Dio dio;

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio, matcher: const FullHttpRequestMatcher());
    mockRequestApi = RequestApi.test(dio: dio);
    dioAdapter.onGet(
      '/api/login',
      (server) => server.throws(
          200,
          DioError(
            error: SocketException,
            requestOptions: RequestOptions(path: ''),
          )),
    );
  });

  test('Testing all socket exception', () async {
    expectLater(mockRequestApi.get("/api/login"), throwsA(isA<Failure>()));
  });
}
