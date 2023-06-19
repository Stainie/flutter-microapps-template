import 'package:http_abstraction/http_abstraction.dart';

class HttpResponse {
  HttpResponse({
    required this.statusCode,
    required this.body,
    required this.request,
    this.header,
  });

  factory HttpResponse.empty() => HttpResponse(
        statusCode: 0,
        body: {},
        request: HttpRequest.empty(),
      );

  final int statusCode;
  final Map<String, Object?> body;
  final Map<String, List<String>>? header;
  final HttpRequest request;

  HttpResponse copyWith({
    int? statusCode,
    Map<String, Object?>? body,
    Map<String, List<String>>? header,
    HttpRequest? request,
  }) =>
      HttpResponse(
        statusCode: statusCode ?? this.statusCode,
        body: body ?? this.body,
        header: header ?? this.header,
        request: request ?? this.request,
      );

  @override
  String toString() =>
      'HttpResponse { statusCode: $statusCode, body: $body, header: $header, request: $request }';
}
