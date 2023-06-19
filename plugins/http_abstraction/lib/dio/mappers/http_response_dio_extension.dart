import 'package:dio/dio.dart';
import 'package:http_abstraction/dio/request_options_impl.dart';

import 'package:http_abstraction/http_abstraction.dart';
import 'package:http_abstraction/dio/mappers/http_request_dio_extension.dart';

extension DioResponseExtension on Response {
  HttpResponse toHttpResponse() {
    final options = requestOptions as RequestOptionsImpl;
    var body = <String, Object?>{};
    if (data == null) {
      body = {};
    } else if (data is String) {
      // ignore: avoid_dynamic_calls
      if (data.isEmpty) {
        body = {};
      }

      body = {'data': data};
    } else if (data is Map) {
      body = Map<String, dynamic>.from(data);
    }

    return HttpResponse(
      statusCode: statusCode!,
      body: body,
      header: headers.isEmpty ? null : headers.map,
      request: options.toHttpRequest(),
    );
  }

  Map<String, Object?> dataAsObject() {
    if (data == null) {
      return {};
    }

    if (data is String) {
      return {};
    }

    return data;
  }
}

extension DioHttpResponseExtension on HttpResponse {
  Response toResponse() => Response(
        data: body,
        headers: Headers.fromMap(header ?? {}),
        statusCode: statusCode,
        requestOptions: request.toRequestOptions(),
      );
}
