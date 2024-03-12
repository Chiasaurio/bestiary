import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

abstract class ColorsConfigApp {
  bool get useMaterial3 => true;

  bool get isDark => false;
  Brightness get brightness => Brightness.light;

  static const int _successTone = 0xFF1EAB4E;
  MaterialColor get success => const MaterialColor(_successTone, <int, Color>{
        50: Color(0xFFE4F5EA),
        100: Color(0xFFBCE6CA),
        200: Color(0xFF8FD5A7),
        300: Color(0xFF62C483),
        400: Color(0xFF40B869),
        500: Color(_successTone),
        600: Color(0xFF1AA447),
        700: Color(0xFF169A3D),
        800: Color(0xFF129135),
        900: Color(0xFF0A8025),
      });

  static const int _infoTone = 0xFF5D81FF;
  MaterialColor get info => const MaterialColor(_infoTone, <int, Color>{
        50: Color(0xFFECF0FF),
        100: Color(0xFFCED9FF),
        200: Color(0xFFAEC0FF),
        300: Color(0xFF8EA7FF),
        400: Color(0xFF7594FF),
        500: Color(_infoTone),
        600: Color(0xFF5579FF),
        700: Color(0xFF4B6EFF),
        800: Color(0xFF4164FF),
        900: Color(0xFF3051FF),
      });

  static const int _warnigTone = 0xFFFF8D4D;
  MaterialColor get warnig => const MaterialColor(_warnigTone, <int, Color>{
        50: Color(0xFFFFF1EA),
        100: Color(0xFFFFDDCA),
        200: Color(0xFFFFC6A6),
        300: Color(0xFFFFAF82),
        400: Color(0xFFFF9E68),
        500: Color(_warnigTone),
        600: Color(0xFFFF8546),
        700: Color(0xFFFF7A3D),
        800: Color(0xFFFF7034),
        900: Color(0xFFFF5D25),
      });

  static const int _errorTone = 0xFFFF5050;
  MaterialColor get error => const MaterialColor(_errorTone, <int, Color>{
        50: Color(0xFFFFEAEA),
        100: Color(0xFFFFCBCB),
        200: Color(0xFFFFA8A8),
        300: Color(0xFFFF8585),
        400: Color(0xFFFF6A6A),
        500: Color(_errorTone),
        600: Color(0xFFFF4949),
        700: Color(0xFFFF4040),
        800: Color(0xFFFF3737),
        900: Color(0xFFFF2727),
      });

  Color get hipal => const Color(0xFF8639D8);
  List<Color> get appBarGradient => [
        const Color(0xFFAB62FA),
        const Color(0xFF8639D8),
        const Color(0xFF6821B4),
      ];
  Color get lightHipal => const Color(0xFFEFEDFF);
  Color get text => Colors.black87;

  static const int _primaryTone = 0xFF262626;
  MaterialColor get primary => const MaterialColor(_primaryTone, <int, Color>{
        50: Color(0xFFE5E5E5),
        100: Color(0xFFBEBEBE),
        200: Color(0xFF939393),
        300: Color(0xFF676767),
        400: Color(0xFF474747),
        500: Color(_primaryTone),
        600: Color(0xFF222222),
        700: Color(0xFF1C1C1C),
        800: Color(0xFF171717),
        900: Color(0xFF0D0D0D),
      });

  static const int _secondaryTone = 0xFF43483E;
  MaterialColor get secondary =>
      const MaterialColor(_secondaryTone, <int, Color>{
        50: Color(0xFFE8E9E8),
        100: Color(0xFFC7C8C5),
        200: Color(0xFFA1A49F),
        300: Color(0xFF7B7F78),
        400: Color(0xFF5F635B),
        500: Color(_secondaryTone),
        600: Color(0xFF3D4138),
        700: Color(0xFF343830),
        800: Color(0xFF2C3028),
        900: Color(0xFF1E211B),
      });

  Color get white => const Color(0xFFFFFFFF);
  Color get flatBackground => const Color(0xFFFFFFFF);
  Color get cards => const Color(0xFFFFFFFF);
  Color get flatIllustrations => const Color(0xFFE7E4FB);

