import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_abstraction/dio/interceptor/handler/http_response_interceptor_handler_adapter_dio.dart';
import 'package:http_abstraction/http_abstraction.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'http_response_interceptor_handler_adapter_dio_test.mocks.dart';

@GenerateMocks([
  ResponseInterceptorHandler,
])
void main() {
  late MockResponseInterceptorHandler handler;
  late ResponseInterceptorHandlerAdapterDio adapter;

  setUp(() {
    handler = MockResponseInterceptorHandler();
    adapter = ResponseInterceptorHandlerAdapterDio(handler);
  });

  test('next', () {
    // arrange
    final response = HttpResponse.empty();

    // act
    adapter.next(response);

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
