import 'dart:io';

abstract class HttpBody {
  HttpBody(this.data);

  final Map<String, Object?> data;
}

class HttpBodyJson extends HttpBody {
  HttpBodyJson(super.data);
}

class HttpBodyForm extends HttpBody {
  HttpBodyForm(
    super.data, {
    this.files,
  });
  final Map<String, File>? files;
}
