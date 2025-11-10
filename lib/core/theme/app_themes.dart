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
        navBarBackground: Colors.white,
        navBarForeground: Color(0xFF1A1F29),
        navBarBorder: Color(0xFFE3E8EF),
        sideBarBackground: Color(0xFFF8FAFC),
        sideBarBorder: Color(0xFFE2E8F0),
        contentBackground: Color(0xFFF5F7FA),
        subtleFill: Color(0xFFF1F5F9),
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
