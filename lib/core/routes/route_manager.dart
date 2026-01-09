import 'package:fluent_ui/fluent_ui.dart';
import 'package:tower_desktop_app/features/menu/menu_management_page.dart';
import 'package:tower_desktop_app/features/role/role_management_page.dart';
import 'package:tower_desktop_app/features/dingtalk/dingtalk_management_page.dart';
import 'package:tower_desktop_app/features/supplier/supplier_management_page.dart';
import 'package:tower_desktop_app/features/purchase_order/purchase_order_list_page.dart';
import 'package:tower_desktop_app/features/dict/dict_management_page.dart';
import 'package:tower_desktop_app/features/inventory/inventory_page.dart';
import 'package:tower_desktop_app/features/store_account/store_account_page.dart';
import 'package:tower_desktop_app/features/gallery/gallery_page.dart';
import 'package:tower_desktop_app/features/member/member_page.dart';
import '../../features/menu/models.dart';
import '../constants/menu_types.dart';
import '../../features/user/user_management_page.dart';
import '../../features/store/store_management_page.dart';
typedef PageBuilder = Widget Function();
class RouteManager {
  static final RouteManager _instance = RouteManager._internal();
  factory RouteManager() => _instance;
  RouteManager._internal();
  static final Map<String, PageBuilder> _routeMap = {
    'system/user/index': () => const UserManagementPage(),
    'system/role/index': () => const RoleManagementScope(),
    'system/menu/index': () => const MenuManagementScope(),
    'system/dict/index': () => const DictManagementScope(),
    'system/gallery/index': () => const GalleryPage(),
    'store/list/index': () => const StoreManagementPage(),
    'store/supplier/index': () => const SupplierManagementPage(),
    'store/purchase/index': () => const PurchaseOrderListPage(),
    'store/inventory/index': () => const InventoryPage(),
    'dingtalk/robot/index': () => const DingTalkManagementPage(),
    'store/account/index': () => const StoreAccountPage(),
    'store/member/index': () => const MemberPage(),
    'member/index': () => const MemberPage(),
  };
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
            _buildInfoChip(context, '路由地址: ${menuItem.path}',
                isSecondary: true),
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
  Widget _buildInfoChip(BuildContext context, String text,
      {bool isSecondary = false}) {
    return Text(
      text,
      style: isSecondary
          ? FluentTheme.of(context)
              .typography
              .caption
              ?.copyWith(color: Colors.grey[100])
          : FluentTheme.of(context).typography.body,
    );
  }
}
