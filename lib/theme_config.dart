import 'package:flutter/material.dart';

import 'config/application/locator_component/locator_instance.dart';
import 'config/theme/colors_config.dart';

class ThemeApp {
  static _instanceTheme(String name) =>
      locator<ThemeAppConfig>(instanceName: name).temeApp();

  static ThemeData get light => _instanceTheme('light');
  static ThemeData get dark => _instanceTheme('dark');
}

class ThemeAppConfig {
  final ColorsConfigApp colors;
  final Brightness brightness;

  ThemeAppConfig(this.colors, [this.brightness = Brightness.light]);

  ThemeData temeApp() => ThemeData(
        useMaterial3: true,
        colorScheme: _colorScheme(),
        elevatedButtonTheme: _elevatedButtonTheme(),
        outlinedButtonTheme: _outlinedButtonTheme(),
        inputDecorationTheme: _inputDecorationTheme(),
      );

  ColorScheme _colorScheme() => ColorScheme.fromSeed(
        brightness: brightness,
        seedColor: colors.primary,
        primary: colors.primary,
        secondary: colors.secondary,
        error: colors.error,
      );

  ElevatedButtonThemeData _elevatedButtonTheme() => ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          backgroundColor: MaterialStatePropertyAll<Color>(colors.hipal),
          foregroundColor:
              MaterialStatePropertyAll<Color>(colors.flatBackground),
          overlayColor: MaterialStatePropertyAll<Color>(colors.primary[50]!),
        ),
      );

  OutlinedButtonThemeData _outlinedButtonTheme() => OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(10.0), // Set the border radius
            ),
            foregroundColor: colors.primary,
            side: BorderSide(color: colors.primary)),
      );

  InputDecorationTheme _inputDecorationTheme() => InputDecorationTheme(
        filled: true,
        fillColor: getColor.white,
        labelStyle: const TextStyle(fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colors.hipal),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colors.slate[100]!),
          borderRadius: BorderRadius.circular(10.0),
        ),
      );
}
