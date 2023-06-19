import 'package:local_storage/json.dart';
import 'package:local_storage/serializable.dart';

class SerializableEntity with BiSerializable<SerializableEntity> {
  SerializableEntity({required this.test});

  factory SerializableEntity.fromJson(Json json) => SerializableEntity(
        test: json.readString('test')!,
      );

  final String test;

  @override
  SerializableEntity fromJson(Json json) => SerializableEntity.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
        'test': test,
      };

  SerializableEntity copyWith(Map<String, dynamic> mutation) =>
      SerializableEntity(test: mutation['test'] ?? '');
}
