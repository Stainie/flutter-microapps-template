import 'package:http_abstraction/http_abstraction.dart';

abstract class IResponseInterceptorHandler {
  void resolve(HttpResponse request);
  void reject(HttpError error);
  void next(HttpResponse request);
}
