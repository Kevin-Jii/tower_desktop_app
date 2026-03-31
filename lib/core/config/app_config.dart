import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
const String _env = String.fromEnvironment('ENV', defaultValue: 'dev');
const Map<String, Map<String, dynamic>> _envDefaults = {
  'dev': {
    'apiBaseUrl': 'http:
    'apiTimeout': 15000,
    'debugMode': true,
    'envName': '开发环境',
  },
  'prod': {
    'apiBaseUrl': 'http:
    'apiTimeout': 15000,
    'debugMode': false,
    'envName': '生产环境',
  },
};
class AppConfig {
  static AppConfig? _instance;
  static AppConfig get instance {
    assert(_instance != null, 'AppConfig.load() 必须在 main() 中优先调用');
    return _instance!;
  }
  late final String apiBaseUrl;
  final int apiTimeout;
  final bool debugMode;
  static String get currentEnv => _env;
  static String get currentEnvName =>
      (_envDefaults[_env]?['envName'] as String?) ?? _env;
  AppConfig._({
    required this.apiBaseUrl,
    required this.apiTimeout,
    required this.debugMode,
  });
  static Future<AppConfig> load() async {
    if (_instance != null) return _instance!;
    final defaults = _envDefaults[_env] ?? _envDefaults['dev']!;
    String apiBaseUrl = defaults['apiBaseUrl'] as String;
    int apiTimeout = defaults['apiTimeout'] as int;
    bool debugMode = defaults['debugMode'] as bool;
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
      debugPrint('配置加载失败，使用环境默认值 [$_env]: $e');
    }
    _instance = AppConfig._(
      apiBaseUrl: apiBaseUrl,
      apiTimeout: apiTimeout,
      debugMode: debugMode,
    );
    debugPrint('✅ 当前环境: $currentEnvName  API: $apiBaseUrl');
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
