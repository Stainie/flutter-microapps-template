library dependency_injection;

abstract class DependencyInjection {
  T get<T extends Object>({
    String? instanceName,
    dynamic param1,
    dynamic param2,
  });

  void registerLazySingleton<T extends Object>(
    T Function() register, {
    Future Function(T param)? disposingFunction,
  });

  void registerLazySingletonAsync<T extends Object>(
    Future<T> Function() register, {
    Future Function(T param)? disposingFunction,
  });

  void resetLazySingleton<T extends Object>({
    T? instance,
    Function(T param)? disposingFunction,
    String? instanceName,
  });

  void registerFactoryParam<T extends Object, P1, P2>(
    T Function(P1, P2) factoryFunc, {
    String? instanceName,
  });

  void registerFactoryParamAsync<T extends Object, P1, P2>(
    Future<T> Function(P1?, P2?) factoryFunc, {
    String? instanceName,
  });

  void registerFactory<T extends Object>(
    T Function() factoryFunc, {
    String? instanceName,
  });

  bool isRegistered<T extends Object>({Object? instance, String? instanceName});
}

late DependencyInjection di;
