import 'package:http_abstraction/http_body.dart';

class HttpRequest {
  HttpRequest({
    required this.baseUrl,
    required this.endpoint,
    required this.queryParameters,
    required this.body,
    required this.headers,
    required this.method,
  });

  factory HttpRequest.empty() => HttpRequest(
        endpoint: '',
        queryParameters: {},
        body: HttpBodyJson({}),
        headers: {},
        method: HttpMethodEnum.get,
        baseUrl: '',
      );

  final String baseUrl;
  final String endpoint;
  final Map<String, Object?> queryParameters;
  final HttpBody body;
  final Map<String, Object?> headers;
  final HttpMethodEnum method;

  HttpRequest copyWith({
    String? baseUrl,
    String? endpoint,
    Map<String, Object?>? queryParameters,
    HttpBody? body,
    Map<String, Object?>? headers,
    HttpMethodEnum? method,
  }) =>
      HttpRequest(
        baseUrl: baseUrl ?? this.baseUrl,
        endpoint: endpoint ?? this.endpoint,
        queryParameters: queryParameters ?? this.queryParameters,
        body: body ?? this.body,
        headers: headers ?? this.headers,
        method: method ?? this.method,
      );

  @override
  String toString() =>
      'HttpRequest { baseUrl: $baseUrl, endpoint: $endpoint, queryParameters: $queryParameters, body: $body, headers: $headers, method: $method }';
}

enum HttpMethodEnum {
  get,
  post,
  put,
  patch,
  delete,
}
