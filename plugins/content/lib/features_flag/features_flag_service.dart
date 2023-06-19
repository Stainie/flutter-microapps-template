import 'package:local_storage/json.dart';
import 'package:local_storage/serializable.dart';
import 'package:result/result.dart';
import 'package:content/features_flag/features_flag_errors.dart';

abstract class FeaturesFlagService {
  Future<Result<FeaturesFlagError, T>>
      getFeatureFlag<T extends BiSerializable>({
    required String key,
    required T Function(Json json) fromJson,
  });
}
