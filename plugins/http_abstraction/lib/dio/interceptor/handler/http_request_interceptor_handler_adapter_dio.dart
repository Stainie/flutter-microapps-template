import 'package:dio/dio.dart';

import 'package:http_abstraction/http_abstraction.dart';
import 'package:http_abstraction/dio/mappers/http_request_dio_extension.dart';
import 'package:http_abstraction/dio/mappers/http_error_dio_extension.dart';
import 'package:http_abstraction/dio/mappers/http_response_dio_extension.dart';

class RequestInterceptorHandlerAdapterDio
    implements IRequestInterceptorHandler {
  RequestInterceptorHandlerAdapterDio(this.handler);
  final RequestInterceptorHandler handler;

  @override
  void next(HttpRequest request) {
    handler.next(request.toRequestOptions());
  }

  @override
  void reject(HttpError error) {
    handler.reject(error.toDioError());
  }

  @override
  void resolve(HttpResponse request) {
    handler.resolve(request.toResponse());
  }
}
