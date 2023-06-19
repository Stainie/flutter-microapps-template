import 'package:crashlytics/crashlytics.dart';

Future<List<CrashlyticsProviders>> setupProvidersCrashlytics(
  List<CrashlyticsProviders> providers,
) async {
  for (final provider in providers) {
    await provider.setup();
  }
  return providers;
}
