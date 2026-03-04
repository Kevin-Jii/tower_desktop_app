import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';
class SystemTrayManager {
  static Future<void> initialize() async {
    await trayManager.setIcon(
      'windows/runner/resources/app_icon.ico',
    );
    await trayManager.setToolTip('Tower供应数据管理中心');
    Menu menu = Menu(
      items: [
        MenuItem(
          key: 'show_window',
          label: '显示窗口',
        ),
        MenuItem.separator(),
        MenuItem(
          key: 'exit_app',
          label: '退出',
        ),
      ],
    );
    await trayManager.setContextMenu(menu);
  }
  static Future<void> handleMenuItemClick(MenuItem menuItem) async {
    switch (menuItem.key) {
      case 'show_window':
        await windowManager.show();
        await windowManager.focus();
        break;
      case 'exit_app':
        await windowManager.destroy();
        break;
    }
  }
  static Future<void> handleTrayIconClick() async {
    bool isVisible = await windowManager.isVisible();
    if (isVisible) {
      await windowManager.hide();
    } else {
      await windowManager.show();
      await windowManager.focus();
    }
  }
}
