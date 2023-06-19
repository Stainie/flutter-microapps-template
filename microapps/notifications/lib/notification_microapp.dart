import 'package:dependency_injection/dependency_injection.dart';
import 'package:microapp/micro_app.dart';
import 'package:notifications/datasource/services/notification_service_impl.dart';
import 'package:notifications/domain/repositories/notification_repository.dart';
import 'package:notifications/domain/usecases/change_device_language_usecase.dart';
import 'package:notifications/domain/usecases/delete_notification_usecase.dart';
import 'package:notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:notifications/domain/usecases/push_notifications_permission_denied_usecase.dart';
import 'package:notifications/domain/usecases/read_notification_usecase.dart';
import 'package:notifications/domain/usecases/unsubscribe_from_push_notifications_usecase.dart';
import 'package:notifications/domain/usecases/subscribe_to_push_notifications_usecase.dart';
import 'package:notifications/infrastructure/repositories/notification_repository_impl.dart';
import 'package:notifications/infrastructure/services/notification_service.dart';
import 'package:notifications/presentation/notification_controller.dart';
import 'package:push_notifications/firebase_notification_management.dart';

class NotificationMicroApp extends MicroApp {
  @override
  Future<void> setupComponents(DependencyInjection di) async {}

  @override
  Future<void> setupControllers(DependencyInjection di) async {
    di.registerLazySingleton<NotificationController>(
      () => NotificationController(
        di.get(),
        di.get(),
        di.get(),
        di.get(),
        di.get(),
        di.get(),
        di.get(),
        di.get(),
      ),
    );
  }

  @override
  Future<void> setupOthers(DependencyInjection di) async {
    final notificationManagement = FirebaseNotificationManagement.create(
      onMessage: () {},
      onBackgroundMessage: () {},
      onMessageOpenedApp: () {},
      onTokenRefresh: () {
        di.get<NotificationController>().subscribeToPushNotifications();
      },
    );
    final value = await notificationManagement.requestPermission();
    if (value ?? false) {
      await notificationManagement.getToken();
      await notificationManagement.setup();
    }
  }

  @override
  Future<void> setupRepositories(DependencyInjection di) async {
    di.registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl(
        notificationService: di.get(),
        crashlytics: di.get(),
        user: di.get(),
      ),
    );
  }

  @override
  Future<void> setupServices(DependencyInjection di) async {
    di.registerLazySingleton<NotificationService>(
      () => NotificationServiceImpl(
        client: di.get(),
        crashlytics: di.get(),
        fcmToken: di.get(),
      ),
    );
  }

  @override
  Future<void> setupUsecases(DependencyInjection di) async {
    di
      ..registerLazySingleton<SubscribeToPushNotificationsUsecase>(
        () => SubscribeToPushNotificationsUsecase(
          notificationRepository: di.get(),
          crash: di.get(),
        ),
      )
      ..registerLazySingleton<UnsubscribeFromPushNotificationsUsecase>(
        () => UnsubscribeFromPushNotificationsUsecase(
          notificationRepository: di.get(),
          crash: di.get(),
        ),
      )
      ..registerLazySingleton<PushNotificationsPermissionDeniedUsecase>(
        () => PushNotificationsPermissionDeniedUsecase(
          notificationRepository: di.get(),
          crash: di.get(),
        ),
      )
      ..registerLazySingleton<ReadNotificationUsecase>(
        () => ReadNotificationUsecase(
          notificationRepository: di.get(),
          crash: di.get(),
        ),
      )
      ..registerLazySingleton<GetNotificationsUseCase>(
        () => GetNotificationsUseCase(
          notificationRepository: di.get(),
          crash: di.get(),
        ),
      )
      ..registerLazySingleton<DeleteNotificationUsecase>(
        () => DeleteNotificationUsecase(
          notificationRepository: di.get(),
          crash: di.get(),
        ),
      )
      ..registerLazySingleton<ChangeDeviceLanguageUsecase>(
        () => ChangeDeviceLanguageUsecase(
          notificationRepository: di.get(),
          crash: di.get(),
        ),
      );
  }
}