  static const int _slateTone = 0xFF4A4A68;
  MaterialColor get slate => const MaterialColor(_slateTone, <int, Color>{
        50: Color(0xFFE9E9ED),
        100: Color(0xFFC9C9D2),
        200: Color(0xFFA5A5B4),
        300: Color(0xFF808095),
        400: Color(0xFF65657F),
        500: Color(_slateTone),
        600: Color(0xFF434360),
        700: Color(0xFF3A3A55),
        800: Color(0xFF32324B),
        900: Color(0xFF22223A),
      });

  static const int _lightSlate = 0xFF8C8CA1;
  MaterialColor get lightSlate => const MaterialColor(_lightSlate, <int, Color>{
        50: Color(0xFFF1F1F4),
        100: Color(0xFFDDDDE3),
        200: Color(0xFFC6C6D0),
        300: Color(0xFFAFAFBD),
        400: Color(0xFF9D9DAF),
        500: Color(_lightSlate),
        600: Color(0xFF848499),
        700: Color(0xFF79798F),
        800: Color(0xFF6F6F85),
        900: Color(0xFF5C5C74),
      });
}

class ColorsLightApp extends ColorsConfigApp {}

class ColorsDarkApp extends ColorsConfigApp {
  @override
  bool get isDark => true;

  @override
  Color get text => Colors.white70;

  @override
  Brightness get brightness => Brightness.dark;

  static const int _primaryTone = 0xFFE9E7EF;

  @override
  MaterialColor get primary => const MaterialColor(_primaryTone, <int, Color>{
        50: Color(0xFFFCFCFD),
        100: Color(0xFFF8F8FA),
        200: Color(0xFFF4F3F7),
        300: Color(0xFFF0EEF4),
        400: Color(0xFFECEBF1),
        500: Color(_primaryTone),
        600: Color(0xFFE6E4ED),
        700: Color(0xFFE3E0EB),
        800: Color(0xFFDFDDE8),
        900: Color(0xFFD9D7E4),
      });

  static const int _secondaryTone = 0xFFB790E2;

  @override
  MaterialColor get secondary =>
      const MaterialColor(_secondaryTone, <int, Color>{
        50: Color(0xFFF6F2FC),
        100: Color(0xFFE9DEF6),
        200: Color(0xFFDBC8F1),
        300: Color(0xFFCDB1EB),
        400: Color(0xFFC2A1E6),
        500: Color(_secondaryTone),
        600: Color(0xFFB088DF),
        700: Color(0xFFA77DDA),
        800: Color(0xFF9F73D6),
        900: Color(0xFF9061CF),
      });

  @override
  Color get flatBackground => const Color(0xFF262626);

  @override
  Color get cards => const Color(0xFF551D91);

  @override
  Color get flatIllustrations => const Color(0xFF262626);

  static const int _slateTone = 0xFF8639D8;

  @override
  MaterialColor get slate => const MaterialColor(_slateTone, <int, Color>{
        50: Color(0xFFF0E7FA),
        100: Color(0xFFDBC4F3),
        200: Color(0xFFC39CEC),
        300: Color(0xFFAA74E4),
        400: Color(0xFF9857DE),
        500: Color(_slateTone),
        600: Color(0xFF7E33D4),
        700: Color(0xFF732CCE),
        800: Color(0xFF6924C8),
        900: Color(0xFF5617BF),
      });

  static const int _lightSlate = 0xFFE9E7EF;

  @override
  MaterialColor get lightSlate => const MaterialColor(_lightSlate, <int, Color>{
        50: Color(0xFFFCFCFD),
        100: Color(0xFFF8F8FA),
        200: Color(0xFFF4F3F7),
        300: Color(0xFFF0EEF4),
        400: Color(0xFFECEBF1),
        500: Color(_lightSlate),
        600: Color(0xFFE6E4ED),
        700: Color(0xFFE3E0EB),
        800: Color(0xFFDFDDE8),
        900: Color(0xFFD9D7E4),
      });
}

class _ColorsApp {
  static ColorsConfigApp getColor() {
    if (_isDarkMode()) return ColorsDarkApp();
    return ColorsLightApp();
  }

  static bool _isDarkMode() {
    final brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;

    return brightness == Brightness.dark;
  }
}

ColorsConfigApp get getColor => _ColorsApp.getColor();
