import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../menu/models.dart';
import '../menu/menu_api.dart';
import '../../core/network/api_client.dart';

/// 角色菜单配置对话框
class RoleMenuDialog extends StatefulWidget {
  final int roleId;
  final String roleName;
  final List<int> initialMenuIds;

  const RoleMenuDialog({
    super.key,
    required this.roleId,
    required this.roleName,
    this.initialMenuIds = const [],
  });

  @override
  State<RoleMenuDialog> createState() => _RoleMenuDialogState();
}

class _RoleMenuDialogState extends State<RoleMenuDialog> {
  List<MenuItem> _allMenus = [];
  Set<int> _selectedMenuIds = {};
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _selectedMenuIds = Set.from(widget.initialMenuIds);
    _loadMenus();
  }

  Future<void> _loadMenus() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final api = MenuApi();
      final menus = await api.getMenuTree();
      setState(() {
        _allMenus = menus;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  void _toggleMenu(int menuId, bool? value) {
    setState(() {
      if (value == true) {
        _selectedMenuIds.add(menuId);
      } else {
        _selectedMenuIds.remove(menuId);
      }
    });
  }

  void _toggleParentAndChildren(MenuItem menu, bool? value) {
    setState(() {
      if (value == true) {
        _selectedMenuIds.add(menu.id);
        // 选中所有子菜单
        for (var child in menu.children) {
          _selectedMenuIds.add(child.id);
          // 递归选中子菜单的子菜单
          _selectAllChildren(child);
        }
      } else {
        _selectedMenuIds.remove(menu.id);
        // 取消所有子菜单
        for (var child in menu.children) {
          _selectedMenuIds.remove(child.id);
          _deselectAllChildren(child);
        }
      }
    });
  }

  void _selectAllChildren(MenuItem menu) {
    for (var child in menu.children) {
      _selectedMenuIds.add(child.id);
      _selectAllChildren(child);
    }
  }

  void _deselectAllChildren(MenuItem menu) {
    for (var child in menu.children) {
      _selectedMenuIds.remove(child.id);
      _deselectAllChildren(child);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
      title: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.withOpacity(0.1), Colors.blue.withOpacity(0.05)],
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.blue.lighter],
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                FluentIcons.list,
                size: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '角色菜单配置',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '为 "${widget.roleName}" 配置可访问的菜单',
                    style: TextStyle(
                      color: Colors.grey[130],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      content: Container(
        width: 600,
        padding: const EdgeInsets.all(20),
        child: _loading
            ? const Center(child: ProgressRing())
            : _error != null
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(FluentIcons.error_badge, size: 48, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(_error!, style: TextStyle(color: Colors.red)),
                        const SizedBox(height: 16),
                        FilledButton(
                          onPressed: _loadMenus,
                          child: const Text('重试'),
                        ),
                      ],
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue.withOpacity(0.2)),
                        ),
                        child: Row(
                          children: [
                            Icon(FluentIcons.info, size: 16, color: Colors.blue),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '已选择 ${_selectedMenuIds.length} 个菜单',
                                style: TextStyle(
                                  color: Colors.blue.dark,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[60]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListView(
                            padding: const EdgeInsets.all(12),
                            children: _buildMenuTree(_allMenus),
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
      actions: [
        Button(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, _selectedMenuIds.toList()),
          child: const Text('确定'),
        ),
      ],
    );
  }

  List<Widget> _buildMenuTree(List<MenuItem> menus, {int level = 0}) {
    final widgets = <Widget>[];

    for (var menu in menus) {
      final hasChildren = menu.children.isNotEmpty;
      final isSelected = _selectedMenuIds.contains(menu.id);
      final indent = level * 24.0;

      widgets.add(
        Padding(
          padding: EdgeInsets.only(left: indent, bottom: 4),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue.withOpacity(0.05) : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: isSelected ? Colors.blue.withOpacity(0.3) : Colors.transparent,
              ),
            ),
            child: Checkbox(
              checked: isSelected,
              onChanged: hasChildren
                  ? (value) => _toggleParentAndChildren(menu, value)
                  : (value) => _toggleMenu(menu.id, value),
              content: Row(
                children: [
                  Icon(
                    _getMenuIcon(menu.icon),
                    size: 16,
                    color: isSelected ? Colors.blue : Colors.grey[130],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      menu.title,
                      style: TextStyle(
                        color: isSelected ? Colors.blue.dark : Colors.grey[160],
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                  if (menu.type == 1)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[60],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        '目录',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    )
                  else if (menu.type == 2)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        '页面',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );

      if (hasChildren) {
        widgets.addAll(_buildMenuTree(menu.children, level: level + 1));
      }
    }

    return widgets;
  }

  IconData _getMenuIcon(String? iconName) {
    switch (iconName) {
      case 'dashboard':
      case 'home':
        return FluentIcons.home;
      case 'food':
      case 'restaurant':
        return FluentIcons.breakfast;
      case 'file-paste':
      case 'clipboard':
        return FluentIcons.clipboard_list;
      case 'chart':
      case 'chart-bar':
        return FluentIcons.chart;
      case 'shop':
      case 'store':
        return FluentIcons.shop;
      case 'user':
      case 'people':
        return FluentIcons.people;
      case 'usergroup':
      case 'permissions':
        return FluentIcons.permissions;
      case 'menu':
      case 'menu-fold':
        return FluentIcons.list;
      case 'setting':
      case 'settings':
        return FluentIcons.settings;
      case 'link':
      case 'robot':
        return FluentIcons.robot;
      case 'view-list':
        return FluentIcons.bulleted_list;
      default:
        return FluentIcons.page;
    }
  }
}
