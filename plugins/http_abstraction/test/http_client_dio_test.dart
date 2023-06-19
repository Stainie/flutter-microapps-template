import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_abstraction/dio/http_client_dio.dart';
import 'package:http_abstraction/http_abstraction.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'http_client_dio_test.mocks.dart';

@GenerateMocks([
  Dio,
  RequestOptions,
  Response,
  BaseOptions,
])
void main() {
  late MockDio dio;
  late MockRequestOptions requestOptions;
  late MockResponse response;
  late HttpClientDio httpClientDio;

  setUp(() {
    dio = MockDio();
    requestOptions = MockRequestOptions();
    response = MockResponse();
    when(dio.options).thenReturn(BaseOptions(baseUrl: 'url'));
    when(requestOptions.baseUrl).thenReturn('url');

    httpClientDio = HttpClientDio(client: dio, onError: (error, stack) {});
  });

  group('GET', () {
    group('On Error', () {
      test('should return a Server Error', () async {
        when(response.statusCode).thenReturn(500);
        when(response.data).thenReturn({'test': 'value'});
        when(response.headers).thenReturn(Headers());
        when(response.requestOptions).thenReturn(requestOptions);

        when(requestOptions.path).thenReturn('endpoint');
        when(requestOptions.queryParameters).thenReturn({});
        when(requestOptions.headers).thenReturn({});
        when(requestOptions.method).thenReturn('GET');
        when(requestOptions.data).thenReturn({'test': 'value'});
        when(requestOptions.baseUrl).thenReturn('url');

        when(
          dio.fetch(
            any,
          ),
        ).thenThrow(
          DioError(requestOptions: requestOptions, response: response),
        );

        final result = await httpClientDio.get(endpoint: 'url');

        expect(result.isErr, true);
        expect(result.err, isA<ServerError>());
      });
    });

    group('On Success', () {
      test('should return a Success', () async {
        when(response.statusCode).thenReturn(200);
        when(response.data).thenReturn({'test': 'value'});
        when(response.headers).thenReturn(Headers());
        when(response.requestOptions).thenReturn(requestOptions);

        when(requestOptions.path).thenReturn('endpoint');
        when(requestOptions.queryParameters).thenReturn({});
        when(requestOptions.headers).thenReturn({});
        when(requestOptions.method).thenReturn('GET');
        when(requestOptions.data).thenReturn({'test': 'value'});

        when(
          dio.fetch(
            any,
          ),
        ).thenAnswer((_) async => response);

        final result = await httpClientDio.get(endpoint: 'url');

        expect(result.isOk, true);
        expect(result.ok, isA<HttpResponse>());
      });
    });
  });

  group('POST', () {
    group('On Error', () {
      test('should return a Server Error', () async {
        when(response.statusCode).thenReturn(500);
        when(response.data).thenReturn({'test': 'value'});
        when(response.headers).thenReturn(Headers());
        when(response.requestOptions).thenReturn(requestOptions);

        when(requestOptions.path).thenReturn('endpoint');
        when(requestOptions.queryParameters).thenReturn({});
        when(requestOptions.headers).thenReturn({});
        when(requestOptions.method).thenReturn('POST');
        when(requestOptions.data).thenReturn({'test': 'value'});

        when(
          dio.fetch(
            any,
          ),
        ).thenThrow(
          DioError(requestOptions: requestOptions, response: response),
        );

        final result = await httpClientDio.post(endpoint: 'url');

        expect(result.isErr, true);
        expect(result.err, isA<ServerError>());
      });
    });

    group('On Success', () {
      test('should return a Success', () async {
        when(response.statusCode).thenReturn(200);
        when(response.data).thenReturn({'test': 'value'});
        when(response.headers).thenReturn(Headers());
        when(response.requestOptions).thenReturn(requestOptions);

        when(requestOptions.path).thenReturn('endpoint');
        when(requestOptions.queryParameters).thenReturn({});
        when(requestOptions.headers).thenReturn({});
        when(requestOptions.method).thenReturn('POST');
        when(requestOptions.data).thenReturn({'test': 'value'});

        when(
          dio.fetch(
            any,
          ),
        ).thenAnswer((_) async => response);

        final result = await httpClientDio.post(endpoint: 'url');

        expect(result.isOk, true);
        expect(result.ok, isA<HttpResponse>());
      });
    });
  });

  group('PUT', () {
    group('On Error', () {
      test('should return a Server Error', () async {
        when(response.statusCode).thenReturn(500);
        when(response.data).thenReturn({'test': 'value'});
        when(response.headers).thenReturn(Headers());
        when(response.requestOptions).thenReturn(requestOptions);

        when(requestOptions.path).thenReturn('endpoint');
        when(requestOptions.queryParameters).thenReturn({});
        when(requestOptions.headers).thenReturn({});
        when(requestOptions.method).thenReturn('PUT');
        when(requestOptions.data).thenReturn({'test': 'value'});

        when(
          dio.fetch(
            any,
          ),
        ).thenThrow(
          DioError(requestOptions: requestOptions, response: response),
        );

        final result = await httpClientDio.put(endpoint: 'url');

        expect(result.isErr, true);
        expect(result.err, isA<ServerError>());
      });
    });

    group('On Success', () {
      test('should return a Success', () async {
        when(response.statusCode).thenReturn(200);
        when(response.data).thenReturn({'test': 'value'});
        when(response.headers).thenReturn(Headers());
        when(response.requestOptions).thenReturn(requestOptions);

        when(requestOptions.path).thenReturn('endpoint');
        when(requestOptions.queryParameters).thenReturn({});
        when(requestOptions.headers).thenReturn({});
        when(requestOptions.method).thenReturn('PUT');
        when(requestOptions.data).thenReturn({'test': 'value'});

        when(
          dio.fetch(
            any,
          ),
        ).thenAnswer((_) async => response);

        final result = await httpClientDio.put(endpoint: 'url');

        expect(result.isOk, true);
        expect(result.ok, isA<HttpResponse>());
      });
    });
  });

  group('DELETE', () {
    group('On Error', () {
      test('should return a Server Error', () async {
        when(response.statusCode).thenReturn(500);
        when(response.data).thenReturn({'test': 'value'});
        when(response.headers).thenReturn(Headers());
        when(response.requestOptions).thenReturn(requestOptions);

        when(requestOptions.path).thenReturn('endpoint');
        when(requestOptions.queryParameters).thenReturn({});
        when(requestOptions.headers).thenReturn({});
        when(requestOptions.method).thenReturn('DELETE');
        when(requestOptions.data).thenReturn({'test': 'value'});

        when(
          dio.fetch(
            any,
          ),
        ).thenThrow(
          DioError(requestOptions: requestOptions, response: response),
        );

        final result = await httpClientDio.delete(endpoint: 'url');

        expect(result.isErr, true);
        expect(result.err, isA<ServerError>());
      });
    });

    group('On Success', () {
      test('should return a Success', () async {
        when(response.statusCode).thenReturn(200);
        when(response.data).thenReturn({'test': 'value'});
        when(response.headers).thenReturn(Headers());
        when(response.requestOptions).thenReturn(requestOptions);

        when(requestOptions.path).thenReturn('endpoint');
        when(requestOptions.queryParameters).thenReturn({});
        when(requestOptions.headers).thenReturn({});
        when(requestOptions.method).thenReturn('DELETE');
        when(requestOptions.data).thenReturn({'test': 'value'});

        when(
          dio.fetch(
            any,
          ),
        ).thenAnswer((_) async => response);

        final result = await httpClientDio.delete(endpoint: 'url');

        expect(result.isOk, true);
        expect(result.ok, isA<HttpResponse>());
      });
    });
  });
}
