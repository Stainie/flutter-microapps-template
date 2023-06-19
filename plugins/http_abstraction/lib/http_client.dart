import 'package:http_abstraction/http_abstraction.dart';
import 'package:result/result.dart';

abstract class IHttpClient {
  Future<Result<HttpError, HttpResponse>> get({
    required String endpoint,
    Map<String, Object?>? queryParameters,
    Map<String, Object?>? headers,
  });

  Future<Result<HttpError, HttpResponse>> post({
    required String endpoint,
    Map<String, Object?>? queryParameters,
    HttpBody? body,
    Map<String, Object?>? headers,
    Map<String, String>? filePaths,
  });

  Future<Result<HttpError, HttpResponse>> put({
    required String endpoint,
    Map<String, Object?>? queryParameters,
    HttpBody? body,
    Map<String, Object?>? headers,
  });

  Future<Result<HttpError, HttpResponse>> patch({
    required String endpoint,
    Map<String, Object?>? queryParameters,
    HttpBody? body,
    Map<String, Object?>? headers,
  });

  Future<Result<HttpError, HttpResponse>> delete({
    required String endpoint,
    Map<String, Object?>? queryParameters,
    HttpBody? body,
    Map<String, Object?>? headers,
  });

  Future<Result<HttpError, HttpResponse>> fetch(HttpRequest request);

  void addInterceptor(HttpInterceptor interceptor);
}
