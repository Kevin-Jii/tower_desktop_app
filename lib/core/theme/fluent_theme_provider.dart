import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';

class FluentThemeProvider with ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;
  
  ThemeMode get mode => _mode;
  
  FluentThemeData get lightTheme => FluentThemeData(
    brightness: Brightness.light,
    accentColor: Colors.blue,
    scaffoldBackgroundColor: const Color(0xFFF3F3F3),
    cardColor: Colors.white,
    navigationPaneTheme: NavigationPaneThemeData(
      backgroundColor: Colors.white,
      highlightColor: Colors.blue.withOpacity(0.1),
    ),
  );
  
  FluentThemeData get darkTheme => FluentThemeData(
    brightness: Brightness.dark,
    accentColor: Colors.blue,
    scaffoldBackgroundColor: const Color(0xFF202020),
    cardColor: const Color(0xFF2D2D2D),
    navigationPaneTheme: NavigationPaneThemeData(
      backgroundColor: const Color(0xFF2D2D2D),
      highlightColor: Colors.blue.withOpacity(0.2),
    ),
  );
  
  void setThemeMode(ThemeMode mode) {
    _mode = mode;
    notifyListeners();
  }
  
  void toggleTheme() {
    _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
