import 'package:dio/dio.dart';
import 'package:http_abstraction/http_body.dart';

class RequestOptionsImpl extends RequestOptions {
  RequestOptionsImpl({
    required super.path,
    required super.method,
    required super.baseUrl,
    required super.queryParameters,
    required super.data,
    required super.headers,
    required this.body,
  });

  final HttpBody body;

  Map<String, dynamic> toJson() => {
        'path': path,
        'method': method,
        'baseUrl': baseUrl,
        'queryParameters': queryParameters,
        'data': data,
        'headers': headers,
        'body': body.toString(),
      };
}
