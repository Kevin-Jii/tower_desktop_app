import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/fluent_info_bar.dart';
import 'store_provider.dart';
import 'models.dart';
import 'store_form_dialog.dart';

class StoreManagementPage extends StatefulWidget {
  const StoreManagementPage({super.key});

  @override
  State<StoreManagementPage> createState() => _StoreManagementPageState();
}

class _StoreManagementPageState extends State<StoreManagementPage> {
  final Set<int> _updatingStores = {};
  final _nameCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StoreProvider>().loadStores();
    });
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  void _handleSearch() {
    final keyword = _nameCtrl.text.trim();
    context.read<StoreProvider>().loadStores(page: 1, keyword: keyword.isEmpty ? null : keyword);
  }

  void _handleReset() {
    _nameCtrl.clear();
    context.read<StoreProvider>().loadStores(page: 1, keyword: null);
  }

  void _handleCreate() async {
    final result = await showDialog<CreateStoreRequest>(
      context: context,
      builder: (ctx) => const StoreFormDialog(),
    );
    if (result != null && mounted) {
      final success = await context.read<StoreProvider>().createStore(result);
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '创建成功');
      } else if (mounted) {
        final err = context.read<StoreProvider>().error ?? '创建失败';
        await FluentInfoBarHelper.showError(context, err);
      }
    }
  }

  void _handleEdit(Store store) async {
    final result = await showDialog<UpdateStoreRequest>(
      context: context,
      builder: (ctx) => StoreFormDialog(store: store),
    );
    if (result != null && mounted) {
      final success = await context.read<StoreProvider>().updateStore(store.id, result);
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '更新成功');
      } else if (mounted) {
        final err = context.read<StoreProvider>().error ?? '更新失败';
        await FluentInfoBarHelper.showError(context, err);
      }
    }
  }

  void _handleDelete(Store store) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除门店 "${store.name}" 吗？'),
        actions: [
          Button(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.red)),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    if (result == true && mounted) {
      final success = await context.read<StoreProvider>().deleteStore(store.id);
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '删除成功');
      } else if (mounted) {
        final err = context.read<StoreProvider>().error ?? '删除失败';
        await FluentInfoBarHelper.showError(context, err);
      }
    }
  }

  void _handleStatusChange(Store store, bool value) async {
    setState(() => _updatingStores.add(store.id));
    final newStatus = value ? 1 : 0;
    final req = UpdateStoreRequest(status: newStatus);
    final success = await context.read<StoreProvider>().updateStore(store.id, req);
    if (mounted) {
      setState(() => _updatingStores.remove(store.id));
    }
    if (success && mounted) {
      await FluentInfoBarHelper.showSuccess(context, '状态已更新');
    } else if (mounted) {
      final err = context.read<StoreProvider>().error ?? '状态更新失败';
      await FluentInfoBarHelper.showError(context, err);
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
          _buildPagination(),
        ],
      ),
    );
  }

  Widget _buildToolbar() {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.accentColor.withOpacity(0.05),
            isDark ? const Color(0xFF2D2D2D) : theme.micaBackgroundColor,
          ],
        ),
        border: Border(
          bottom: BorderSide(
            color: theme.resources.dividerStrokeColorDefault,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // 标题行
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal, Colors.teal.lighter],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  FluentIcons.store_logo16,
                  size: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '门店管理',
                    style: theme.typography.title?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '管理连锁门店信息',
                    style: theme.typography.caption?.copyWith(
                      color: isDark ? Colors.grey[100] : Colors.grey[130],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              FilledButton(
                onPressed: _handleCreate,
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(FluentIcons.add, size: 18),
                    SizedBox(width: 8),
                    Text('新增门店', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 查询行
          Row(
            children: [
              SizedBox(
                width: 200,
                child: TextBox(
                  controller: _nameCtrl,
                  placeholder: '门店名称',
                  prefix: const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(FluentIcons.search, size: 14),
                  ),
                  onSubmitted: (_) => _handleSearch(),
                ),
              ),
              const SizedBox(width: 12),
              FilledButton(
                onPressed: _handleSearch,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(FluentIcons.search, size: 14),
                    SizedBox(width: 6),
                    Text('查询'),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Button(
                onPressed: _handleReset,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(FluentIcons.refresh, size: 14),
                    SizedBox(width: 6),
                    Text('重置'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Consumer<StoreProvider>(
      builder: (context, provider, _) {
        if (provider.loading) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ProgressRing(),
                const SizedBox(height: 20),
                Text(
                  '加载中...',
                  style: theme.typography.body?.copyWith(
                    color: isDark ? Colors.grey[100] : Colors.grey[130],
                  ),
                ),
              ],
            ),
          );
        }

        if (provider.error != null) {
          return _buildErrorState(provider);
        }

        if (provider.stores.isEmpty) {
          return _buildEmptyState();
        }

        return _buildStoreGrid(provider.stores);
      },
    );
  }

  Widget _buildErrorState(StoreProvider provider) {
    final theme = FluentTheme.of(context);

    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        margin: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.red.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(FluentIcons.error_badge, size: 48, color: Colors.red),
            ),
            const SizedBox(height: 20),
            Text(
              '加载失败',
              style: theme.typography.subtitle?.copyWith(
                color: Colors.red.dark,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              provider.error!,
              style: theme.typography.body?.copyWith(color: Colors.red.darker),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => provider.loadStores(),
              style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.red)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(FluentIcons.refresh, size: 16),
                  SizedBox(width: 8),
                  Text('重试'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    final theme = FluentTheme.of(context);

    return Center(
      child: Container(
        padding: const EdgeInsets.all(48),
        margin: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.teal.withOpacity(0.05),
              Colors.blue.withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.teal.withOpacity(0.1), width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal.withOpacity(0.1), Colors.blue.withOpacity(0.1)],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(FluentIcons.store_logo16, size: 72, color: Colors.teal),
            ),
            const SizedBox(height: 24),
            Text(
              '暂无门店数据',
              style: theme.typography.title?.copyWith(
                color: Colors.grey[160],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '点击右上角"新增门店"按钮创建第一个门店',
              style: theme.typography.body?.copyWith(color: Colors.grey[130]),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _handleCreate,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(FluentIcons.add, size: 18),
                  SizedBox(width: 8),
                  Text('创建第一个门店'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreGrid(List<Store> stores) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      color: isDark ? const Color(0xFF1F1F1F) : const Color(0xFFF5F7FA),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final availableWidth = width - 48;
          final crossAxisCount = width > 900 ? 2 : 1;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: _buildRows(stores, crossAxisCount, availableWidth),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildRows(List<Store> stores, int crossAxisCount, double availableWidth) {
    final List<Widget> rows = [];
    const spacing = 16.0;
    final cardWidth = crossAxisCount == 2 ? (availableWidth - spacing) / 2 : availableWidth;

    for (int i = 0; i < stores.length; i += crossAxisCount) {
      final rowStores = stores.skip(i).take(crossAxisCount).toList();
      rows.add(
        Padding(
          padding: EdgeInsets.only(bottom: i + crossAxisCount < stores.length ? spacing : 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int j = 0; j < rowStores.length; j++) ...[
                SizedBox(
                  width: cardWidth,
                  child: _buildStoreCard(rowStores[j]),
                ),
                if (j < rowStores.length - 1) const SizedBox(width: spacing),
              ],
            ],
          ),
        ),
      );
    }
    return rows;
  }

  Widget _buildStoreCard(Store store) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isActive = store.status == 1;
    final isUpdating = _updatingStores.contains(store.id);

    return Card(
      padding: const EdgeInsets.all(20),
      backgroundColor: isDark ? const Color(0xFF2D2D2D) : Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // 门店图标
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.teal, Colors.teal.lighter],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    store.name.substring(0, 1),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // 门店信息
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            store.name,
                            style: theme.typography.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        // 状态标签
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: isActive
                                  ? [Colors.green.lighter, Colors.green]
                                  : [Colors.grey[60]!, Colors.grey[80]!],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            isActive ? '✓ 营业中' : '✕ 已关闭',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // 详细信息
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[150].withOpacity(0.1) : Colors.grey[20],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                if (store.address != null && store.address!.isNotEmpty)
                  _buildInfoRow(FluentIcons.map_pin, '地址', store.address!, isDark),
                if (store.contactPerson != null && store.contactPerson!.isNotEmpty)
                  _buildInfoRow(FluentIcons.contact, '负责人', store.contactPerson!, isDark),
                if (store.phone != null && store.phone!.isNotEmpty)
                  _buildInfoRow(FluentIcons.phone, '电话', store.phone!, isDark),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // 操作按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (isUpdating)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: ProgressRing(strokeWidth: 2),
                )
              else
                ToggleSwitch(
                  checked: isActive,
                  onChanged: (value) => _handleStatusChange(store, value),
                ),
              const SizedBox(width: 12),
              Button(
                onPressed: () => _handleEdit(store),
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(FluentIcons.edit, size: 12, color: Colors.blue),
                    const SizedBox(width: 4),
                    const Text('编辑', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Button(
                onPressed: () => _handleDelete(store),
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(FluentIcons.delete, size: 12, color: Colors.red),
                    const SizedBox(width: 4),
                    Text('删除', style: TextStyle(fontSize: 12, color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 12, color: isDark ? Colors.grey[100] : Colors.grey[130]),
          const SizedBox(width: 6),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.grey[100] : Colors.grey[130],
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white : Colors.grey[160],
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPagination() {
    return Consumer<StoreProvider>(
      builder: (context, provider, _) {
        if (provider.stores.isEmpty) {
          return const SizedBox.shrink();
        }

        final totalPages = (provider.total / provider.pageSize).ceil();
        if (totalPages <= 1) {
          return const SizedBox.shrink();
        }

        final theme = FluentTheme.of(context);
        final isDark = theme.brightness == Brightness.dark;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
            border: Border(
              top: BorderSide(
                color: isDark ? Colors.grey[100].withOpacity(0.2) : Colors.grey[40]!,
                width: 1,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(FluentIcons.database, size: 16, color: isDark ? Colors.grey[100] : Colors.grey[130]),
                  const SizedBox(width: 8),
                  Text(
                    '共 ${provider.total} 条记录',
                    style: TextStyle(
                      color: isDark ? Colors.grey[100] : const Color(0xFF666666),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[150].withOpacity(0.1) : Colors.grey[20],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: isDark ? Colors.grey[100].withOpacity(0.2) : Colors.grey[40]!),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        FluentIcons.chevron_left,
                        size: 16,
                        color: provider.page > 1 ? Colors.teal : (isDark ? Colors.grey[100] : Colors.grey[100]),
                      ),
                      onPressed: provider.page > 1
                          ? () => provider.loadStores(page: provider.page - 1)
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.teal, Colors.teal.lighter],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.teal.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Text(
                        '${provider.page} / $totalPages',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Icon(
                        FluentIcons.chevron_right,
                        size: 16,
                        color: provider.page < totalPages ? Colors.teal : (isDark ? Colors.grey[100] : Colors.grey[100]),
                      ),
                      onPressed: provider.page < totalPages
                          ? () => provider.loadStores(page: provider.page + 1)
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
