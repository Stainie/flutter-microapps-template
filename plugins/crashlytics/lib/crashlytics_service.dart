import 'package:flutter/material.dart';

abstract class CrashlyticsService {
  Future<void> logError(
    Object exception,
    StackTrace stack, {
    String? reason,
  });

  Future<void> logNetworkError({
    required String url,
    required Map<String, Object?> bodyRequest,
    required Map<String, Object?> bodyResponse,
    required int statusCode,
    required String method,
    required Map<String, Object?> headers,
  });

  Future<void> setUserId(String userId);

  Future<void> setCustomKey(String key, Object value);

  Future<void> setCurrentScreen(String currentPage);

  Future<void> onFlutterError(FlutterErrorDetails details);
}
