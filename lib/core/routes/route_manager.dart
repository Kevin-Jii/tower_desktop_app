import 'package:fluent_ui/fluent_ui.dart';
// 保持原有的业务页面 import
import 'package:tower_desktop_app/features/menu/menu_management_page.dart';
import 'package:tower_desktop_app/features/role/role_management_page.dart';
import 'package:tower_desktop_app/features/dingtalk/dingtalk_management_page.dart';
import 'package:tower_desktop_app/features/supplier/supplier_management_page.dart';
import 'package:tower_desktop_app/features/purchase_order/purchase_order_list_page.dart';
import 'package:tower_desktop_app/features/dict/dict_management_page.dart';
import '../../features/menu/models.dart';
import '../constants/menu_types.dart';
import '../../features/user/user_management_page.dart';
import '../../features/store/store_management_page.dart';

// 定义一个构建函数的别名，方便管理
typedef PageBuilder = Widget Function();

/// 路由管理器
class RouteManager {
  static final RouteManager _instance = RouteManager._internal();
  factory RouteManager() => _instance;
  RouteManager._internal();

  /// 路由注册表 (核心优化点)
  /// 使用 Map 替代 Switch，结构更清晰，查找更快
  static final Map<String, PageBuilder> _routeMap = {
    // 系统管理
    'system/user/index': () => const UserManagementPage(),
    'system/role/index': () => const RoleManagementScope(),
    'system/menu/index': () => const MenuManagementScope(),
    'system/dict/index': () => const DictManagementScope(),
    
    // 门店管理
    'store/list/index': () => const StoreManagementPage(),
    'store/supplier/index': () => const SupplierManagementPage(),
    
    'store/purchase/index': () => const PurchaseOrderListPage(),
    
    // 钉钉管理
    'dingtalk/robot/index': () => const DingTalkManagementPage(),
  };

  /// 根据菜单项获取对应的页面
  Widget? getPageForMenuItem(MenuItem menuItem) {
    if (menuItem.type != MenuType.page) return null;
    
    final component = menuItem.component;
    if (component == null || component.isEmpty) return null;

    final builder = _routeMap[component];

    if (builder != null) {
      return builder();
    } else {
      debugPrint('RouteManager Warning: 未找到路径映射 -> $component');
      return _buildModulePage('功能建设中', menuItem);
    }
  }

  Widget _buildModulePage(String moduleName, MenuItem menuItem) {
    return _ModulePlaceholderPage(
      moduleName: moduleName,
      menuItem: menuItem,
    );
  }
}

class _ModulePlaceholderPage extends StatelessWidget {
  final String moduleName;
  final MenuItem menuItem;

  const _ModulePlaceholderPage({
    required this.moduleName,
    required this.menuItem,
  });

  @override
  Widget build(BuildContext context) {
    final typography = FluentTheme.of(context).typography;
    
    return ScaffoldPage(
      content: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(FluentIcons.construction_cone, size: 64, color: Colors.orange),
            const SizedBox(height: 24),
            Text(
              moduleName,
              style: typography.title,
            ),
            const SizedBox(height: 12),
            _buildInfoChip(context, '组件路径: ${menuItem.component}'),
            const SizedBox(height: 4),
            _buildInfoChip(context, '路由地址: ${menuItem.path}', isSecondary: true),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue.lightest, 
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.blue.light),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(FluentIcons.info, size: 16, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(
                    '该功能模块正在开发中，敬请期待',
                    style: TextStyle(color: Colors.blue.dark),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 提取小组件，使主 build 方法更干净
  Widget _buildInfoChip(BuildContext context, String text, {bool isSecondary = false}) {
    return Text(
      text,
      style: isSecondary 
          ? FluentTheme.of(context).typography.caption?.copyWith(color: Colors.grey[100])
          : FluentTheme.of(context).typography.body,
    );
  }
}