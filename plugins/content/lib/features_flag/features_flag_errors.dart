abstract class FeaturesFlagError implements Exception {
  String get message;
}

class UnableToFetchFlag implements FeaturesFlagError {
  @override
  String get message => 'Unable to fetch flag';
}
