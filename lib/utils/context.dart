import 'package:flutter/material.dart';

import 'breakpoints.dart';

/// Extension on [BuildContext] to provide information about the layout.
extension BuildContextLayoutX on BuildContext {
  /// Whether the device is small.
  bool get isSmall {
    final mediaQuery = MediaQuery.of(this);
    return mediaQuery.size.width < AppBreakpoints.small.size &&
        mediaQuery.orientation == Orientation.portrait;
  }
}
