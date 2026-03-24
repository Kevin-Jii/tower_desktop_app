import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/secure_storage.dart';
class CredentialStorage {
  static const _kAccount = 'login.account';
  static const _kPassword = 'login.password';
  static const _kRemember = 'login.remember';
  static const _kAccountsHistory = 'login.accounts.history';
  static const _kAccountPwds = 'login.account.password.map';
  static const _kLastAccount = 'login.last.account';
  static const _kSecureModeKey = 'login.secure_mode';
  static const int _maxAccounts = 5;
  static final CredentialStorage _instance = CredentialStorage._internal();
  factory CredentialStorage() => _instance;
  CredentialStorage._internal();
  SecureStorage? _secureStorage;
  bool _secureMode = false;
  Future<void> _initSecureStorage() async {
    if (_secureStorage != null) return;
    _secureStorage = await getSecureStorage();
    _secureMode = _secureStorage is! FallbackInsecureStorage;
  }
  bool get isSecureMode => _secureMode;
  Future<void> save({required String account, required String password}) async {
    await _initSecureStorage();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kAccount, account);
    await prefs.setBool(_kRemember, true);
    await _addAccountToHistory(account);
    if (_secureMode) {
      await _secureStorage!.write('pwd_$account', password);
      await prefs.setBool(_kSecureModeKey, true);
    } else {
      if (kDebugMode) {
        debugPrint('警告：使用不安全的密码存储模式，请确保在 Windows 上运行');
      }
      final encoded = base64Encode(utf8.encode(password));
      await prefs.setString(_kPassword, encoded);
      await _savePasswordForAccount(account, encoded);
    }
  }
  Future<(String? account, String? password, bool remember)> read() async {
    await _initSecureStorage();
    final prefs = await SharedPreferences.getInstance();
    final last = prefs.getString(_kLastAccount) ?? prefs.getString(_kAccount);
    final remember = prefs.getBool(_kRemember) ?? false;
    String? pwd;
    if (last != null && remember) {
      if (_secureMode && prefs.getBool(_kSecureModeKey) == true) {
        pwd = await _secureStorage!.read('pwd_$last');
      }
      pwd ??= await _getPasswordFromPrefs(last);
    }
    return (last, pwd, remember);
  }
  Future<String?> _getPasswordFromPrefs(String account) async {
    final prefs = await SharedPreferences.getInstance();
    if (_secureMode && prefs.getBool(_kSecureModeKey) == true) {
      return null;
    }
    final mapJson = prefs.getString(_kAccountPwds);
    if (mapJson != null) {
      try {
        final map = Map<String, dynamic>.from(jsonDecode(mapJson));
        final encoded = map[account];
        if (encoded is String) {
          return utf8.decode(base64Decode(encoded));
        }
      } catch (e) {
        debugPrint('读取密码失败: $e');
      }
    }
    final legacy = prefs.getString(_kPassword);
    if (legacy != null) {
      try {
        return utf8.decode(base64Decode(legacy));
      } catch (e) {
        debugPrint('读取旧版本密码失败: $e');
      }
    }
    return null;
  }
  Future<List<String>> getAccountsHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_kAccountsHistory) ?? const [];
  }
  Future<String?> getPasswordFor(String account) async {
    await _initSecureStorage();
    if (_secureMode) {
      return _secureStorage!.read('pwd_$account');
    }
    return _getPasswordFromPrefs(account);
  }
  Future<void> selectAccount(String account) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kLastAccount, account);
    await _addAccountToHistory(account);
  }
  Future<void> removeAccount(String account) async {
    await _initSecureStorage();
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList(_kAccountsHistory) ?? [];
    history.remove(account);
    await prefs.setStringList(_kAccountsHistory, history);
    if (_secureMode) {
      await _secureStorage!.delete('pwd_$account');
    } else {
      final mapJson = prefs.getString(_kAccountPwds);
      if (mapJson != null) {
        try {
          final map = Map<String, dynamic>.from(jsonDecode(mapJson));
          map.remove(account);
          await prefs.setString(_kAccountPwds, jsonEncode(map));
        } catch (e) {
          debugPrint('删除账号密码映射失败: $e');
        }
      }
    }
    if ((prefs.getString(_kLastAccount)) == account) {
      await prefs.remove(_kLastAccount);
    }
  }
  Future<void> _addAccountToHistory(String account) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_kAccountsHistory) ?? [];
    list.remove(account);
    list.insert(0, account);
    while (list.length > _maxAccounts) {
      list.removeLast();
    }
    await prefs.setStringList(_kAccountsHistory, list);
    await prefs.setString(_kLastAccount, account);
  }
  Future<void> _savePasswordForAccount(String account, String encodedPwd) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> map = {};
    final mapJson = prefs.getString(_kAccountPwds);
    if (mapJson != null) {
      try {
        map = Map<String, dynamic>.from(jsonDecode(mapJson));
      } catch (e) {
        debugPrint('读取密码映射失败: $e');
      }
    }
    map[account] = encodedPwd;
    await prefs.setString(_kAccountPwds, jsonEncode(map));
  }
  Future<void> forgetPasswordFor(String account) async {
    await _initSecureStorage();
    if (_secureMode) {
      await _secureStorage!.delete('pwd_$account');
    } else {
      final prefs = await SharedPreferences.getInstance();
      final mapJson = prefs.getString(_kAccountPwds);
      if (mapJson != null) {
        try {
          final map = Map<String, dynamic>.from(jsonDecode(mapJson));
          map.remove(account);
          await prefs.setString(_kAccountPwds, jsonEncode(map));
        } catch (e) {
          debugPrint('删除密码失败: $e');
        }
      }
    }
  }
  Future<void> clear() async {
    await _initSecureStorage();
    final prefs = await SharedPreferences.getInstance();
    if (_secureMode) {
      await _secureStorage!.deleteAll();
    }
    await prefs.remove(_kAccount);
    await prefs.remove(_kPassword);
    await prefs.remove(_kRemember);
    await prefs.remove(_kLastAccount);
    await prefs.remove(_kAccountPwds);
    await prefs.remove(_kSecureModeKey);
  }
}
