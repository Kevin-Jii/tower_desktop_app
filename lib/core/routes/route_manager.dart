import 'package:fluent_ui/fluent_ui.dart';
import 'package:tower_desktop_app/features/menu/menu_management_page.dart';
import 'package:tower_desktop_app/features/role/role_management_page.dart';
import 'package:tower_desktop_app/features/dish/dish_management_page.dart';
import 'package:tower_desktop_app/features/dingtalk/dingtalk_management_page.dart';
import 'package:tower_desktop_app/features/menu_report/menu_report_management_page.dart';
import '../../features/menu/models.dart';
import '../constants/menu_types.dart';
import '../../features/user/user_management_page.dart';
import '../../features/store/store_management_page.dart';

/// 路由管理器
class RouteManager {
  static final RouteManager _instance = RouteManager._internal();
  factory RouteManager() => _instance;
  RouteManager._internal();

  /// 根据菜单项获取对应的页面
  Widget? getPageForMenuItem(MenuItem menuItem) {
    // 目录与按钮不直接渲染页面
    if (menuItem.type == null) return null;
    if (menuItem.type != MenuType.page) return null;
    final component = menuItem.component;
    if (component == null || component.isEmpty) {
      return null;
    }

    // 根据 component 路径返回对应的页面
    switch (component) {
      // 系统管理
      case 'system/user/index':
        return const UserManagementPage();
      case 'system/role/index':
        return const RoleManagementScope();
      case 'system/menu/index':
        return const MenuManagementScope();
      // 门店管理
      case 'store/list/index':
        return const StoreManagementPage();

      // 菜品管理
      case 'dish/list/index':
        return const DishManagementScope();

      // 钉钉管理
      case 'dingtalk/robot/index':
        return const DingTalkManagementPage();
      case 'report/list/index':
        return const MenuReportManagementScope();
      // case 'report/statistics/index':
      //   return _buildModulePage('数据统计', menuItem);

      default:
        debugPrint('未匹配到页面: $component');
        return _buildModulePage('未实现页面', menuItem);
    }
  }

  /// 构建模块页面（临时占位页面）
  Widget _buildModulePage(String moduleName, MenuItem menuItem) {
    return _ModulePlaceholderPage(
      moduleName: moduleName,
      menuItem: menuItem,
    );
  }
}

/// 模块占位页面
class _ModulePlaceholderPage extends StatelessWidget {
  final String moduleName;
  final MenuItem menuItem;

  const _ModulePlaceholderPage({
    required this.moduleName,
    required this.menuItem,
  });

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(FluentIcons.page, size: 64, color: Colors.blue),
            const SizedBox(height: 24),
            Text(
              moduleName,
              style: FluentTheme.of(context).typography.title,
            ),
            const SizedBox(height: 8),
            Text(
              '组件路径: ${menuItem.component}',
              style: FluentTheme.of(context).typography.body,
            ),
            const SizedBox(height: 4),
            Text(
              '路由路径: ${menuItem.path}',
              style: FluentTheme.of(context).typography.caption,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.orange.lightest,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.orange.light),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(FluentIcons.info, size: 16, color: Colors.orange),
                  const SizedBox(width: 8),
                  Text(
                    '页面开发中...',
                    style: TextStyle(color: Colors.orange.dark),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 图标逻辑已迁移到 TdIconMapper
}
