import 'dart:convert';

import 'package:local_storage/serializable.dart';

class Json with BiSerializable<Json> {
  // note: need _readField for passed keys
  Json(this._json);
  factory Json.empty() => Json({});
  factory Json.decode(String json) => Json(jsonDecode(json));

  Map<String, dynamic> _json;
  List<String> get keys => _json.keys.toList();

  @override
  Json fromJson(Json json) => this;

  @override
  Map<String, dynamic> toJson() => _json;

  dynamic _readField(String key) {
    final splitKey = key.split('.').map((k) => k.trim()).toList();
    dynamic value = _json;

    for (final k in splitKey) {
      if (value is Map) {
        value = value[k];
      } else {
        return null;
      }
    }

    return value;
  }

  bool get isEmpty => _json.isEmpty;
  bool get isNotEmpty => _json.isNotEmpty;
  Map<String, dynamic> get raw => _json;

  /// Reads a json object from the json object specified by its key.
  /// If the key is not found, an empty json object is returned.
  /// If the key is found but it is not a json object, an empty json object is returned.
  /// This method returns a non-nullable type.
  Json readJson(String key) {
    final value = _readField(key);

    if (value is! Map<String, dynamic>) {
      return Json.empty();
    }

    return Json(value);
  }

  /// Reads a custom object from the json object specified by its key.
  /// If the key is not found, null is returned.
  /// If the value is not a JSON object, null is returned.
  /// The value is mapped onto the custom object by the `fromJson` callback function.
  T? readCustomObject<T>(String key, T Function(Json) fromJson) {
    if (!hasField(key)) {
      return null;
    }
    final value = readJson(key);
    return fromJson(value);
  }

  /// Reads a list of json objects from the json object specified by its key.
  /// If the key is not found, null is returned.
  /// If the key is found but it is not a list of json objects, null is returned.
  List<Json>? readJsonList(String key) {
    final value = _readField(key);

    if (value is! List<dynamic>) {
      return null;
    }

    for (final v in value) {
      if (v is! Map<String, dynamic>) {
        return null;
      }
    }

    return value.map((v) => Json(v as Map<String, dynamic>)).toList();
  }

  bool hasField(String key) => _readField(key) != null;

  List<T>? _readList<T>(dynamic value, Function(dynamic) mapper) {
    if (value is! List) {
      return null;
    }

    final list = <T>[];

    for (final item in value) {
      final val = mapper(item) as T?;

      if (val == null) {
        return null;
      }

      list.add(val);
    }

    return list;
  }

  String? readString(dynamic key) {
    return mapToString(_readField(key));
  }

  String? mapToString(dynamic value) {
    return (value == null) ? null : value?.toString();
  }

  List<String>? readStringList(dynamic key) =>
      _readList(_readField(key), mapToString);

  int? readInt(dynamic key) {
    return mapToInt(_readField(key));
  }

  int? mapToInt(dynamic value) {
    if (value == null) {
      return null;
    }

    return value is int ? value : int.tryParse(value.toString());
  }

  List<int>? readIntList(dynamic key) => _readList(_readField(key), mapToInt);

  double? readDouble(dynamic key) {
    return mapToDouble(_readField(key));
  }

  double? mapToDouble(dynamic value) {
    if (value == null) {
      return null;
    }

    return value is double ? value : double.tryParse(value.toString());
  }

  List<double>? readDoubleList(dynamic key) =>
      _readList(_readField(key), mapToDouble);

  num? readNum(dynamic key) {
    return mapToNum(_readField(key));
  }

  num? mapToNum(dynamic value) {
    if (value == null) {
      return null;
    }

    return value is num ? value : num.tryParse(value.toString());
  }

  List<num>? readNumList(dynamic key) => _readList(_readField(key), mapToNum);

  bool? readBool(dynamic key) {
    return mapToBool(_readField(key));
  }

  bool? mapToBool(dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is bool) {
      return value;
    }

    final stringValue = value.toString();

    if (stringValue == 'true' || stringValue == '1') {
      return true;
    }

    if (stringValue == 'false' || stringValue == '0') {
      return false;
    }

    return null;
  }

  List<bool>? readBoolList(dynamic key) =>
      _readList(_readField(key), mapToBool);

  DateTime? readDateTime(String key) {
    final dynamic value = _readField(key);

    if (value == null) {
      return null;
    }

    return DateTime.tryParse(value.toString());
  }
}
