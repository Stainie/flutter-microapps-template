import 'package:crashlytics/crashlytics.dart';
import 'package:flutter/material.dart';

class CrashlyticsMultipleProvidersServiceImpl extends CrashlyticsProviders {
  CrashlyticsMultipleProvidersServiceImpl({required this.providers});

  final List<CrashlyticsProviders> providers;

  @override
  Future<void> logError(
    Object exception,
    StackTrace stack, {
    String? reason,
  }) async {
    await Future.forEach<CrashlyticsProviders>(
      providers,
      (p) async => p.logError(
        exception,
        stack,
        reason: reason,
      ),
    );
  }

  @override
  Future<void> setCurrentScreen(String currentPage) async =>
      Future.forEach<CrashlyticsProviders>(
        providers,
        (p) async => p.setCurrentScreen(currentPage),
      );

  @override
  Future<void> setCustomKey(String key, Object value) async =>
      Future.forEach<CrashlyticsProviders>(
        providers,
        (p) async => p.setCustomKey(key, value),
      );

  @override
  Future<void> setUserId(String userId) async =>
      Future.forEach<CrashlyticsProviders>(
        providers,
        (p) async => p.setUserId(userId),
      );

  @override
  Future<void> setup() async => Future.forEach<CrashlyticsProviders>(
        providers,
        (p) async => p.setup(),
      );

  @override
  Future<void> onFlutterError(FlutterErrorDetails details) =>
      Future.forEach<CrashlyticsProviders>(
        providers,
        (p) async => p.onFlutterError(details),
      );

  @override
  Future<void> logNetworkError({
    required String url,
    required Map<String, Object?> bodyRequest,
    required Map<String, Object?> bodyResponse,
    required int statusCode,
    required String method,
    required Map<String, Object?> headers,
  }) async =>
      Future.forEach<CrashlyticsProviders>(
        providers,
        (p) async => p.logNetworkError(
          url: url,
          bodyRequest: bodyRequest,
          bodyResponse: bodyResponse,
          statusCode: statusCode,
          method: method,
          headers: headers,
        ),
      );
}
