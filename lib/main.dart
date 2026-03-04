import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'app.dart';
import 'core/di/service_config.dart';
import 'features/auth/session_manager.dart';
import 'core/utils/system_tray.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceConfig.setupServices();
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    size: Size(1280, 800),
    minimumSize: Size(1024, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await SystemTrayManager.initialize();
  });
  await SessionManager().init();
  runApp(const TowerApp());
}
