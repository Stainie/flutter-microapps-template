import 'package:design_system/core/foundations/spacing.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HeightSpacer extends StatelessWidget {
  const HeightSpacer({
    this.separator = FoundationSpacing.baseSeparated,
    super.key,
  });

  final double separator;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: separator,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(DoubleProperty('separator', separator));
  }
}
