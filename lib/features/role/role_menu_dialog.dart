import 'package:fluent_ui/fluent_ui.dart';
import '../menu/models.dart';
import '../menu/menu_api.dart';
import '../../core/widgets/fluent_info_bar.dart';

/// 角色菜单配置对话框
class RoleMenuDialog extends StatefulWidget {
  final int roleId;
  final String roleName;

  const RoleMenuDialog({
    super.key,
    required this.roleId,
    required this.roleName,
  });

  @override
  State<RoleMenuDialog> createState() => _RoleMenuDialogState();
}

class _RoleMenuDialogState extends State<RoleMenuDialog> {
  final MenuApi _menuApi = MenuApi();
  List<MenuItem> _allMenus = [];
  Set<int> _selectedMenuIds = {};
  Set<int> _expandedIds = {}; // 展开的节点
  bool _loading = true;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final results = await Future.wait([
        _menuApi.getMenuTree(),
        _menuApi.getRoleMenuIds(widget.roleId),
      ]);

      setState(() {
        _allMenus = results[0] as List<MenuItem>;
        _selectedMenuIds = Set.from(results[1] as List<int>);
        // 默认展开所有一级菜单
        _expandedIds = _allMenus.map((m) => m.id).toSet();
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }


  Future<void> _handleSave() async {
    setState(() => _saving = true);
    try {
      await _menuApi.assignRoleMenus(widget.roleId, _selectedMenuIds.toList());
      if (mounted) {
        await FluentInfoBarHelper.showSuccess(context, '菜单权限保存成功');
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        await FluentInfoBarHelper.showError(context, '保存失败: $e');
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _toggleExpand(int menuId) {
    setState(() {
      if (_expandedIds.contains(menuId)) {
        _expandedIds.remove(menuId);
      } else {
        _expandedIds.add(menuId);
      }
    });
  }

  void _toggleMenu(int menuId, bool? value) {
    setState(() {
      if (value == true) {
        _selectedMenuIds.add(menuId);
        _selectParents(menuId);
      } else {
        _selectedMenuIds.remove(menuId);
        _deselectChildren(menuId);
      }
    });
  }

  void _toggleWithChildren(MenuItem menu, bool? value) {
    setState(() {
      if (value == true) {
        _selectedMenuIds.add(menu.id);
        _selectParents(menu.id);
        _selectAllChildren(menu);
      } else {
        _selectedMenuIds.remove(menu.id);
        _deselectAllChildren(menu);
      }
    });
  }

  void _selectParents(int menuId) {
    void findAndSelectParent(List<MenuItem> menus, int targetId) {
      for (var menu in menus) {
        if (_containsChild(menu, targetId)) {
          _selectedMenuIds.add(menu.id);
        }
        findAndSelectParent(menu.children, targetId);
      }
    }
    findAndSelectParent(_allMenus, menuId);
  }

  bool _containsChild(MenuItem menu, int childId) {
    for (var child in menu.children) {
      if (child.id == childId) return true;
      if (_containsChild(child, childId)) return true;
    }
    return false;
  }

  void _deselectChildren(int menuId) {
    MenuItem? findMenu(List<MenuItem> menus, int id) {
      for (var menu in menus) {
        if (menu.id == id) return menu;
        final found = findMenu(menu.children, id);
        if (found != null) return found;
      }
      return null;
    }
    final menu = findMenu(_allMenus, menuId);
    if (menu != null) _deselectAllChildren(menu);
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

  void _expandAll() {
    setState(() {
      void addAll(List<MenuItem> menus) {
        for (var menu in menus) {
          if (menu.children.isNotEmpty) {
            _expandedIds.add(menu.id);
            addAll(menu.children);
          }
        }
      }
      addAll(_allMenus);
    });
  }

  void _collapseAll() {
    setState(() => _expandedIds.clear());
  }

  void _selectAll() {
    setState(() {
      void addAll(List<MenuItem> menus) {
        for (var menu in menus) {
          _selectedMenuIds.add(menu.id);
          addAll(menu.children);
        }
      }
      addAll(_allMenus);
    });
  }

  void _deselectAll() {
    setState(() => _selectedMenuIds.clear());
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ContentDialog(
      constraints: const BoxConstraints(maxWidth: 700, maxHeight: 800),
      title: _buildHeader(),
      content: Container(
        width: 700,
        padding: const EdgeInsets.all(16),
        child: _loading
            ? const Center(child: ProgressRing())
            : _error != null
                ? _buildError()
                : _buildContent(isDark),
      ),
      actions: [
        Button(
          onPressed: _saving ? null : () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _saving || _loading ? null : _handleSave,
          child: _saving
              ? const SizedBox(width: 16, height: 16, child: ProgressRing(strokeWidth: 2))
              : const Text('保存'),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
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
              gradient: LinearGradient(colors: [Colors.blue, Colors.blue.lighter]),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(FluentIcons.list, size: 20, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('配置菜单权限',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('为 "${widget.roleName}" 分配可访问的菜单',
                    style: TextStyle(color: Colors.grey[130], fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(FluentIcons.error_badge, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(_error!, style: TextStyle(color: Colors.red)),
          const SizedBox(height: 16),
          FilledButton(onPressed: _loadData, child: const Text('重试')),
        ],
      ),
    );
  }

  Widget _buildContent(bool isDark) {
    return Column(
      children: [
        // 工具栏
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[150].withOpacity(0.1) : Colors.grey[20],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(FluentIcons.check_mark, size: 14, color: Colors.blue),
              const SizedBox(width: 6),
              Text('已选 ${_selectedMenuIds.length} 项',
                  style: TextStyle(color: Colors.blue.dark, fontWeight: FontWeight.w600)),
              const Spacer(),
              _buildToolButton('展开全部', FluentIcons.chevron_down_med, _expandAll),
              const SizedBox(width: 6),
              _buildToolButton('收起全部', FluentIcons.chevron_up_med, _collapseAll),
              const SizedBox(width: 12),
              _buildToolButton('全选', FluentIcons.checkbox_composite, _selectAll),
              const SizedBox(width: 6),
              _buildToolButton('清空', FluentIcons.clear, _deselectAll),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // 菜单树
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: isDark ? Colors.grey[100].withOpacity(0.3) : Colors.grey[50]!),
              borderRadius: BorderRadius.circular(8),
              color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
            ),
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: _allMenus.map((menu) => _buildTreeNode(menu, isDark, 0)).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildToolButton(String label, IconData icon, VoidCallback onPressed) {
    return HoverButton(
      onPressed: onPressed,
      builder: (context, states) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: states.isHovered ? Colors.blue.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 12, color: Colors.blue),
              const SizedBox(width: 4),
              Text(label, style: TextStyle(fontSize: 12, color: Colors.blue)),
            ],
          ),
        );
      },
    );
  }


  Widget _buildTreeNode(MenuItem menu, bool isDark, int level) {
    final hasChildren = menu.children.isNotEmpty;
    final isExpanded = _expandedIds.contains(menu.id);
    final isSelected = _selectedMenuIds.contains(menu.id);

    // 计算子节点选中状态
    bool? checkState;
    if (hasChildren) {
      final allSelected = _allChildrenSelected(menu);
      final someSelected = _someChildrenSelected(menu);
      if (allSelected) {
        checkState = true;
      } else if (someSelected) {
        checkState = null; // 半选状态
      } else {
        checkState = isSelected;
      }
    } else {
      checkState = isSelected;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 当前节点
        Container(
          margin: EdgeInsets.only(left: level * 20.0, bottom: 2, top: level == 0 ? 4 : 0),
          child: HoverButton(
            onPressed: hasChildren ? () => _toggleExpand(menu.id) : null,
            builder: (context, states) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.blue.withOpacity(isDark ? 0.2 : 0.1)
                      : states.isHovered
                          ? (isDark ? Colors.grey[150].withOpacity(0.1) : Colors.grey[30])
                          : (level == 0 ? (isDark ? Colors.grey[150].withOpacity(0.05) : Colors.grey[20]) : Colors.transparent),
                  borderRadius: BorderRadius.circular(6),
                  border: level == 0
                      ? Border.all(color: isDark ? Colors.grey[100].withOpacity(0.2) : Colors.grey[40]!)
                      : null,
                ),
                child: Row(
                  children: [
                    // 展开/收起图标
                    SizedBox(
                      width: 20,
                      child: hasChildren
                          ? Icon(
                              isExpanded ? FluentIcons.chevron_down : FluentIcons.chevron_right,
                              size: 12,
                              color: isDark ? Colors.grey[100] : Colors.grey[130],
                            )
                          : const SizedBox.shrink(),
                    ),
                    // 复选框
                    Checkbox(
                      checked: checkState,
                      onChanged: hasChildren
                          ? (v) => _toggleWithChildren(menu, v ?? false)
                          : (v) => _toggleMenu(menu.id, v),
                    ),
                    const SizedBox(width: 8),
                    // 图标
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: _getTypeColor(menu.type).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Icon(
                        _getMenuIcon(menu.icon),
                        size: 14,
                        color: _getTypeColor(menu.type),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // 标题
                    Expanded(
                      child: Text(
                        menu.title,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.blue
                              : (isDark ? Colors.white : Colors.grey[160]),
                          fontWeight: level == 0 ? FontWeight.w600 : FontWeight.normal,
                          fontSize: level == 0 ? 14 : 13,
                        ),
                      ),
                    ),
                    // 子节点数量
                    if (hasChildren)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[60],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${menu.children.length}',
                          style: const TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ),
                    // 类型标签
                    _buildTypeTag(menu.type),
                  ],
                ),
              );
            },
          ),
        ),
        // 子节点
        if (hasChildren && isExpanded)
          ...menu.children.map((child) => _buildTreeNode(child, isDark, level + 1)),
      ],
    );
  }

  bool _allChildrenSelected(MenuItem menu) {
    for (var child in menu.children) {
      if (!_selectedMenuIds.contains(child.id)) return false;
      if (child.children.isNotEmpty && !_allChildrenSelected(child)) return false;
    }
    return true;
  }

  bool _someChildrenSelected(MenuItem menu) {
    for (var child in menu.children) {
      if (_selectedMenuIds.contains(child.id)) return true;
      if (child.children.isNotEmpty && _someChildrenSelected(child)) return true;
    }
    return false;
  }

  Color _getTypeColor(int? type) {
    switch (type) {
      case 1:
        return Colors.blue;
      case 2:
        return Colors.green;
      case 3:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Widget _buildTypeTag(int? type) {
    String label;
    Color color;
    switch (type) {
      case 1:
        label = '目录';
        color = Colors.blue;
        break;
      case 2:
        label = '页面';
        color = Colors.green;
        break;
      case 3:
        label = '按钮';
        color = Colors.orange;
        break;
      default:
        return const SizedBox.shrink();
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(label, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w500)),
    );
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
