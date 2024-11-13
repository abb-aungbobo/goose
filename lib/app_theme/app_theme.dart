import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    appBarTheme: _appBarTheme,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigoAccent,
      primary: Colors.indigo,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    appBarTheme: _appBarTheme,
    colorScheme: ColorScheme.dark(
      primary: Colors.indigo,
    ),
  );

  static const _appBarTheme = AppBarTheme(
    centerTitle: true,
  );
}
