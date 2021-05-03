import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  final BuildContext context;

  AppTheme(this.context);

  ThemeData get defaultTheme => ThemeData(
      fontFamily: 'Open-sans',
      primaryColor: AppColors.primary,
      appBarTheme: AppBarTheme(brightness: Brightness.dark),
      scaffoldBackgroundColor: AppColors.greenBlueGrayola,
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
          suffixStyle: TextStyle(color: AppColors.primary)));
}
