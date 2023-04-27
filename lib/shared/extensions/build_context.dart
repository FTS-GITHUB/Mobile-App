import 'package:flutter/material.dart';

import 'media_query.dart';

extension CheckPlatform on BuildContext {
  bool isDesktop() {
    return width == 950;
  }

  bool isMobile() {
    return width < 400;
  }

  bool isTablet() {
    return width > 400 && width < 950;
  }
}
