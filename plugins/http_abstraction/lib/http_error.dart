import 'package:http_abstraction/http_abstraction.dart';

abstract class HttpError extends HttpResponse implements Exception {
  HttpError({
    required super.statusCode,
    required super.body,
    required super.request,
    required this.message,
  });

  String message;

  @override
  String toString() =>
      'HttpError { statusCode: $statusCode, message: $message, body: $body, request: $request }';
}

class BadRequestError extends HttpError {
  BadRequestError({
    required super.statusCode,
    required super.body,
    required super.message,
    required super.request,
  });

  factory BadRequestError.empty() => BadRequestError(
        statusCode: 400,
        body: {},
        message: 'Bad Request',
        request: HttpRequest.empty(),
      );
}

class NotFoundError extends HttpError {
  NotFoundError({
    required super.statusCode,
    required super.body,
    required super.message,
    required super.request,
  });

  factory NotFoundError.empty() => NotFoundError(
        statusCode: 404,
        body: {},
        message: 'Not Found',
        request: HttpRequest.empty(),
      );
}

class ServerError extends HttpError {
  ServerError({
    required super.statusCode,
    required super.body,
    required super.message,
    required super.request,
  });
}

class UnauthorizedError extends HttpError {
  UnauthorizedError({
    required super.statusCode,
    required super.body,
    required super.message,
    required super.request,
  });

  factory UnauthorizedError.empty() => UnauthorizedError(
        statusCode: 401,
        body: {},
        message: 'Unauthorized',
        request: HttpRequest(
          endpoint: '',
          queryParameters: {},
          body: HttpBodyJson({}),
          headers: {},
          method: HttpMethodEnum.get,
          baseUrl: '',
        ),
      );
}

class ForbiddenError extends HttpError {
  ForbiddenError({
    required super.statusCode,
    required super.body,
    required super.message,
    required super.request,
  });
}

class InvalidDataError extends HttpError {
  InvalidDataError({
    required super.statusCode,
    required super.body,
    required super.message,
    required super.request,
  });
}

class NoInternetError extends HttpError {
  NoInternetError({
    required super.statusCode,
    required super.body,
    required super.message,
    required super.request,
  });
}

class TimeoutError extends HttpError {
  TimeoutError({
    required super.statusCode,
    required super.body,
    required super.message,
    required super.request,
  });
}

class UnknownError extends HttpError {
  UnknownError({
    required super.statusCode,
    required super.body,
    required super.message,
    required super.request,
  });

  factory UnknownError.empty() => UnknownError(
        statusCode: 0,
        body: {},
        message: '',
        request: HttpRequest(
          endpoint: '',
          method: HttpMethodEnum.get,
          queryParameters: {},
          body: HttpBodyJson({}),
          headers: {},
          baseUrl: '',
        ),
      );
}
