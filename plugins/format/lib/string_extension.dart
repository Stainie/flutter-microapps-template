extension StringExtension on String {
  String truncateMiddle({
    int leadingLength = 5,
    int trailingLength = 5,
  }) =>
      length <= leadingLength + trailingLength + 3
          ? this
          : '${substring(0, leadingLength)}...${substring(length - trailingLength)}';
}
