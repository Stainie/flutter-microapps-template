import 'package:get_it/get_it.dart';
import 'package:dependency_injection/dependency_injection.dart';

class DependencyInjectionImpl extends DependencyInjection {
  @override
  T get<T extends Object>({
    String? instanceName,
    dynamic param1,
    dynamic param2,
  }) =>
      GetIt.I.get<T>(
        instanceName: instanceName,
        param1: param1,
        param2: param2,
      );

  @override
  void registerLazySingleton<T extends Object>(
    T Function() register, {
    Future Function(T param)? disposingFunction,
  }) =>
      GetIt.I.registerLazySingleton(
        register,
        dispose: disposingFunction,
      );

  @override
  void registerLazySingletonAsync<T extends Object>(
    Future<T> Function() register, {
    Future Function(T param)? disposingFunction,
  }) =>
      GetIt.I.registerLazySingletonAsync(
        register,
        dispose: disposingFunction,
      );

  @override
  void registerFactoryParam<T extends Object, P1, P2>(
    T Function(P1, P2) factoryFunc, {
    String? instanceName,
  }) =>
      GetIt.I.registerFactoryParam<T, P1, P2>(
        factoryFunc,
        instanceName: instanceName,
      );

  @override
  void registerFactoryParamAsync<T extends Object, P1, P2>(
    Future<T> Function(P1?, P2?) factoryFunc, {
    String? instanceName,
  }) =>
      GetIt.I.registerFactoryParamAsync<T, P1, P2>(
        factoryFunc,
        instanceName: instanceName,
      );

  @override
  void registerFactory<T extends Object>(
    T Function() factoryFunc, {
    String? instanceName,
  }) =>
      GetIt.I.registerFactory<T>(
        factoryFunc,
        instanceName: instanceName,
      );

  @override
  void resetLazySingleton<T extends Object>({
    T? instance,
    void Function(T p1)? disposingFunction,
    String? instanceName,
  }) =>
      GetIt.I.resetLazySingleton<T>(
        instance: instance,
        disposingFunction: disposingFunction,
      );

  @override
  bool isRegistered<T extends Object>({
    Object? instance,
    String? instanceName,
  }) =>
      GetIt.I.isRegistered<T>(
        instance: instance,
        instanceName: instanceName,
      );
}
