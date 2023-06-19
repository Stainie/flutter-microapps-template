library micro_app;

import 'package:dependency_injection/dependency_injection.dart';

/// A Calculator.
abstract class MicroApp {
  Future setup(DependencyInjection di) async {
    await setupServices(di);
    await setupRepositories(di);
    await setupUsecases(di);
    await setupControllers(di);
    await setupOthers(di);
    await setupComponents(di);
  }

  Future setupComponents(DependencyInjection di);
  Future setupControllers(DependencyInjection di);
  Future setupServices(DependencyInjection di);
  Future setupUsecases(DependencyInjection di);
  Future setupRepositories(DependencyInjection di);
  Future setupOthers(DependencyInjection di);
}
