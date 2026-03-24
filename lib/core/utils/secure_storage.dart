import 'dart:io';
import 'package:flutter/foundation.dart';
abstract class SecureStorage {
  Future<void> write(String key, String value);
  Future<String?> read(String key);
  Future<void> delete(String key);
  Future<void> deleteAll();
}
class WindowsCredentialStorage implements SecureStorage {
  static const String _credentialPrefix = 'TowerDesktop';
  @override
  Future<void> write(String key, String value) async {
    if (!Platform.isWindows) {
      throw UnsupportedError('仅支持 Windows 平台');
    }
    final target = '$_credentialPrefix:$key';
    await Process.run('cmdkey', ['/delete', target]);
    final script = '''
\$target = '$target'
\$password = '$value'
Add-Type -AssemblyName System.Runtime.WindowsRuntime
\$aep = [Windows.Security.Credentials.PasswordVault,Windows.Security.Credentials,ContentType=WindowsRuntime]
\$vault = \$aep.GetConstructor([void]).Invoke(@())
try {
  \$vault.Remove(\$aep.GetMethod('Retrieve').Invoke(\$vault, @(\$target)))
} catch {}
\$cred = \$aep.GetConstructors()[1].Invoke(@(\$target, \$password))
\$vault.Add(\$cred)
''';
    await Process.run('powershell', ['-Command', script]);
  }
  @override
  Future<String?> read(String key) async {
    if (!Platform.isWindows) {
      throw UnsupportedError('仅支持 Windows 平台');
    }
    final target = '$_credentialPrefix:$key';
    final script = '''
\$target = '$target'
\$aep = [Windows.Security.Credentials.PasswordVault,Windows.Security.Credentials,ContentType=WindowsRuntime]
\$vault = \$aep.GetConstructor([void]).Invoke(@())
try {
  \$cred = \$vault.Retrieve(\$target)
  \$cred.RetrievePassword()
  Write-Output \$cred.Password
} catch {
  Write-Output ''
}
''';
    final result = await Process.run('powershell', ['-Command', script]);
    final output = result.stdout.toString().trim();
    return output.isEmpty ? null : output;
  }
  @override
  Future<void> delete(String key) async {
    if (!Platform.isWindows) {
      throw UnsupportedError('仅支持 Windows 平台');
    }
    final target = '$_credentialPrefix:$key';
    await Process.run('cmdkey', ['/delete', target]);
  }
  @override
  Future<void> deleteAll() async {
    if (!Platform.isWindows) {
      throw UnsupportedError('仅支持 Windows 平台');
    }
    final script = '''
\$aep = [Windows.Security.Credentials.PasswordVault,Windows.Security.Credentials,ContentType=WindowsRuntime]
\$vault = \$aep.GetConstructor([void]).Invoke(@())
\$creds = \$vault.FindAllByResource('$_credentialPrefix')
foreach(\$c in \$creds) { \$vault.Remove(\$c) }
''';
    await Process.run('powershell', ['-Command', script]);
  }
}
class FallbackInsecureStorage implements SecureStorage {
  final Map<String, String> _storage = const {};
  @override
  Future<void> write(String key, String value) async {
    debugPrint('警告：使用不安全的内存存储，请使用 Windows Credential Manager');
    _storage[key] = value;
  }
  @override
  Future<String?> read(String key) async {
    debugPrint('警告：使用不安全的内存存储，请使用 Windows Credential Manager');
    return _storage[key];
  }
  @override
  Future<void> delete(String key) async {
    debugPrint('警告：使用不安全的内存存储，请使用 Windows Credential Manager');
    _storage.remove(key);
  }
  @override
  Future<void> deleteAll() async {
    debugPrint('警告：使用不安全的内存存储，请使用 Windows Credential Manager');
    _storage.clear();
  }
}
Future<SecureStorage> getSecureStorage() async {
  if (Platform.isWindows) {
    try {
      final storage = WindowsCredentialStorage();
      await storage.write('_test', 'test');
      await storage.delete('_test');
      return storage;
    } catch (e) {
      debugPrint('Windows Credential Manager 不可用: $e');
      return FallbackInsecureStorage();
    }
  }
  return FallbackInsecureStorage();
}
