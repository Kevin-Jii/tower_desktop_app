import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'app.dart';
import 'core/di/service_config.dart';
import 'features/auth/session_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 初始化依赖注入
  ServiceConfig.setupServices();
  
  // 初始化窗口管理器
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
  });
  
  await SessionManager().init();
  
  runApp(const TowerApp());
  
  // 配置 bitsdojo_window
  doWhenWindowReady(() {
    const initialSize = Size(1280, 800);
    const minSize = Size(1024, 600);
    appWindow.minSize = minSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}
