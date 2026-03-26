import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
class AppConfig {
  static AppConfig? _instance;
  static AppConfig get instance => _instance ??= AppConfig._();
  late final String apiBaseUrl;
  final int apiTimeout;
  final bool debugMode;
  AppConfig._({
    this.apiBaseUrl = 'http:
    this.apiTimeout = 15000,
    this.debugMode = false,
  });
  static Future<AppConfig> load() async {
    if (_instance != null) return _instance!;
    String apiBaseUrl = 'http:
    int apiTimeout = 15000;
    bool debugMode = false;
    try {
      final configFile = await _getConfigFile();
      if (await configFile.exists()) {
        final content = await configFile.readAsString();
        final json = jsonDecode(content) as Map<String, dynamic>;
        apiBaseUrl = json['apiBaseUrl'] as String? ?? apiBaseUrl;
        apiTimeout = json['apiTimeout'] as int? ?? apiTimeout;
        debugMode = json['debugMode'] as bool? ?? debugMode;
      }
    } catch (e) {
      debugPrint('配置加载失败，使用默认值: $e');
    }
    _instance = AppConfig._(
      apiBaseUrl: apiBaseUrl,
      apiTimeout: apiTimeout,
      debugMode: debugMode,
    );
    return _instance!;
  }
  static Future<File> _getConfigFile() async {
    final appDir = await getApplicationSupportDirectory();
    return File('${appDir.path}/config/app_config.json');
  }
  static Future<String> getConfigFilePath() async {
    final configFile = await _getConfigFile();
    return configFile.path;
  }
}