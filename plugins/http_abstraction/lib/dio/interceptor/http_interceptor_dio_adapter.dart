import 'package:dio/dio.dart';
import 'package:http_abstraction/dio/request_options_impl.dart';
import 'package:http_abstraction/http_abstraction.dart';
import 'package:http_abstraction/dio/mappers/http_request_dio_extension.dart';
import 'package:http_abstraction/dio/mappers/http_error_dio_extension.dart';
import 'package:http_abstraction/dio/mappers/http_response_dio_extension.dart';
import 'package:http_abstraction/dio/interceptor/handler/http_error_interceptor_handler_adapter_dio.dart';
import 'package:http_abstraction/dio/interceptor/handler/http_request_interceptor_handler_adapter_dio.dart';
import 'package:http_abstraction/dio/interceptor/handler/http_response_interceptor_handler_adapter_dio.dart';

class HttpInterceptorDioAdapter extends Interceptor {
  HttpInterceptorDioAdapter({
    required this.httpInterceptor,
  });

  final HttpInterceptor httpInterceptor;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    httpInterceptor.onRequest(
      (options as RequestOptionsImpl).toHttpRequest(),
      RequestInterceptorHandlerAdapterDio(handler),
    );
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    httpInterceptor.onResponse(
      response.toHttpResponse(),
      ResponseInterceptorHandlerAdapterDio(handler),
    );
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    httpInterceptor.onError(
      err.toHttpError(),
      ErrorInterceptorHandlerAdapterDio(handler),
    );
  }
}
