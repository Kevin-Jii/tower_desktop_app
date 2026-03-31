import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show Material;
import 'package:provider/provider.dart';
import '../dict/dict_provider.dart';
import '../supplier/supplier_provider.dart';
import '../supplier/models.dart';
import 'models.dart';
import 'store_account_provider.dart';
import 'store_account_row.dart';
class StoreAccountPage extends StatefulWidget {
  const StoreAccountPage({super.key});
  @override
  State<StoreAccountPage> createState() => _StoreAccountPageState();
}
class _StoreAccountPageState extends State<StoreAccountPage> {
  DateTime _selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }
  void _loadData() {
    final dateStr = _formatDate(_selectedDate);
    context.read<StoreAccountProvider>().loadAccounts(
      page: 1,
      pageSize: 100,
      startDate: dateStr,
      endDate: dateStr,
    );
    context.read<StoreAccountProvider>().loadStats(startDate: dateStr, endDate: dateStr);
    context.read<DictProvider>().loadAllDicts();
    context.read<SupplierProvider>().loadPurchasableProducts();
  }
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
  void _showAddDrawer() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _AccountDrawer(
        accountDate: _selectedDate,
        onSaved: () => _refreshAccounts(),
      ),
    );
  }
  void _refreshAccounts() {
    final dateStr = _formatDate(_selectedDate);
    context.read<StoreAccountProvider>().loadAccounts(
      page: 1,
      pageSize: 100,
      startDate: dateStr,
      endDate: dateStr,
    );
    context.read<StoreAccountProvider>().loadStats(startDate: dateStr, endDate: dateStr);
  }
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Container(
        color: isDark ? const Color(0xFF202020) : const Color(0xFFF5F7FA),
        child: Column(
          children: [
            _buildHeader(theme, isDark),
            _buildStatsCards(isDark),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildTableHeader(isDark),
                      const Divider(style: DividerThemeData(horizontalMargin: EdgeInsets.zero)),
                      Expanded(child: _buildTableList(isDark)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildHeader(FluentThemeData theme, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
      child: Row(
        children: [
          Text('门店记账', style: theme.typography.title),
          const SizedBox(width: 32),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[40]!),
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              children: [
                const Icon(FluentIcons.calendar, size: 14),
                const SizedBox(width: 8),
                DatePicker(
                  selected: _selectedDate,
                  onChanged: (date) {
                    setState(() => _selectedDate = date);
                    _loadData();
                  },
                ),
              ],
            ),
          ),
          const Spacer(),
          FilledButton(
            onPressed: _showAddDrawer,
            style: ButtonStyle(
              padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(FluentIcons.add, size: 16),
                SizedBox(width: 8),
                Text('新增记账', style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildStatsCards(bool isDark) {
    return Consumer<StoreAccountProvider>(
      builder: (context, provider, _) {
        final stats = provider.stats;
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
          child: Row(
            children: [
              _buildAnimatedStatCard(
                '今日销售',
                stats?.todayAmount ?? 0,
                '${stats?.todayCount ?? 0} 笔订单',
                Colors.blue,
                FluentIcons.money,
                isDark,
              ),
              const SizedBox(width: 16),
              _buildAnimatedStatCard(
                '本月销售',
                stats?.monthAmount ?? 0,
                '累计 ${stats?.totalCount ?? 0} 笔',
                Colors.orange,
                FluentIcons.line_chart,
                isDark,
              ),
              const SizedBox(width: 16),
              _buildAnimatedStatCard(
                '总销售额',
                stats?.totalAmount ?? 0,
                '按查询周期',
                Colors.green,
                FluentIcons.chart,
                isDark,
              ),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }
  Widget _buildAnimatedStatCard(String title, double amount, String subValue, Color color, IconData icon, bool isDark) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isDark ? Colors.transparent : Colors.grey[20]!),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.grey[100], fontSize: 12)),
                const SizedBox(height: 4),
                _AnimatedAmount(amount: amount),
                const SizedBox(height: 2),
                Text(subValue, style: TextStyle(color: Colors.grey[80], fontSize: 11)),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildTableHeader(bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: const [
          Expanded(flex: 2, child: Text('账单编号', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 3, child: Text('商品明细', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 1, child: Text('总金额', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 1, child: Text('渠道', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 1, child: Text('操作人', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text('创建时间', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 1, child: Center(child: Text('操作', style: TextStyle(fontWeight: FontWeight.bold)))),
        ],
      ),
    );
  }
  Widget _buildTableList(bool isDark) {
    return Consumer<StoreAccountProvider>(
      builder: (context, provider, _) {
        if (provider.loading) return const Center(child: ProgressRing());
        if (provider.accounts.isEmpty) return _buildEmptyState();
        return ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: provider.accounts.length,
          separatorBuilder: (_, __) => Divider(
            style: DividerThemeData(
              horizontalMargin: const EdgeInsets.symmetric(horizontal: 16),
              thickness: 0.5,
              decoration: BoxDecoration(color: Colors.grey[30]),
            ),
          ),
          itemBuilder: (context, index) {
            final account = provider.accounts[index];
            return _buildTableRow(account, isDark);
          },
        );
      },
    );
  }
  Widget _buildTableRow(StoreAccount account, bool isDark) {
    final itemsText = account.items.map((item) {
      return '${item.productName ?? ''} ×${item.quantity.toInt()} ¥${item.amount.toStringAsFixed(0)}';
    }).join('、');
    final accountNoShort = account.accountNo != null && account.accountNo!.length > 8
        ? '...${account.accountNo!.substring(account.accountNo!.length - 8)}'
        : account.accountNo ?? '-';
    String createdAtStr = '';
    if (account.createdAt != null) {
      final dt = DateTime.tryParse(account.createdAt!);
      if (dt != null) {
        createdAtStr = '${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
      }
    }
    final dictProvider = context.read<DictProvider>();
    final channelLabel = dictProvider.getLabelByValue('sales_channel', account.channel ?? '') ?? account.channel;
    return HoverButton(
      onPressed: () {},
      builder: (context, states) {
        return Container(
          color: states.isHovered ? (isDark ? Colors.grey[160] : Colors.blue.withOpacity(0.02)) : Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(accountNoShort, style: TextStyle(fontSize: 12, color: Colors.grey[100])),
              ),
              Expanded(
                flex: 3,
                child: Text(itemsText, style: const TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis, maxLines: 2),
              ),
              Expanded(
                flex: 1,
                child: Text('¥${account.totalAmount.toStringAsFixed(2)}', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
              ),
              Expanded(
                flex: 1,
                child: _buildTag(channelLabel, Colors.blue),
              ),
              Expanded(
                flex: 1,
                child: Text(account.operatorName ?? '-', style: TextStyle(fontSize: 12, color: Colors.grey[100])),
              ),
              Expanded(
                flex: 2,
                child: Text(createdAtStr, style: TextStyle(fontSize: 12, color: Colors.grey[100])),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(icon: Icon(FluentIcons.delete, size: 14, color: Colors.red), onPressed: () => _deleteAccount(account.id)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  Widget _buildTag(String? text, Color color, {bool isOutline = false}) {
    if (text == null || text.isEmpty) return const SizedBox();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isOutline ? Colors.transparent : color.withOpacity(0.1),
        border: Border.all(color: color.withOpacity(isOutline ? 0.5 : 0)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(text, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w600)),
    );
  }
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(FluentIcons.list, size: 48, color: Colors.grey[60]),
          const SizedBox(height: 16),
          Text('今日暂无数据', style: TextStyle(color: Colors.grey[100])),
        ],
      ),
    );
  }
  Future<void> _deleteAccount(int id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('确认删除'),
        content: const Text('确定要删除这条记账吗？此操作无法撤销。'),
        actions: [
          Button(onPressed: () => Navigator.pop(context, false), child: const Text('取消')),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.red)),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      if (!mounted) return; 
      final success = await context.read<StoreAccountProvider>().deleteAccount(id);
      if (!mounted) return; 
      if (success) {
        _refreshAccounts();
      }
    }
  }
}
class _AccountDrawer extends StatefulWidget {
  final DateTime accountDate;
  final VoidCallback onSaved;
  const _AccountDrawer({required this.accountDate, required this.onSaved});
  @override
  State<_AccountDrawer> createState() => _AccountDrawerState();
}
class _AccountDrawerState extends State<_AccountDrawer> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  final List<StoreAccountRow> _selectedItems = [];
  final Set<int> _expandedSuppliers = {};
  final Map<int, int?> _selectedCategories = {};
  String _searchKeyword = '';
  final TextEditingController _searchController = TextEditingController();
  bool _saving = false;
  String _channel = '';
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _slideAnimation = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic));
    _animationController.forward();
  }
  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }
  Future<void> _close() async {
    await _animationController.reverse();
    if (mounted) Navigator.of(context).pop();
  }
  void _toggleSupplierExpand(int id) {
    setState(() {
      if (_expandedSuppliers.contains(id)) {
        _expandedSuppliers.remove(id);
      } else {
        _expandedSuppliers.add(id);
      }
    });
  }
  void _selectCategory(int sId, int? cId) => setState(() => _selectedCategories[sId] = cId);
  void _removeItem(int index) => setState(() => _selectedItems.removeAt(index));
  void _updateItemQuantity(int index, double v) {
    setState(() {
      _selectedItems[index].quantity = v;
      _selectedItems[index].calculateAmount();
    });
  }
  void _updateItemPrice(int index, double v) {
    setState(() {
      _selectedItems[index].price = v;
      _selectedItems[index].calculateAmount();
    });
  }
  void _updateItemAmount(int index, double v) => setState(() => _selectedItems[index].amount = v);
  void _addProduct(SupplierProduct product) {
    if (_selectedItems.any((item) => item.productId == product.id)) {
      displayInfoBar(context, builder: (context, close) {
        return InfoBar(title: const Text('该商品已添加'), severity: InfoBarSeverity.warning, action: IconButton(icon: const Icon(FluentIcons.clear), onPressed: close));
      });
      return;
    }
    setState(() {
      _selectedItems.add(StoreAccountRow(
        productId: product.id,
        productName: product.name,
        spec: product.spec ?? '',
        unit: product.unit ?? '',
        price: product.price ?? 0,
        quantity: 1,
        accountDate: widget.accountDate,
      )..calculateAmount());
    });
  }
  Future<void> _save() async {
    if (_selectedItems.isEmpty) {
      displayInfoBar(context, builder: (context, close) {
        return InfoBar(title: const Text('请至少添加一个商品'), severity: InfoBarSeverity.warning, action: IconButton(icon: const Icon(FluentIcons.clear), onPressed: close));
      });
      return;
    }
    if (_channel.isEmpty) {
      displayInfoBar(context, builder: (context, close) {
        return InfoBar(title: const Text('请选择销售渠道'), severity: InfoBarSeverity.warning, action: IconButton(icon: const Icon(FluentIcons.clear), onPressed: close));
      });
      return;
    }
    setState(() => _saving = true);
    final provider = context.read<StoreAccountProvider>();
    final dateStr = '${widget.accountDate.year}-${widget.accountDate.month.toString().padLeft(2, '0')}-${widget.accountDate.day.toString().padLeft(2, '0')}';
    final success = await provider.createBatchAccounts(
      channel: _channel,
      accountDate: dateStr,
      items: _selectedItems,
    );
    if (!mounted) return; 
    setState(() => _saving = false);
    if (success) {
      widget.onSaved();
      _close();
    } else {
      displayInfoBar(context, builder: (context, close) {
        return InfoBar(title: Text(provider.error ?? '保存失败'), severity: InfoBarSeverity.error, action: IconButton(icon: const Icon(FluentIcons.clear), onPressed: close));
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    return Material(
      color: Colors.transparent,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: GestureDetector(onTap: _close, child: Container(color: Colors.black.withOpacity(0.3))),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: screenWidth > 1200 ? 900 : screenWidth * 0.85,
            child: SlideTransition(
              position: _slideAnimation,
              child: Container(
                color: isDark ? const Color(0xFF1F1F1F) : Colors.white,
                child: Column(
                  children: [
                    _buildDrawerHeader(theme, isDark),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(flex: 7, child: _buildProductSelector(isDark)),
                          Container(width: 1, color: isDark ? const Color(0xFF333333) : const Color(0xFFE5E5E5)),
                          Expanded(flex: 5, child: _buildSelectedList(isDark)),
                        ],
                      ),
                    ),
                    _buildDrawerFooter(isDark),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildDrawerHeader(FluentThemeData theme, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252525) : Colors.white,
        border: Border(bottom: BorderSide(color: isDark ? const Color(0xFF333333) : const Color(0xFFE5E5E5))),
      ),
      child: Row(
        children: [
          Text('新增记账', style: theme.typography.subtitle?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(color: Colors.grey[30], borderRadius: BorderRadius.circular(4)),
            child: Text(
              '${widget.accountDate.year}-${widget.accountDate.month.toString().padLeft(2, '0')}-${widget.accountDate.day.toString().padLeft(2, '0')}',
              style: TextStyle(color: Colors.grey[120], fontSize: 12),
            ),
          ),
          const Spacer(),
          IconButton(icon: const Icon(FluentIcons.chrome_close), onPressed: _close),
        ],
      ),
    );
  }
  Widget _buildProductSelector(bool isDark) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextBox(
            controller: _searchController,
            placeholder: '搜索商品名称...',
            prefix: const Padding(padding: EdgeInsets.only(left: 8), child: Icon(FluentIcons.search)),
            onChanged: (v) => setState(() => _searchKeyword = v),
          ),
        ),
        Expanded(
          child: Consumer<SupplierProvider>(
            builder: (context, provider, _) {
              if (provider.loading) return const Center(child: ProgressRing());
              final allProducts = provider.purchasableProducts;
              final filteredProducts = _searchKeyword.isEmpty
                  ? allProducts
                  : allProducts.where((p) => p.name.contains(_searchKeyword)).toList();
              if (_searchKeyword.isNotEmpty) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    final isAdded = _selectedItems.any((item) => item.productId == product.id);
                    return _buildProductItem(product, isAdded, isDark);
                  },
                );
              }
              final grouped = <int, _SupplierGroup>{};
              for (final product in allProducts) {
                final supplierId = product.supplierId;
                final supplierName = product.supplier?.name ?? '未知供应商';
                grouped.putIfAbsent(supplierId, () => _SupplierGroup(id: supplierId, name: supplierName, categories: {}, products: []));
                grouped[supplierId]!.products.add(product);
                final categoryId = product.categoryId;
                final categoryName = product.category?.name ?? '未分类';
                grouped[supplierId]!.categories.putIfAbsent(categoryId, () => _CategoryGroup(id: categoryId, name: categoryName, products: []));
                grouped[supplierId]!.categories[categoryId]!.products.add(product);
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: grouped.length,
                itemBuilder: (context, index) {
                  final supplier = grouped.values.elementAt(index);
                  return _buildSupplierPanel(supplier, isDark);
                },
              );
            },
          ),
        ),
      ],
    );
  }
  Widget _buildSupplierPanel(_SupplierGroup supplier, bool isDark) {
    final isExpanded = _expandedSuppliers.contains(supplier.id);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isExpanded ? Colors.blue.withOpacity(0.3) : Colors.grey[30]!),
      ),
      child: Column(
        children: [
          HoverButton(
            onPressed: () => _toggleSupplierExpand(supplier.id),
            builder: (context, states) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: states.isHovered ? (isDark ? const Color(0xFF3D3D3D) : const Color(0xFFF5F5F5)) : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(isExpanded ? FluentIcons.chevron_down : FluentIcons.chevron_right, size: 12, color: Colors.grey[120]),
                    const SizedBox(width: 8),
                    Expanded(child: Text(supplier.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
                    Text('${supplier.products.length}个商品', style: TextStyle(fontSize: 12, color: Colors.grey[120])),
                  ],
                ),
              );
            },
          ),
          if (isExpanded)
            Container(
              height: 200,
              decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey[40]!))),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF252525) : const Color(0xFFFAFAFA),
                      border: Border(right: BorderSide(color: Colors.grey[40]!)),
                    ),
                    child: _buildCategoryList(supplier, isDark),
                  ),
                  Expanded(child: _buildCategoryProducts(supplier, isDark)),
                ],
              ),
            ),
        ],
      ),
    );
  }
  Widget _buildCategoryList(_SupplierGroup supplier, bool isDark) {
    final selectedCategoryId = _selectedCategories[supplier.id];
    final categories = supplier.categories.values.toList();
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 4),
      children: [
        _buildCategoryItem(supplier.id, null, '全部', supplier.products.length, selectedCategoryId == null, isDark),
        ...categories.map((cat) => _buildCategoryItem(supplier.id, cat.id, cat.name, cat.products.length, selectedCategoryId == cat.id, isDark)),
      ],
    );
  }
  Widget _buildCategoryItem(int supplierId, int? categoryId, String name, int count, bool isSelected, bool isDark) {
    return HoverButton(
      onPressed: () => _selectCategory(supplierId, categoryId),
      builder: (context, states) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue.withOpacity(0.1) : (states.isHovered ? Colors.grey[30] : Colors.transparent),
            borderRadius: BorderRadius.circular(4),
            border: Border(left: BorderSide(color: isSelected ? Colors.blue : Colors.transparent, width: 3)),
          ),
          child: Text(name, style: TextStyle(fontSize: 11, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal, color: isSelected ? Colors.blue : null), overflow: TextOverflow.ellipsis),
        );
      },
    );
  }
  Widget _buildCategoryProducts(_SupplierGroup supplier, bool isDark) {
    final selectedCategoryId = _selectedCategories[supplier.id];
    final products = selectedCategoryId == null ? supplier.products : (supplier.categories[selectedCategoryId]?.products ?? []);
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        final isAdded = _selectedItems.any((item) => item.productId == product.id);
        return _buildProductItem(product, isAdded, isDark);
      },
    );
  }
  Widget _buildProductItem(SupplierProduct product, bool isAdded, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: HoverButton(
        onPressed: isAdded ? null : () => _addProduct(product),
        builder: (context, states) {
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isAdded ? Colors.green.withOpacity(0.05) : (states.isHovered ? Colors.grey[30] : Colors.white),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: isAdded ? Colors.green.withOpacity(0.3) : Colors.grey[30]!),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 2),
                      Text('${product.supplier?.name ?? ''} | ${product.category?.name ?? ''}', style: TextStyle(fontSize: 10, color: Colors.grey[100])),
                    ],
                  ),
                ),
                Text('¥${product.price}', style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 12),
                Icon(isAdded ? FluentIcons.check_mark : FluentIcons.add, size: 16, color: isAdded ? Colors.green : Colors.blue),
              ],
            ),
          );
        },
      ),
    );
  }
  Widget _buildSelectedList(bool isDark) {
    return Container(
      color: isDark ? const Color(0xFF2D2D2D) : const Color(0xFFF7F9FC),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF333333) : Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey[30]!)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('已选 (${_selectedItems.length})', style: const TextStyle(fontWeight: FontWeight.bold)),
                    const Spacer(),
                    if (_selectedItems.isNotEmpty)
                      Button(onPressed: () => setState(() => _selectedItems.clear()), child: const Text('清空', style: TextStyle(fontSize: 12))),
                  ],
                ),
                const SizedBox(height: 12),
                Consumer<DictProvider>(
                  builder: (context, provider, _) {
                    final channels = provider.getDictByCode('sales_channel');
                    return ComboBox<String>(
                      value: _channel.isEmpty ? null : _channel,
                      placeholder: Text('选择销售渠道 *', style: TextStyle(fontSize: 12)),
                      isExpanded: true,
                      items: channels.map((d) => ComboBoxItem(value: d.value, child: Text(d.label))).toList(),
                      onChanged: (v) => setState(() => _channel = v ?? ''),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: _selectedItems.isEmpty
                ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(FluentIcons.shopping_cart, size: 48, color: Colors.grey[80]), SizedBox(height: 16), Text('请从左侧选择商品', style: TextStyle(color: Colors.grey[100]))]))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _selectedItems.length,
                    itemBuilder: (context, index) => _buildSelectedItem(index, _selectedItems[index], isDark),
                  ),
          ),
        ],
      ),
    );
  }
  Widget _buildSelectedItem(int index, StoreAccountRow item, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF333333) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.productName, style: const TextStyle(fontWeight: FontWeight.bold)),
                    if (item.spec.isNotEmpty) Text('${item.spec} ${item.unit}', style: TextStyle(fontSize: 11, color: Colors.grey[100])),
                  ],
                ),
              ),
              IconButton(icon: Icon(FluentIcons.delete, size: 12, color: Colors.red), onPressed: () => _removeItem(index)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('数量', style: TextStyle(fontSize: 10, color: Colors.grey[100])),
                  SizedBox(
                    width: 70,
                    child: NumberBox<double>(
                      value: item.quantity,
                      onChanged: (v) => _updateItemQuantity(index, v ?? 1),
                      mode: SpinButtonPlacementMode.none,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              const Text('×'),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('单价', style: TextStyle(fontSize: 10, color: Colors.grey[100])),
                  SizedBox(
                    width: 80,
                    child: NumberBox<double>(
                      value: item.price,
                      onChanged: (v) => _updateItemPrice(index, v ?? 0),
                      mode: SpinButtonPlacementMode.none,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              const Text('='),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('金额', style: TextStyle(fontSize: 10, color: Colors.grey[100])),
                  Text('¥${item.amount.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 16)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildDrawerFooter(bool isDark) {
    final total = _selectedItems.fold<double>(0, (sum, item) => sum + item.amount);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252525) : Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[30]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('总计金额', style: TextStyle(fontSize: 12, color: Colors.grey[100])),
              Text('¥${total.toStringAsFixed(2)}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
            ],
          ),
          Row(
            children: [
              Button(onPressed: _saving ? null : _close, child: const Text('取消')),
              const SizedBox(width: 12),
              FilledButton(
                onPressed: _saving ? null : _save,
                style: ButtonStyle(padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 32, vertical: 10))),
                child: _saving ? const SizedBox(width: 16, height: 16, child: ProgressRing(strokeWidth: 2)) : const Text('确认保存'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class _SupplierGroup {
  final int id;
  final String name;
  final Map<int, _CategoryGroup> categories;
  final List<SupplierProduct> products;
  _SupplierGroup({required this.id, required this.name, required this.categories, required this.products});
}
class _CategoryGroup {
  final int id;
  final String name;
  final List<SupplierProduct> products;
  _CategoryGroup({required this.id, required this.name, required this.products});
}
class _AnimatedAmount extends StatefulWidget {
  final double amount;
  const _AnimatedAmount({required this.amount});
  @override
  State<_AnimatedAmount> createState() => _AnimatedAmountState();
}
class _AnimatedAmountState extends State<_AnimatedAmount> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _oldAmount = 0;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: widget.amount).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _controller.forward();
  }
  @override
  void didUpdateWidget(_AnimatedAmount oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.amount != widget.amount) {
      _oldAmount = oldWidget.amount;
      _animation = Tween<double>(begin: _oldAmount, end: widget.amount).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
      );
      _controller.forward(from: 0);
    }
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          '¥${_animation.value.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        );
      },
    );
  }
}
