import 'package:dio/dio.dart';
import 'package:http_abstraction/dio/request_options_impl.dart';

import 'package:http_abstraction/http_abstraction.dart';
import 'package:http_abstraction/dio/mappers/http_request_dio_extension.dart';
import 'package:http_abstraction/dio/mappers/http_response_dio_extension.dart';

extension DioErrorExtension on DioError {
  HttpError toHttpError() {
    final code = response?.statusCode ?? -1;
    final options = requestOptions as RequestOptionsImpl;
    return _errorMap[code]?.call(
          this,
          options.toHttpRequest(),
        ) ??
        UnknownError(
          body: {},
          message: message ?? 'Unknown error',
          statusCode: code,
          request: options.toHttpRequest(),
        );
  }
}

extension DioHttpErrorExtension on HttpError {
  DioError toDioError() => DioError(
        requestOptions: request.toRequestOptions(),
        response: toResponse(),
        error: this,
      );
}

Map<int, HttpError Function(DioError, HttpRequest)> _errorMap = {
  400: (e, r) => BadRequestError(
        body: e.response?.dataAsObject() ?? {},
        message: e.message ?? 'Bad request',
        statusCode: 400,
        request: r,
      ),
  401: (e, r) => UnauthorizedError(
        body: e.response?.dataAsObject() ?? {},
        message: e.message ?? 'Unauthorized',
        statusCode: 401,
        request: r,
      ),
  403: (e, r) => ForbiddenError(
        body: e.response?.dataAsObject() ?? {},
        message: e.message ?? 'Forbidden',
        statusCode: 403,
        request: r,
      ),
  404: (e, r) => NotFoundError(
        body: e.response?.dataAsObject() ?? {},
        message: e.message ?? 'Not found',
        statusCode: 404,
        request: r,
      ),
  405: (e, r) => InvalidDataError(
        body: e.response?.dataAsObject() ?? {},
        message: e.message ?? 'Invalid data',
        statusCode: 405,
        request: r,
      ),
  500: (e, r) => ServerError(
        body: e.response?.dataAsObject() ?? {},
        message: e.message ?? 'Server error',
        statusCode: 500,
        request: r,
      ),
  502: (e, r) => ServerError(
        body: e.response?.dataAsObject() ?? {},
        message: e.message ?? 'Bad gateway',
        statusCode: 502,
        request: r,
      ),
  503: (e, r) => ServerError(
        body: e.response?.dataAsObject() ?? {},
        message: e.message ?? 'Service unavailable',
        statusCode: 503,
        request: r,
      ),
  504: (e, r) => ServerError(
        body: e.response?.dataAsObject() ?? {},
        message: e.message ?? 'Gateway timeout',
        statusCode: 504,
        request: r,
      ),
};
