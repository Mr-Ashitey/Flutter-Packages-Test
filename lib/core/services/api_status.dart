//* Code refers to the error or success code
//* Response/ErrorResponse refers to the object returned
class Success {
  int? code;
  Object? response;
  Success({this.code, this.response});
}

class Failure {
  int? code;
  Object? errorResponse;
  Failure({this.code, this.errorResponse});
}
