import 'package:crashlytics/crashlytics.dart';

abstract class CrashlyticsProviders extends CrashlyticsService {
  Future<void> setup();
}
