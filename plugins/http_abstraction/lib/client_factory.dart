import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_abstraction/dio/http_client_dio.dart';
import 'package:http_abstraction/http_client.dart';

// ignore: avoid_classes_with_only_static_members
class DioClients {
  static final dioClients = <Dio>[];
}

IHttpClient createClient({
  required String baseUrl,
  required void Function(Object error, StackTrace stack) onError,
  Map<String, dynamic>? headers,
}) {
  final client = Dio(
    BaseOptions(baseUrl: baseUrl, headers: headers),
  );
  DioClients.dioClients.add(client);
  return HttpClientDio(client: client, onError: onError);
}

Future<void> debugProxySetup() async {
  // ignore: do_not_use_environment
  const debugProxyEnabled = String.fromEnvironment('PROXY_ENABLED');

  if (!kDebugMode || debugProxyEnabled != 'true') {
    return;
  }

  debugPrint('##### DEBUG Proxy enabled #####');
  HttpOverrides.global = DebugProxy();
}

class DebugProxy extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) =>
      super.createHttpClient(context)
        ..findProxy = ((uri) => 'PROXY localhost:9090;')
        ..badCertificateCallback = (cert, host, port) => true;
}
