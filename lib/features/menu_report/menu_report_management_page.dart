import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../../core/network/api_client.dart';
import '../../core/widgets/admin_table.dart';
import '../../core/widgets/date_text.dart';
import '../auth/permission_gate.dart';
import '../dish/dish_api.dart';
import '../dish/dish_category_api.dart';
import '../dish/models.dart';
import 'menu_report_api.dart';
import 'menu_report_provider.dart';
import 'models.dart';
class MenuReportManagementPage extends StatefulWidget {
  const MenuReportManagementPage({super.key});

  @override
  State<MenuReportManagementPage> createState() =>
      _MenuReportManagementPageState();
}

class _MenuReportManagementPageState extends State<MenuReportManagementPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MenuReportProvider>().loadReportOrders();
    });
  }

  void _showSnack(String message, {bool success = true}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }

  Future<void> _openCreateDialog() async {
    final provider = context.read<MenuReportProvider>();
    final items = await showDialog<List<CreateMenuReportItemRequest>>(
      context: context,
      builder: (_) => MenuReportOrderFormDialog(
        loadOptions: provider.fetchDishOptions,
      ),
    );
    if (!mounted) return;
    if (items != null && items.isNotEmpty) {
      final ok = await provider.createReportOrder(null, items);
      if (!mounted) return;
      _showSnack(ok ? '创建成功' : (provider.error ?? '创建失败'), success: ok);
    } else if (items != null && items.isEmpty) {
      _showSnack('未选择任何菜品', success: false);
    }
  }

  Future<void> _openDetailsDialog(MenuReportOrder order) async {
    await showDialog<void>(
      context: context,
      builder: (_) => MenuReportOrderDetailsDialog(order: order),
    );
  }

  Future<void> _deleteReportOrder(MenuReportOrder order) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('删除确认'),
        content: Text('确定要删除报菜记录单 #${order.id} 吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (!mounted) return;
    if (confirm == true) {
      final provider = context.read<MenuReportProvider>();
      final ok = await provider.deleteReportOrder(order.id);
      if (!mounted) return;
      _showSnack(ok ? '删除成功' : (provider.error ?? '删除失败'), success: ok);
    }
  }

  Future<void> _pickDateRange() async {
    final provider = context.read<MenuReportProvider>();
    final now = DateTime.now();
    final initialRange = provider.dateRange ??
        DateTimeRange(
          start: now.subtract(const Duration(days: 7)),
          end: now,
        );
    final result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 1),
      initialDateRange: initialRange,
      helpText: '选择日期范围',
      saveText: '确定',
    );
    if (!mounted) return;
    if (result != null) {
      await provider.applyDateFilter(result);
    }
  }

  void _clearDateFilter() {
    final provider = context.read<MenuReportProvider>();
    provider.clearFilters();
    provider.loadReportOrders(page: PaginationDefaults.firstPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Column(
        children: [
          _buildToolbar(),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildToolbar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Text(
            '报菜记录',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          PermissionGate(
            required: PermissionCodes.reportAdd,
            child: ElevatedButton.icon(
              onPressed: _openCreateDialog,
              icon: const Icon(Icons.add),
              label: const Text('新增报菜'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Consumer<MenuReportProvider>(
      builder: (context, provider, _) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildFilters(provider),
              const SizedBox(height: 16),
              Expanded(child: _buildTableArea(provider)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilters(MenuReportProvider provider) {
    final rangeLabel = provider.filterLabel;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          TextButton.icon(
            onPressed: _pickDateRange,
            icon: const Icon(Icons.date_range),
            label: Text(rangeLabel ?? '选择日期范围'),
          ),
          if (provider.hasFilter) ...[
            const SizedBox(width: 8),
            TextButton(
              onPressed: _clearDateFilter,
              child: const Text('清除'),
            ),
          ],
          if (provider.refreshing) ...[
            const SizedBox(width: 16),
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ],
          const Spacer(),
          IconButton(
            tooltip: '刷新',
            onPressed: () => provider.loadReportOrders(page: provider.page),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }

  Widget _buildTableArea(MenuReportProvider provider) {
    if (provider.loading && provider.reportOrders.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.error != null) {
      return _buildErrorState(provider);
    }
    if (provider.reportOrders.isEmpty) {
      return _buildEmptyState(provider);
    }

    return AdminTable<MenuReportOrder>(
      columns: _columns,
      data: provider.reportOrders,
      rowBuilder: _buildRow,
      page: provider.page,
      pageSize: provider.pageSize,
      total: provider.total,
      onPageChange: (page) => provider.loadReportOrders(page: page),
    );
  }

  Widget _buildErrorState(MenuReportProvider provider) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red.shade300),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                provider.error ?? '加载失败',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red.shade700),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => provider.loadReportOrders(page: provider.page),
              icon: const Icon(Icons.refresh),
              label: const Text('重试'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(MenuReportProvider provider) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox_outlined, size: 84, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              provider.hasFilter ? '筛选范围内暂无报菜记录单' : '暂无报菜记录单',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(MenuReportOrder item, int index) {
    Widget buildCell(int columnIndex, Widget child) {
      final column = _columns[columnIndex];
      return SizedBox(
        width: column.width,
        child: Align(
          alignment: column.alignment,
          child: child,
        ),
      );
    }

    final int itemCount = item.items?.length ?? 0;

    return Row(
      children: [
        buildCell(0, Text(item.id.toString())),
        buildCell(
          1,
          Text(
            item.store?.name ?? '—',
            overflow: TextOverflow.ellipsis,
          ),
        ),
        buildCell(
          2,
          Text(
            item.user?.nickname?.isNotEmpty == true
                ? item.user!.nickname!
                : (item.user?.username ?? '—'),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        buildCell(
          3,
          DateText(
            raw: item.createdAt,
            withSeconds: false,
            tooltip: true,
          ),
        ),
        buildCell(
          4,
          Text(
            item.remark?.isNotEmpty == true ? item.remark! : '—',
            overflow: TextOverflow.ellipsis,
          ),
        ),
        buildCell(
          5,
          Text(
            itemCount > 0 ? '$itemCount 个菜品' : '—',
            style: TextStyle(
              color: itemCount > 0 ? Colors.blue : Colors.grey,
            ),
          ),
        ),
        buildCell(
          6,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => _openDetailsDialog(item),
                child: const Text('查看详情'),
              ),
              const SizedBox(width: 8),
              PermissionGate(
                required: PermissionCodes.reportDelete,
                child: TextButton(
                  onPressed: () => _deleteReportOrder(item),
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  child: const Text('删除'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static const List<AdminTableColumn> _columns = [
    AdminTableColumn(width: 60, label: 'ID', alignment: Alignment.center),
    AdminTableColumn(width: 160, label: '门店'),
    AdminTableColumn(width: 160, label: '操作员'),
    AdminTableColumn(width: 160, label: '报菜时间'),
    AdminTableColumn(label: '备注'),
    AdminTableColumn(width: 120, label: '菜品详情', alignment: Alignment.center),
    AdminTableColumn(width: 180, label: '操作', alignment: Alignment.centerRight),
  ];

}

class MenuReportOrderDetailsDialog extends StatelessWidget {
  final MenuReportOrder order;

  const MenuReportOrderDetailsDialog({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final items = order.items ?? [];

    return AlertDialog(
      title: Text('报菜记录单 #${order.id}'),
      content: SizedBox(
        width: 600,
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('门店:', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    order.store?.name ?? '—',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('操作员:', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    order.user?.nickname ?? order.user?.username ?? '—',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('报菜时间:', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    order.createdAt ?? '—',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            if (order.remark?.isNotEmpty == true) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('备注:', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      order.remark!,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 16),
            const Text('菜品明细:', style: TextStyle(fontWeight: FontWeight.w600)),
            const Divider(),
            Expanded(
              child: items.isEmpty
                  ? const Center(
                      child: Text('暂无菜品记录'),
                    )
                  : ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const Divider(height: 12),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return _buildItemRow(item);
                      },
                    ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('关闭'),
        ),
      ],
    );
  }

  Widget _buildItemRow(MenuReportItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.dish?.name ?? '未知菜品',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text('数量: ${item.quantity}'),
                if (item.remark?.isNotEmpty == true) ...[
                  const SizedBox(height: 4),
                  Text(
                    '备注: ${item.remark}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuReportManagementScope extends StatelessWidget {
  const MenuReportManagementScope({super.key});

  @override
  Widget build(BuildContext context) {
    final client = ApiClient();
    return ChangeNotifierProvider(
      create: (_) => MenuReportProvider(
        MenuReportApi(client),
        DishApi(client),
        DishCategoryApi(client),
      ),
      child: const MenuReportManagementPage(),
    );
  }
}

class MenuReportOrderFormDialog extends StatefulWidget {
  final Future<List<MenuReportOptionCategory>> Function({bool forceRefresh})
      loadOptions;

  const MenuReportOrderFormDialog({
    super.key,
    required this.loadOptions,
  });

  @override
  State<MenuReportOrderFormDialog> createState() => _MenuReportOrderFormDialogState();
}

class _MenuReportOrderFormDialogState extends State<MenuReportOrderFormDialog> {
  late Future<List<MenuReportOptionCategory>> _optionsFuture;
  final Map<int, _CartItem> _cart = {};
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _optionsFuture = widget.loadOptions();
  }

  @override
  void dispose() {
    for (final item in _cart.values) {
      item.dispose();
    }
    super.dispose();
  }

  void _retryLoad() {
    setState(() {
      _optionsFuture = widget.loadOptions(forceRefresh: true);
    });
  }

  void _addToCart(MenuReportOptionCategory option, Dish dish) {
    setState(() {
      final existing = _cart[dish.id];
      if (existing != null) {
        existing.quantity += 1;
      } else {
        _cart[dish.id] =
            _CartItem(dish: dish, category: option.category, quantity: 1);
      }
      _errorMessage = null;
    });
  }

  void _changeQuantity(int dishId, int delta) {
    final item = _cart[dishId];
    if (item == null) return;
    setState(() {
      final next = item.quantity + delta;
      if (next <= 0) {
        _removeFromCart(dishId);
      } else {
        item.quantity = next;
      }
    });
  }

  void _removeFromCart(int dishId) {
    final removed = _cart.remove(dishId);
    removed?.dispose();
    setState(() {});
  }

  void _clearCart() {
    for (final item in _cart.values) {
      item.dispose();
    }
    _cart.clear();
    setState(() {});
  }

  void _submit() {
    if (_cart.isEmpty) {
      setState(() {
        _errorMessage = '请至少选择一个菜品';
      });
      return;
    }
    final payloads = _cart.values.map((item) {
      final remark = item.remarkCtrl.text.trim();
      return CreateMenuReportItemRequest(
        dishId: item.dish.id,
        quantity: item.quantity,
        remark: remark.isEmpty ? null : remark,
      );
    }).toList();
    Navigator.pop(context, payloads);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('新增报菜'),
      content: SizedBox(
        width: 780,
        child: FutureBuilder<List<MenuReportOptionCategory>>(
          future: _optionsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 220,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            if (snapshot.hasError) {
              return SizedBox(
                height: 220,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '菜品加载失败: ${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _retryLoad,
                      icon: const Icon(Icons.refresh),
                      label: const Text('重试'),
                    ),
                  ],
                ),
              );
            }
            final options = snapshot.data ?? [];
            if (options.isEmpty) {
              return const SizedBox(
                height: 220,
                child: Center(
                  child: Text('该门店暂无可报菜品，请先维护菜品信息'),
                ),
              );
            }
            return SizedBox(
              height: 420,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildOptionList(options),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: _buildCartPanel(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('提交'),
        ),
      ],
    );
  }

  Widget _buildOptionList(List<MenuReportOptionCategory> options) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListView(
        children: options.map((option) {
          final dishes = option.dishes;
          return ExpansionTile(
            title: Text(option.category.name),
            childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
            children: dishes.isEmpty
                ? [
                    const ListTile(
                      title: Text('该分类暂无菜品'),
                    ),
                  ]
                : dishes.map((dish) {
                    final selected = _cart[dish.id]?.quantity ?? 0;
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(dish.name),
                      subtitle: dish.price != null
                          ? Text('价格：${dish.price!.toStringAsFixed(2)}')
                          : null,
                      trailing: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        children: [
                          if (selected > 0)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text('已选 $selected'),
                            ),
                          TextButton.icon(
                            onPressed: () => _addToCart(option, dish),
                            icon: const Icon(Icons.add_circle_outline),
                            label: const Text('加入'),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCartPanel() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Text(
                  '待提交',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                const Spacer(),
                if (_cart.isNotEmpty)
                  TextButton(
                    onPressed: _clearCart,
                    child: const Text('清空'),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _cart.isEmpty
                  ? const Center(
                      child: Text(
                        '购物车为空，先从左侧选择菜品',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.separated(
                      itemCount: _cart.length,
                      separatorBuilder: (_, __) => const Divider(height: 12),
                      itemBuilder: (context, index) {
                        final item = _cart.values.elementAt(index);
                        return _buildCartItem(item);
                      },
                    ),
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(_CartItem item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.dish.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.category.name,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: '减少',
              onPressed: () => _changeQuantity(item.dish.id, -1),
              icon: const Icon(Icons.remove_circle_outline),
            ),
            Text(
              item.quantity.toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            IconButton(
              tooltip: '增加',
              onPressed: () => _changeQuantity(item.dish.id, 1),
              icon: const Icon(Icons.add_circle_outline),
            ),
            IconButton(
              tooltip: '移除',
              onPressed: () => _removeFromCart(item.dish.id),
              icon: const Icon(Icons.delete_outline, color: Colors.red),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: item.remarkCtrl,
          decoration: const InputDecoration(
            isDense: true,
            labelText: '备注（可选）',
            border: OutlineInputBorder(),
          ),
          maxLines: 2,
        ),
      ],
    );
  }
}

class _CartItem {
  final Dish dish;
  final DishCategory category;
  int quantity;
  final TextEditingController remarkCtrl = TextEditingController();

  _CartItem({
    required this.dish,
    required this.category,
    this.quantity = 1,
  });

  void dispose() {
    remarkCtrl.dispose();
  }
}
