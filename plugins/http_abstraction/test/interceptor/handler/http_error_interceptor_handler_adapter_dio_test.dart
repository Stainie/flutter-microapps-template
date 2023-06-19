import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_abstraction/dio/interceptor/handler/http_error_interceptor_handler_adapter_dio.dart';
import 'package:http_abstraction/http_abstraction.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'http_error_interceptor_handler_adapter_dio_test.mocks.dart';

@GenerateMocks([
  ErrorInterceptorHandler,
])
void main() {
  late MockErrorInterceptorHandler handler;
  late ErrorInterceptorHandlerAdapterDio adapter;

  setUp(() {
    handler = MockErrorInterceptorHandler();
    adapter = ErrorInterceptorHandlerAdapterDio(handler);
  });

  test('next', () {
    // arrange
    final error = UnknownError.empty();

    // act
    adapter.next(error);

    // assert
    verify(handler.next(any)).called(1);
  });

  test('reject', () {
    // arrange
    final error = UnknownError.empty();

    // act
    adapter.reject(error);

    // assert
    verify(handler.reject(any)).called(1);
  });

  test('resolve', () {
    // arrange
    final response = HttpResponse.empty();

    // act
    adapter.resolve(response);

    // assert
    verify(handler.resolve(any)).called(1);
  });
}
