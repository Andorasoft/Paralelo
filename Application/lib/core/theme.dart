import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';

extension AppThemeData on ThemeData {
  ThemeData get app => ThemeData(
    brightness: Brightness.light,
    applyElevationOverlayColor: false,
    useMaterial3: true,

    textTheme: const TextTheme(
      labelSmall: TextStyle(fontSize: 10.0),

      labelMedium: TextStyle(fontSize: 12.0),

      labelLarge: TextStyle(fontSize: 14.0),

      bodySmall: TextStyle(fontSize: 12.0),

      bodyMedium: TextStyle(fontSize: 14.0),

      bodyLarge: TextStyle(fontSize: 16.0),

      titleSmall: TextStyle(fontSize: 14.0),

      titleMedium: TextStyle(fontSize: 18.0),

      titleLarge: TextStyle(fontSize: 22.0),

      headlineSmall: TextStyle(fontSize: 24.0),

      headlineMedium: TextStyle(fontSize: 30.0),

      headlineLarge: TextStyle(fontSize: 36.0),

      displaySmall: TextStyle(fontSize: 42.0),

      displayMedium: TextStyle(fontSize: 50.0),

      displayLarge: TextStyle(fontSize: 58.0),
    ),

    dividerTheme: const DividerThemeData(color: Color(0xFFE8ECF1)),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        ),
        minimumSize: WidgetStateProperty.all(
          const Size(double.minPositive, 44.0),
        ),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
        ),
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        ),
        minimumSize: WidgetStateProperty.all(
          const Size(double.minPositive, 44.0),
        ),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        ),
        side: WidgetStateProperty.resolveWith<BorderSide>((states) {
          return BorderSide(
            width: 1.0,
            color: !states.contains(WidgetState.disabled)
                ? Color(0xFF3B82F6)
                : Colors.black12,
          );
        }),
        minimumSize: WidgetStateProperty.all(
          const Size(double.minPositive, 44.0),
        ),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        ),
        minimumSize: WidgetStateProperty.all(
          const Size(double.minPositive, 16.0),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        ),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),

    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(const Size(44.0, 44.0)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      alignLabelWithHint: false,

      hintStyle: const TextStyle(fontSize: 16.0, color: Colors.grey),

      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1.0, color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1.0, color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1.0, color: colorScheme.error),
        borderRadius: BorderRadius.circular(12.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1.0, color: colorScheme.error),
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),

    searchBarTheme: SearchBarThemeData(
      backgroundColor: WidgetStateProperty.all(Colors.grey.shade100),
      hintStyle: WidgetStateProperty.all(
        TextStyle(fontSize: 16.0, color: Colors.grey.shade600),
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 12.0),
      ),

      elevation: WidgetStateProperty.all(0.0),
    ),

    chipTheme: const ChipThemeData(
      backgroundColor: Color(0xFFf0f3f5),
      side: BorderSide.none,
      showCheckmark: false,

      padding: EdgeInsets.symmetric(vertical: 8.0),
    ),

    bottomAppBarTheme: const BottomAppBarThemeData(color: Color(0xFFFFFFFF)),

    snackBarTheme: const SnackBarThemeData(backgroundColor: Color(0xFF44474F)),

    appBarTheme: AppBarThemeData(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),

      actionsPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      titleSpacing: 4.0,
      centerTitle: false,
    ),

    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
    ),

    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ),

    radioTheme: const RadioThemeData(
      splashRadius: 12.0,
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),

    cardTheme: CardThemeData(
      color: Colors.transparent,
      margin: EdgeInsets.zero,
      elevation: 0.0,
    ),

    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: const Color(0xFF3B82F6),

      primary: const Color(0xFF3B82F6),
      onPrimary: const Color(0xFFFFFFFF),
      primaryContainer: const Color(0xFFD8E2FF),
      onPrimaryContainer: const Color(0xFF001A42),

      secondary: const Color(0xFFFCBE2B),
      onSecondary: const Color(0xFFFFFFFF),
      secondaryContainer: const Color(0xFFFFDEA3),
      onSecondaryContainer: const Color(0xFF261900),

      tertiary: const Color(0xFF1E40AF),
      onTertiary: const Color(0xFFFFFFFF),
      tertiaryContainer: const Color(0xFFDDE1FF),
      onTertiaryContainer: const Color(0xFF001453),

      surface: const Color(0xFFFBF8FF),

      inverseSurface: const Color(0xFFdbeafe),
    ),

    extensions: const [
      BottomNavBarThemeData(
        unselectedColorItem: Color(0xFFC6C8CC),
        selectedColorItem: Color(0xFF1E40AF),
      ),
    ],
  );
}
