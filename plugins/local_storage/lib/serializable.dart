import 'package:local_storage/json.dart';

mixin Serializable<T> {
  Map<String, dynamic> toJson();
}

mixin Deserializable<T> {
  T fromJson(Json json);
}

mixin BiSerializable<T> implements Serializable<T>, Deserializable<T> {}
