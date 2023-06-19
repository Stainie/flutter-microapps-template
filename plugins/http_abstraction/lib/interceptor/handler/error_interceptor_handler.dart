import 'package:http_abstraction/http_abstraction.dart';

abstract class IErrorInterceptorHandler {
  void resolve(HttpResponse request);
  void reject(HttpError error);
  void next(HttpError request);
}
