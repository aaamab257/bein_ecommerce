import 'package:flutter/material.dart';

import '../../core/utils/colors/colors_manager.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: ColorsManager.background,
  primaryColor: ColorsManager.background,
  colorScheme: const ColorScheme.light(),
  iconTheme: const IconThemeData(
      color: ColorsManager.settingsIconsColor, opacity: 0.8),
);
