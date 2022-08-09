import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

class APIMocks {
  late final DioAdapter dioAdapter;
  late final Dio dio;

  APIMocks() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio, matcher: const FullHttpRequestMatcher());
  }

  // constant credentials for testing
  static const accessToken = <String, dynamic>{
    'token': 'ACCESS_TOKEN',
  };
  static const userCredentials = <String, dynamic>{
    'email': 'test@example.com',
    'password': 'password',
  };

  // login api success mock
  void loginApiSuccessMock() {
    dioAdapter.onPost(
      '/api/login',
      (server) => server.reply(200, accessToken),
      data: userCredentials,
    );
  }
}
