import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_abstraction/dio/interceptor/http_interceptor_dio_adapter.dart';
import 'package:http_abstraction/dio/mappers/http_error_dio_extension.dart';
import 'package:http_abstraction/dio/mappers/http_request_dio_extension.dart';
import 'package:http_abstraction/dio/mappers/http_response_dio_extension.dart';
import 'package:http_abstraction/http_abstraction.dart';
import 'package:result/result.dart';

class HttpClientDio implements IHttpClient {
  HttpClientDio({
    required this.client,
    required this.onError,
  });

  final Dio client;
  final void Function(Object error, StackTrace stack) onError;

  @override
  Future<Result<HttpError, HttpResponse>> post({
    required String endpoint,
    Map<String, Object?>? queryParameters,
    HttpBody? body,
    Map<String, Object?>? headers,
    Map<String, String>? filePaths,
  }) async {
    final request = HttpRequest(
      endpoint: endpoint,
      queryParameters: queryParameters ?? {},
      body: body ?? HttpBodyJson({}),
      headers: headers ?? {},
      method: HttpMethodEnum.post,
      baseUrl: client.options.baseUrl,
    );

    return fetch(request);
  }

  @override
  Future<Result<HttpError, HttpResponse>> get({
    required String endpoint,
    Map<String, Object?>? queryParameters,
    Map<String, Object?>? headers,
  }) async {
    final request = HttpRequest(
      endpoint: endpoint,
      queryParameters: queryParameters ?? {},
      headers: headers ?? {},
      body: HttpBodyJson({}),
      method: HttpMethodEnum.get,
      baseUrl: client.options.baseUrl,
    );

    return fetch(request);
  }

  @override
  Future<Result<HttpError, HttpResponse>> put({
    required String endpoint,
    Map<String, Object?>? queryParameters,
    HttpBody? body,
    Map<String, Object?>? headers,
  }) async {
    final request = HttpRequest(
      endpoint: endpoint,
      queryParameters: queryParameters ?? {},
      body: body ?? HttpBodyJson({}),
      headers: headers ?? {},
      method: HttpMethodEnum.put,
      baseUrl: client.options.baseUrl,
    );

    return fetch(request);
  }

  @override
  Future<Result<HttpError, HttpResponse>> patch({
    required String endpoint,
    Map<String, Object?>? queryParameters,
    HttpBody? body,
    Map<String, Object?>? headers,
  }) async {
    final request = HttpRequest(
      endpoint: endpoint,
      queryParameters: queryParameters ?? {},
      body: body ?? HttpBodyJson({}),
      headers: headers ?? {},
      method: HttpMethodEnum.patch,
      baseUrl: client.options.baseUrl,
    );

    return fetch(request);
  }

  @override
  Future<Result<HttpError, HttpResponse>> delete({
    required String endpoint,
    Map<String, Object?>? queryParameters,
    HttpBody? body,
    Map<String, Object?>? headers,
  }) async {
    final request = HttpRequest(
      endpoint: endpoint,
      queryParameters: queryParameters ?? {},
      body: body ?? HttpBodyJson({}),
      headers: headers ?? {},
      method: HttpMethodEnum.delete,
      baseUrl: client.options.baseUrl,
    );

    return fetch(request);
  }

  @override
  Future<Result<HttpError, HttpResponse>> fetch(HttpRequest request) async =>
      _safe(
        () async => client.fetch(request.toRequestOptions()),
        request,
      );

  Future<Result<HttpError, HttpResponse>> _safe(
    Future<Response> Function() execute,
    HttpRequest request,
  ) async {
    try {
      final response = await execute();
      return Ok(
        _getHttpResponse(
          response,
        ),
      );
    } on DioError catch (e, s) {
      final error = e.toHttpError();

      if (error is UnknownError) {
        onError(e, s);
      }

      debugPrint('HttpClientDio error: $e');

      return Err(error);
    } catch (e, s) {
      onError(e, s);
      debugPrint(e.toString());
      return Err(
        UnknownError(
          body: {},
          message: e.toString(),
          statusCode: -1,
          request: request,
        ),
      );
    }
  }

  HttpResponse _getHttpResponse(Response response) => response.toHttpResponse();

  @override
  void addInterceptor(HttpInterceptor interceptor) {
    client.interceptors.add(
      HttpInterceptorDioAdapter(
        httpInterceptor: interceptor,
      ),
    );
  }
}
