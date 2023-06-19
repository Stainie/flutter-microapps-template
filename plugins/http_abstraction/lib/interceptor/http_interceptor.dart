import 'package:http_abstraction/http_abstraction.dart';

class HttpInterceptor {
  Future onRequest(
    HttpRequest request,
    IRequestInterceptorHandler handler,
  ) async {
    handler.next(request);
  }

  Future onError(
    HttpError err,
    IErrorInterceptorHandler handler,
  ) async {
    handler.next(err);
  }

  Future onResponse(
    HttpResponse response,
    IResponseInterceptorHandler handler,
  ) async {
    handler.next(response);
  }
}
