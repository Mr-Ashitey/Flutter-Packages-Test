import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  // mock dio error response
  DioError errorMock(Map<String, String> errorResponse) {
    return DioError(
      requestOptions: RequestOptions(path: ''),
      response: Response(
        data: errorResponse,
        statusCode: 400,
        requestOptions: RequestOptions(path: ''),
      ),
      type: DioErrorType.response,
    );
  }

  /*
  ---------------------------------------
    Mock SharedPreferences
  ---------------------------------------
  */
  static void mockSharedPreferences() {
    SharedPreferences.setMockInitialValues({
      'token': accessToken['token'],
      'isLoggedIn': true,
    }); //set values here
  }

  /*
  ---------------------------------------
    Successful Api Returns
  ---------------------------------------
  */

  // login api success mock
  void loginApiSuccessMock() {
    dioAdapter.onPost(
      '/api/login',
      (server) => server.reply(200, accessToken),
      data: userCredentials,
    );
  }

  // register api success mock
  void registerApiSuccessMock() {
    dioAdapter.onPost(
      '/api/register',
      (server) => server.reply(200, {"id": 4, "token": "gfiafiugafiua"}),
      data: userCredentials,
    );
  }

  /*
  ---------------------------------------
    Unsuccessful Api Returns
  ---------------------------------------
  */

  // mock unsuccessful login request
  void loginApiFailureMock() {
    dioAdapter.onPost(
      '/api/login',
      (server) => server.throws(400, errorMock({'error': 'user not found'})),
      data: userCredentials,
    );
  }

  // mock unsuccessful register request
  void registerApiFailureMock() {
    dioAdapter.onPost(
      '/api/register',
      (server) => server.throws(
          400,
          errorMock(
              {'error': 'Note: only defined users succeed registration'})),
      data: userCredentials,
    );
  }
}
