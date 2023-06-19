import 'package:dio/dio.dart';

import 'package:http_abstraction/http_abstraction.dart';
import 'package:http_abstraction/dio/mappers/http_error_dio_extension.dart';
import 'package:http_abstraction/dio/mappers/http_response_dio_extension.dart';

class ResponseInterceptorHandlerAdapterDio
    implements IResponseInterceptorHandler {
  ResponseInterceptorHandlerAdapterDio(this.handler);

  final ResponseInterceptorHandler handler;

  @override
  void next(HttpResponse request) {
    handler.next(request.toResponse());
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
