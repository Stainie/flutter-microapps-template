import 'package:http_abstraction/http_abstraction.dart';

abstract class IRequestInterceptorHandler {
  void resolve(HttpResponse request);
  void reject(HttpError error);
  void next(HttpRequest request);
}
