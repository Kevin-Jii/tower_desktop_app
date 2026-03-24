import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/fluent_info_bar.dart';
import '../../core/constants/ui_texts.dart';
import 'menu_api.dart';
import 'menu_manage_provider.dart';
import 'menu_form_dialog.dart';
import 'models.dart';
class MenuManagementPage extends StatefulWidget {
  const MenuManagementPage({super.key});
  @override
  State<MenuManagementPage> createState() => _MenuManagementPageState();
}
class _MenuManagementPageState extends State<MenuManagementPage> {
  static Color _getTypeColor(int? type) {
    switch (type) {
      case 1: return const Color(0xFF6B69D6); 
      case 2: return const Color(0xFF0078D4); 
      case 3: return const Color(0xFF00C9A7); 
      default: return Colors.grey;
    }
  }
  static IconData _getTypeIcon(int? type) {
    switch (type) {
      case 1: return FluentIcons.folder; 
      case 2: return FluentIcons.page; 
      case 3: return FluentIcons.button_control; 
      default: return FluentIcons.circle_ring;
    }
  }
  static String _getTypeText(int? type) {
    switch (type) {
      case 1: return '目录';
      case 2: return '页面';
      case 3: return '按钮';
      default: return '未知';
    }
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MenuManageProvider>().load();
    });
  }
  void _openCreate({MenuItem? parent}) async {
    final provider = context.read<MenuManageProvider>();
    final parents = provider
        .flattened()
        .map((n) => n.item)
        .where((m) => m.type == 1 || m.type == 2)
        .toList();
    final req = await showDialog<CreateMenuRequest>(
      context: context,
      builder: (_) => MenuFormDialog(
        parents: parents,
        initialParentId: parent?.id,
      ),
    );
    if (req != null) {
      final ok = await context.read<MenuManageProvider>().create(req);
      if (!mounted) return;
      if (ok) {
        await FluentInfoBarHelper.showSuccess(context, UITexts.menuCreateSuccess);
      } else {
        await FluentInfoBarHelper.showError(context, UITexts.menuCreateFailed);
      }
    }
  }
  void _openEdit(MenuItem menu) async {
    final provider = context.read<MenuManageProvider>();
    final parents = provider
        .flattened()
        .map((n) => n.item)
        .where((m) => m.id != menu.id && (m.type == 1 || m.type == 2))
        .toList();
    final req = await showDialog<UpdateMenuRequest>(
      context: context,
      builder: (_) => MenuFormDialog(
        editing: menu,
        parents: parents,
      ),
    );
    if (req != null) {
      final ok = await context.read<MenuManageProvider>().update(menu.id, req);
      if (!mounted) return;
      if (ok) {
        await FluentInfoBarHelper.showSuccess(context, UITexts.menuUpdateSuccess);
      } else {
        await FluentInfoBarHelper.showError(context, UITexts.menuUpdateFailed);
      }
    }
  }
  void _delete(MenuItem menu) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => ContentDialog(
        title: const Text(UITexts.menuDeleteConfirmTitle),
        content: Text('${UITexts.menuDeleteConfirmMessage} "${menu.name}"?'),
        actions: [
          Button(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text(UITexts.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(UITexts.commonOk),
          ),
        ],
      ),
    );
    if (confirm == true) {
      final ok = await context.read<MenuManageProvider>().remove(menu.id);
      if (!mounted) return;
      if (ok) {
        await FluentInfoBarHelper.showSuccess(context, UITexts.menuDeleteSuccess);
      } else {
        await FluentInfoBarHelper.showError(context, UITexts.menuDeleteFailed);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Column(
        children: [
          _buildToolbar(),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }
  Widget _buildToolbar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: FluentTheme.of(context).micaBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: FluentTheme.of(context).resources.dividerStrokeColorDefault,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            '菜单管理',
            style: FluentTheme.of(context).typography.subtitle,
          ),
          const Spacer(),
          FilledButton(
            onPressed: () => _openCreate(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(FluentIcons.add, size: 16),
                SizedBox(width: 8),
                Text('新增菜单'),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildContent() {
    return Consumer<MenuManageProvider>(
      builder: (context, provider, _) {
        if (provider.loading) {
          return const Center(child: ProgressRing());
        }
        if (provider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(provider.error!),
                const SizedBox(height: 16),
                Button(
                  onPressed: () => provider.load(),
                  child: const Text('重试'),
                ),
              ],
            ),
          );
        }
        if (provider.tree.isEmpty) {
          return const Center(child: Text('暂无菜单数据'));
        }
        return _buildMenuTree(provider.tree);
      },
    );
  }
  Widget _buildMenuTree(List<MenuItem> menus) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: menus.length,
      itemBuilder: (context, index) {
        return _buildMenuItem(menus[index], 0);
      },
    );
  }
  Widget _buildMenuItem(MenuItem menu, int level) {
    final provider = context.watch<MenuManageProvider>();
    final isExpanded = provider.isExpanded(menu.id);
    final hasChildren = menu.children.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: level * 32.0, bottom: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _getTypeColor(menu.type).withOpacity(0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (hasChildren)
                  IconButton(
                    icon: Icon(
                      isExpanded ? FluentIcons.chevron_down : FluentIcons.chevron_right,
                      size: 16,
                    ),
                    onPressed: () => provider.toggleExpand(menu.id),
                  )
                else
                  const SizedBox(width: 40),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getTypeColor(menu.type).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    _getTypeIcon(menu.type),
                    size: 20,
                    color: _getTypeColor(menu.type),
                  ),
                ),
              ],
            ),
            title: Row(
              children: [
                Text(
                  menu.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _getTypeColor(menu.type),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getTypeColor(menu.type),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getTypeText(menu.type),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (menu.permission?.isNotEmpty == true) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.orange.withOpacity(0.5)),
                    ),
                    child: Text(
                      menu.permission!,
                      style: TextStyle(
                        color: Colors.orange.dark,
                        fontSize: 10,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (menu.name.isNotEmpty)
                  Text('名称: ${menu.name}', style: const TextStyle(fontSize: 12)),
                if (menu.path?.isNotEmpty == true)
                  Text('路径: ${menu.path}', style: const TextStyle(fontSize: 12)),
                if (menu.component?.isNotEmpty == true)
                  Text('组件: ${menu.component}', style: const TextStyle(fontSize: 12)),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (menu.type != 3)
                  Button(
                    onPressed: () => _openCreate(parent: menu),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(FluentIcons.add, size: 12),
                        SizedBox(width: 4),
                        Text('添加子项'),
                      ],
                    ),
                  ),
                const SizedBox(width: 8),
                Button(
                  onPressed: () => _openEdit(menu),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(FluentIcons.edit, size: 12),
                      SizedBox(width: 4),
                      Text('编辑'),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Button(
                  onPressed: () => _delete(menu),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(FluentIcons.delete, size: 12, color: Colors.red),
                      const SizedBox(width: 4),
                      Text('删除', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (hasChildren && isExpanded)
          ...menu.children.map((child) => _buildMenuItem(child, level + 1)),
      ],
    );
  }
  IconData _getMenuIcon(String? icon) {
    switch (icon) {
      case 'dashboard':
        return FluentIcons.home;
      case 'people':
        return FluentIcons.people;
      case 'store':
        return FluentIcons.shop;
      case 'settings':
        return FluentIcons.settings;
      default:
        return FluentIcons.page;
    }
  }
}
class MenuManagementScope extends StatelessWidget {
  const MenuManagementScope({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MenuManageProvider(MenuApi()),
      child: const MenuManagementPage(),
    );
  }
}
