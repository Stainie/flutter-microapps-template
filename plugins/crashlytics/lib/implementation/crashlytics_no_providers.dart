// ignore_for_file: avoid_print

import 'package:crashlytics/crashlytics.dart';
import 'package:flutter/material.dart';

class NoneCrashlyticsProvider extends CrashlyticsProviders {
  @override
  Future<void> logError(
    Object exception,
    StackTrace stack, {
    String? reason,
  }) async {
    printError(exception, stack, reason: reason);
  }

  @override
  Future<void> setCurrentScreen(String currentPage) async {
    print('Crashlytics - current page: $currentPage');
  }

  @override
  Future<void> setCustomKey(String key, Object value) async {}

  @override
  Future<void> setUserId(String userId) async {}

  void printError(Object exception, StackTrace? stack, {String? reason}) {
    print('----------------NONE CRASHLYTICS----------------');

    // If available, give a reason to the exception.
    if (reason != null) {
      print('The following exception was thrown $reason:');
    }

    // Need to print the exception to explain why the exception was thrown.
    print(exception);

    // Not using Trace.format here to stick to the default stack trace format
    // that Flutter developers are used to seeing.
    if (stack != null) {
      print('\n$stack');
    }
    print('----------------------------------------------------');
  }

  @override
  Future<void> setup() async {}

  @override
  Future<void> onFlutterError(FlutterErrorDetails details) async {
    printError(
      details.exception,
      details.stack,
      reason: details.context?.toString(),
    );
  }

  @override
  Future<void> logNetworkError({
    required String url,
    required Map<String, Object?> bodyRequest,
    required Map<String, Object?> bodyResponse,
    required int statusCode,
    required String method,
    required Map<String, Object?> headers,
  }) {
    print('----------------NONE NETWORK CRASHLYTICS----------------');
    print('URL: $url');
    print('Method: $method');
    print('Status code: $statusCode');
    print('Headers: $headers');
    print('Body request: $bodyRequest');
    print('Body response: $bodyResponse');
    print('----------------------------------------------------');
    return Future.value();
  }
}
