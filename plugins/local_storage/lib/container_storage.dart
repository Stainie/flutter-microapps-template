import 'package:local_storage/json.dart';
import 'package:local_storage/serializable.dart';

class ContainerStorage<T extends BiSerializable> {
  ContainerStorage({
    required this.data,
    this.expiration,
  });

  factory ContainerStorage.fromJson({
    required Json json,
    required T Function(Json json) fromJson,
  }) {
    final expiration = json.readInt('expiration');
    return ContainerStorage<T>(
      data: json.readCustomObject('data', fromJson)!,
      expiration: expiration != null
          ? Duration(
              milliseconds: expiration,
            )
          : null,
    );
  }

  final T data;
  final Duration? expiration;

  Map<String, dynamic> toJson() => {
        'data': data.toJson(),
        'expiration': expiration?.inMilliseconds,
      };

  bool isExpired() =>
      expiration != null &&
      expiration!.inMilliseconds < DateTime.now().millisecondsSinceEpoch;
}
