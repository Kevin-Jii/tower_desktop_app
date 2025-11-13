import 'package:flutter/material.dart';
import 'tower_colors.dart';

/// 定义多套可选主题。可继续扩展。
class AppThemes {
  static final ThemeData defaultLight = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue, brightness: Brightness.light),
    scaffoldBackgroundColor: const Color(0xFFF5F7FA),
    cardTheme: CardThemeData(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    ),
    extensions: const [
      TowerColors(
        navBarBackground: Color.fromARGB(255, 255, 255, 255),
        navBarForeground: Color(0xFF1A1F29),
        navBarBorder: Color(0xFFB0B0B0),
        sideBarBackground: Color.fromARGB(255, 255, 255, 255),
        sideBarBorder: Color(0xFFA0A0A0),
        contentBackground: Color(0xFFF0F0F0),
        subtleFill: Color(0xFFE8E8E8),
        accentGradientStart: Color(0xFF3B82F6),
        accentGradientEnd: Color(0xFF6366F1),
      ),
    ],
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.indigo, brightness: Brightness.dark),
    scaffoldBackgroundColor: const Color(0xFF12161C),
    cardColor: const Color(0xFF1E252E),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    ),
    extensions: const [
      TowerColors(
        navBarBackground: Color(0xFF1E252E),
        navBarForeground: Color(0xFFE6EDF5),
        navBarBorder: Color(0xFF2C3742),
        sideBarBackground: Color(0xFF192027),
        sideBarBorder: Color(0xFF27313C),
        contentBackground: Color(0xFF12161C),
        subtleFill: Color(0xFF222B33),
        accentGradientStart: Color(0xFF6366F1),
        accentGradientEnd: Color(0xFF8B5CF6),
      ),
    ],
  );

  static List<ThemeData> all() => [defaultLight, dark];
  static const List<String> names = [
    '默认',
    '暗黑',
  ];
}
