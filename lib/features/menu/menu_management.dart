import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import '../../core/constants/menu_types.dart';
import 'menu_api.dart';
import 'menu_form_dialog.dart';
import 'models.dart';
import '../../core/network/api_client.dart';

class MenuManagement extends StatelessWidget {
  const MenuManagement({super.key});

  static Future<void> _loadMenus(BuildContext context) async {
    await context.read<MenuManageProvider>().loadData(() async {
      final api = MenuApi(ApiClient());
      final response = await api.getMenus();
      return response;
    });
  }

  static Widget _buildTreeNode(MenuTreeNode node, int level) {
    return Consumer<MenuManageProvider>(
      builder: (context, provider, child) {
        final item = node.item;
        final isDirectory = item.type == MenuType.directory;
        final isPage = item.type == MenuType.page;
        final isButton = item.type == MenuType.button;

        return ExpansionTile(
          title: Row(
            children: [
              Icon(
                isDirectory
                    ? Icons.folder_outlined
                    : isPage
                        ? Icons.pageview_outlined
                        : Icons.smart_button_outlined,
                size: 20,
                color: isDirectory ? Colors.orange : Colors.blue,
              ),
              const SizedBox(width: 8),
              Text(
                item.title,
                style: TextStyle(
                  fontWeight: level == 0 ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              if (item.path != null) ...[
                const SizedBox(width: 8),
                Text(
                  item.path!,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ],
          ),
          leading: Icon(
            node.expanded ? Icons.expand_more : Icons.chevron_right,
            size: 18,
          ),
          children: [
            ...node.children.map((child) => _buildTreeNode(child, level + 1)),
            _buildNodeActions(context, item, level),
          ],
        );
      },
    );
  }

  static Widget _buildNodeActions(
      BuildContext context, MenuItem item, int level) {
    return Padding(
      padding: EdgeInsets.only(left: 16 + level * 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton.icon(
            icon: const Icon(Icons.add, size: 18),
            label: const Text('添加子菜单'),
            onPressed: () => _openCreate(context),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined, size: 18),
            onPressed: () => _openEdit(context, item),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
            onPressed: () => _handleDelete(context, item),
          ),
        ],
      ),
    );
  }

  static Future<void> _handleCreate(BuildContext context) async {
    final provider = context.read<MenuManageProvider>();
    final parents = provider
        .flattened()
        .map((n) => n.item)
        .where((m) => m.type == MenuType.directory || m.type == MenuType.page)
        .toList();

    final result = await showDialog<CreateMenuRequest>(
      context: context,
      builder: (_) => MenuFormDialog(parents: parents),
    );

    if (result != null) {
      try {
        final api = MenuApi(ApiClient());
        await api.createMenu(result);
        await _loadMenus(context);

        if (context.mounted) {
          TDToast.showSuccess('创建成功', context: context);
        }
      } catch (e) {
        if (context.mounted) {
          TDToast.showError('创建失败: $e', context: context);
        }
      }
    }
  }

  static Future<void> _openEdit(BuildContext context, MenuItem item) async {
    final provider = context.read<MenuManageProvider>();
    final parents = provider
        .flattened()
        .map((n) => n.item)
        .where((m) =>
            m.id != item.id &&
            (m.type == MenuType.directory || m.type == MenuType.page))
        .toList();

    final result = await showDialog<UpdateMenuRequest>(
      context: context,
      builder: (_) => MenuFormDialog(editing: item, parents: parents),
    );

    if (result != null) {
      try {
        final api = MenuApi(ApiClient());
        await api.updateMenu(item.id, result);
        await _loadMenus(context);

        if (context.mounted) {
          TDToast.showSuccess('更新成功', context: context);
        }
      } catch (e) {
        if (context.mounted) {
          TDToast.showError('更新失败: $e', context: context);
        }
      }
    }
  }

  static Future<void> _handleDelete(BuildContext context, MenuItem item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除菜单 "${item.title}" 吗?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('取消')),
          ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('删除')),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        final api = MenuApi(ApiClient());
        await api.deleteMenu(item.id);
        await _loadMenus(context);

        if (context.mounted) {
          TDToast.showSuccess('删除成功', context: context);
        }
      } catch (e) {
        if (context.mounted) {
          TDToast.showError('删除失败: $e', context: context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MenuManageProvider(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('菜单管理'),
              actions: [
                ElevatedButton.icon(
                  onPressed: () => _handleCreate(context),
                  icon: const Icon(Icons.add),
                  label: const Text('新增菜单'),
                ),
                const SizedBox(width: 16),
              ],
            ),
            body: Consumer<MenuManageProvider>(
              builder: (context, provider, child) {
                if (provider.loading && provider.flatItems.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (provider.error != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('加载失败: ${provider.error}'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => _loadMenus(context),
                          child: const Text('重试'),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: provider.nodes.length,
                  itemBuilder: (_, i) => _buildTreeNode(provider.nodes[i], 0),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class MenuManageProvider extends ChangeNotifier {
  final List<MenuItem> _items = [];
  bool _loading = false;
  String? _error;

  List<MenuItem> get items => _items;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> loadData(Future<List<MenuItem>> Function() fetcher) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _items.clear();
      _items.addAll(await fetcher());
      _error = null;
    } catch (e) {
      _error = e.toString();
      debugPrint('加载失败: $e');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  List<MenuTreeNode> buildTree() {
    final idMap = <int, MenuTreeNode>{};
    final roots = <MenuTreeNode>[];

    for (final item in _items) {
      idMap[item.id] = MenuTreeNode(item: item, children: []);
    }

    for (final item in _items) {
      if (item.parentId == 0) {
        roots.add(idMap[item.id]!);
      } else if (item.parentId != 0 && idMap.containsKey(item.parentId)) {
        idMap[item.parentId]!.children.add(idMap[item.id]!);
      }
    }

    return roots;
  }

  List<MenuTreeNode> flattened() {
    final result = <MenuTreeNode>[];
    final nodes = buildTree();
    for (final node in nodes) {
      result.add(node);
      result.addAll(_flatten(node));
    }
    return result;
  }

  List<MenuTreeNode> _flatten(MenuTreeNode node) {
    final result = <MenuTreeNode>[];
    for (final child in node.children) {
      result.add(child);
      result.addAll(_flatten(child));
    }
    return result;
  }
}

class MenuTreeNode {
  final MenuItem item;
  final List<MenuTreeNode> children;
  bool expanded = true;

  MenuTreeNode({
    required this.item,
    required this.children,
  });
}
