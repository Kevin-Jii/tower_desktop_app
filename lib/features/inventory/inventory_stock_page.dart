import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'inventory_provider.dart';
import 'models.dart';
import '../supplier/supplier_provider.dart';
import '../supplier/models.dart';
class InventoryStockPage extends StatefulWidget {
  final int type; 
  const InventoryStockPage({super.key, required this.type});
  @override
  State<InventoryStockPage> createState() => _InventoryStockPageState();
}
class _InventoryStockPageState extends State<InventoryStockPage> {
  final Map<int, _SelectedProduct> _selectedProducts = {};
  String _keyword = '';
  final _searchController = TextEditingController();
  final Set<int> _expandedSuppliers = {};
  final Map<int, int?> _selectedCategories = {};
  bool _submitting = false;
  final Map<int, TextEditingController> _reasonControllers = {};
  TextEditingController _reasonCtrlFor(int productId, String initialReason) {
    return _reasonControllers.putIfAbsent(
      productId,
      () => TextEditingController(text: initialReason),
    );
  }
  void _removeProduct(int productId) {
    _reasonControllers.remove(productId)?.dispose();
    setState(() => _selectedProducts.remove(productId));
  }
  bool get isStockIn => widget.type == InventoryRecordType.stockIn;
  Color get typeColor => isStockIn ? Colors.green : Colors.orange;
  String get typeLabel => isStockIn ? '入库' : '出库';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProducts();
      if (!isStockIn) {
        context.read<InventoryProvider>().loadInventories();
      }
    });
  }
  @override
  void dispose() {
    _searchController.dispose();
    for (final ctrl in _reasonControllers.values) {
      ctrl.dispose();
    }
    super.dispose();
  }
  void _loadProducts() {
    context.read<SupplierProvider>().loadPurchasableProducts(keyword: _keyword.isEmpty ? null : _keyword);
  }
  double _getStockQuantity(int productId) {
    final inventories = context.read<InventoryProvider>().inventories;
    final inventory = inventories.where((i) => i.productId == productId).firstOrNull;
    return inventory?.quantity ?? 0;
  }
  bool _hasStock(int productId) {
    return _getStockQuantity(productId) > 0;
  }
  void _handleSearch() {
    _keyword = _searchController.text.trim();
    _loadProducts();
  }
  void _toggleProduct(SupplierProduct product) {
    setState(() {
      if (_selectedProducts.containsKey(product.id)) {
        _selectedProducts.remove(product.id);
      } else {
        if (!isStockIn && !_hasStock(product.id)) {
          displayInfoBar(context, builder: (context, close) {
            return InfoBar(
              title: Text('${product.name} 库存不足，无法出库'),
              severity: InfoBarSeverity.warning,
              action: IconButton(icon: const Icon(FluentIcons.clear), onPressed: close),
            );
          });
          return;
        }
        _selectedProducts[product.id] = _SelectedProduct(
          product: product,
          quantity: 1,
          reason: isStockIn ? '采购入库' : '销售出库',
          maxQuantity: isStockIn ? null : _getStockQuantity(product.id),
        );
      }
    });
  }
  void _updateQuantity(int productId, double quantity) {
    if (_selectedProducts.containsKey(productId)) {
      final item = _selectedProducts[productId]!;
      if (!isStockIn && item.maxQuantity != null && quantity > item.maxQuantity!) {
        displayInfoBar(context, builder: (context, close) {
          return InfoBar(
            title: Text('${item.product.name} 出库数量不能超过库存 ${item.maxQuantity}'),
            severity: InfoBarSeverity.warning,
            action: IconButton(icon: const Icon(FluentIcons.clear), onPressed: close),
          );
        });
        quantity = item.maxQuantity!;
      }
      setState(() {
        _selectedProducts[productId] = item.copyWith(quantity: quantity);
      });
    }
  }
  void _updateReason(int productId, String reason) {
    if (_selectedProducts.containsKey(productId)) {
      setState(() {
        _selectedProducts[productId] = _selectedProducts[productId]!.copyWith(reason: reason);
      });
    }
  }
  void _updateProductionDate(int productId, DateTime? date) {
    if (_selectedProducts.containsKey(productId)) {
      setState(() {
        _selectedProducts[productId] = _selectedProducts[productId]!.copyWith(
          productionDate: date,
          clearProductionDate: date == null,
        );
      });
    }
  }
  void _updateExpiryDate(int productId, DateTime? date) {
    if (_selectedProducts.containsKey(productId)) {
      setState(() {
        _selectedProducts[productId] = _selectedProducts[productId]!.copyWith(
          expiryDate: date,
          clearExpiryDate: date == null,
        );
      });
    }
  }
  Future<void> _submit() async {
    if (_submitting) return;
    if (_selectedProducts.isEmpty) {
      displayInfoBar(context, builder: (context, close) {
        return InfoBar(
          title: const Text('请至少选择一个商品'),
          severity: InfoBarSeverity.warning,
          action: IconButton(icon: const Icon(FluentIcons.clear), onPressed: close),
        );
      });
      return;
    }
    final insufficientItems = <_SelectedProduct>[];
    for (final entry in _selectedProducts.entries) {
      final item = entry.value;
      if (item.quantity <= 0) {
        displayInfoBar(context, builder: (context, close) {
          return InfoBar(
            title: Text('${item.product.name} 的数量必须大于0'),
            severity: InfoBarSeverity.warning,
            action: IconButton(icon: const Icon(FluentIcons.clear), onPressed: close),
          );
        });
        return;
      }
      if (item.reason.isEmpty) {
        displayInfoBar(context, builder: (context, close) {
          return InfoBar(
            title: Text('${item.product.name} 的原因不能为空'),
            severity: InfoBarSeverity.warning,
            action: IconButton(icon: const Icon(FluentIcons.clear), onPressed: close),
          );
        });
        return;
      }
      if (!isStockIn && item.maxQuantity != null && item.quantity > item.maxQuantity!) {
        insufficientItems.add(item);
      }
    }
    if (insufficientItems.isNotEmpty) {
      displayInfoBar(context, builder: (context, close) {
        return InfoBar(
          title: Text('${insufficientItems.map((i) => i.product.name).join("、")} 库存不足，请调整数量'),
          severity: InfoBarSeverity.error,
          action: IconButton(icon: const Icon(FluentIcons.clear), onPressed: close),
        );
      });
      return;
    }
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => _buildConfirmDialog(),
    );
    if (!mounted) return; 
    if (confirmed != true) return;
    setState(() => _submitting = true);
    final items = _selectedProducts.values.map((item) {
      return CreateInventoryOrderItem(
        productId: item.product.id,
        quantity: item.quantity,
        productionDate: item.productionDate != null
            ? '${item.productionDate!.year}-${item.productionDate!.month.toString().padLeft(2, '0')}-${item.productionDate!.day.toString().padLeft(2, '0')}'
            : null,
        expiryDate: item.expiryDate != null
            ? '${item.expiryDate!.year}-${item.expiryDate!.month.toString().padLeft(2, '0')}-${item.expiryDate!.day.toString().padLeft(2, '0')}'
            : null,
        remark: null,
      );
    }).toList();
    final reason = _selectedProducts.values.first.reason;
    final request = CreateInventoryOrderRequest(
      type: widget.type,
      reason: reason,
      remark: null,
      items: items,
    );
    final provider = context.read<InventoryProvider>();
    final success = await provider.createOrder(request);
    if (mounted) {
      setState(() => _submitting = false);
    }
    if (mounted) {
      if (success) {
        displayInfoBar(context, builder: (context, close) {
          return InfoBar(
            title: Text('$typeLabel成功，共 ${items.length} 项商品'),
            severity: InfoBarSeverity.success,
            action: IconButton(icon: const Icon(FluentIcons.clear), onPressed: close),
          );
        });
        Navigator.of(context).pop(true);
      } else {
        displayInfoBar(context, builder: (context, close) {
          return InfoBar(
            title: Text('$typeLabel失败，请重试'),
            severity: InfoBarSeverity.error,
            action: IconButton(icon: const Icon(FluentIcons.clear), onPressed: close),
          );
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final dividerColor = isDark ? const Color(0xFF333333) : const Color(0xFFE5E5E5);
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Column(
        children: [
          _buildHeader(theme, isDark, dividerColor),
          Expanded(
            child: Row(
              children: [
                Expanded(flex: 3, child: _buildProductList()),
                Container(width: 1, color: dividerColor),
                Expanded(flex: 2, child: _buildSelectedList()),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildHeader(FluentThemeData theme, bool isDark, Color dividerColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
        border: Border(bottom: BorderSide(color: dividerColor)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(FluentIcons.back, size: 14),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: typeColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isStockIn ? FluentIcons.add : FluentIcons.remove,
              size: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '商品$typeLabel',
                style: theme.typography.subtitle?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                '选择商品并填写数量后确认$typeLabel',
                style: theme.typography.caption?.copyWith(color: Colors.grey[100]),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: 220,
            child: TextBox(
              controller: _searchController,
              placeholder: '搜索商品名称',
              prefix: const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(FluentIcons.search, size: 14),
              ),
              onSubmitted: (_) => _handleSearch(),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildProductList() {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1F1F1F) : const Color(0xFFF5F7FA);
    return Container(
      color: bgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF252525) : Colors.white,
              border: Border(bottom: BorderSide(color: isDark ? const Color(0xFF333333) : const Color(0xFFE5E5E5))),
            ),
            child: Row(
              children: [
                Icon(FluentIcons.product_list, size: 16, color: typeColor),
                const SizedBox(width: 8),
                Text('可选商品', style: theme.typography.bodyStrong),
                const Spacer(),
                Consumer<SupplierProvider>(
                  builder: (_, p, __) => Text(
                    '${p.purchasableProducts.length} 个',
                    style: TextStyle(fontSize: 12, color: Colors.grey[100]),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<SupplierProvider>(
              builder: (context, provider, _) {
                if (provider.loading) {
                  return const Center(child: ProgressRing());
                }
                if (provider.purchasableProducts.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(FluentIcons.product_list, size: 48, color: Colors.grey[80]),
                        const SizedBox(height: 12),
                        Text('暂无可选商品', style: TextStyle(color: Colors.grey[120])),
                        const SizedBox(height: 4),
                        Text('请先在供应商管理中绑定商品', style: TextStyle(fontSize: 11, color: Colors.grey[100])),
                      ],
                    ),
                  );
                }
                final grouped = <int, _SupplierGroup>{};
                for (final product in provider.purchasableProducts) {
                  final supplierId = product.supplierId;
                  final supplierName = product.supplier?.name ?? '未知供应商';
                  grouped.putIfAbsent(supplierId, () => _SupplierGroup(
                    id: supplierId,
                    name: supplierName,
                    categories: {},
                    products: [],
                  ));
                  grouped[supplierId]!.products.add(product);
                  final categoryId = product.categoryId;
                  final categoryName = product.category?.name ?? '未分类';
                  grouped[supplierId]!.categories.putIfAbsent(categoryId, () => _CategoryGroup(
                    id: categoryId,
                    name: categoryName,
                    products: [],
                  ));
                  grouped[supplierId]!.categories[categoryId]!.products.add(product);
                }
                final suppliers = grouped.values.toList();
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: suppliers.length,
                  itemBuilder: (context, index) {
                    return _buildSupplierPanel(suppliers[index], isDark);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  void _toggleSupplierExpand(int supplierId) {
    setState(() {
      if (_expandedSuppliers.contains(supplierId)) {
        _expandedSuppliers.remove(supplierId);
      } else {
        _expandedSuppliers.add(supplierId);
      }
    });
  }
  void _toggleSupplierProducts(_SupplierGroup supplier) {
    setState(() {
      final allSelected = supplier.products.every((p) => _selectedProducts.containsKey(p.id));
      if (allSelected) {
        for (final product in supplier.products) {
          _selectedProducts.remove(product.id);
        }
      } else {
        for (final product in supplier.products) {
          if (!_selectedProducts.containsKey(product.id)) {
            _selectedProducts[product.id] = _SelectedProduct(
              product: product,
              quantity: 1,
              reason: isStockIn ? '采购入库' : '销售出库',
            );
          }
        }
      }
    });
  }
  void _selectCategory(int supplierId, int? categoryId) {
    setState(() {
      _selectedCategories[supplierId] = categoryId;
    });
  }
  Widget _buildSupplierPanel(_SupplierGroup supplier, bool isDark) {
    final isExpanded = _expandedSuppliers.contains(supplier.id);
    final selectedCount = supplier.products.where((p) => _selectedProducts.containsKey(p.id)).length;
    final allSelected = selectedCount == supplier.products.length && supplier.products.isNotEmpty;
    final someSelected = selectedCount > 0 && !allSelected;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isExpanded ? typeColor.withOpacity(0.3) : Colors.transparent,
        ),
      ),
      child: Column(
        children: [
          HoverButton(
            onPressed: () => _toggleSupplierExpand(supplier.id),
            builder: (context, states) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: states.isHovered
                      ? (isDark ? const Color(0xFF3D3D3D) : const Color(0xFFF5F5F5))
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      isExpanded ? FluentIcons.chevron_down : FluentIcons.chevron_right,
                      size: 12,
                      color: Colors.grey[120],
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _toggleSupplierProducts(supplier),
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: allSelected ? typeColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: allSelected || someSelected ? typeColor : Colors.grey[100]!,
                            width: 1.5,
                          ),
                        ),
                        child: allSelected
                            ? const Icon(FluentIcons.check_mark, size: 12, color: Colors.white)
                            : someSelected
                                ? Icon(FluentIcons.remove, size: 12, color: typeColor)
                                : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        supplier.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : const Color(0xFF333333),
                        ),
                      ),
                    ),
                    if (selectedCount > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: typeColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '$selectedCount/${supplier.products.length}',
                          style: TextStyle(fontSize: 11, color: typeColor, fontWeight: FontWeight.w600),
                        ),
                      )
                    else
                      Text(
                        '${supplier.products.length}个商品',
                        style: TextStyle(fontSize: 12, color: Colors.grey[120]),
                      ),
                  ],
                ),
              );
            },
          ),
          if (isExpanded)
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[40]!)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 120,
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF252525) : const Color(0xFFFAFAFA),
                      border: Border(right: BorderSide(color: Colors.grey[40]!)),
                    ),
                    child: _buildCategoryList(supplier, isDark),
                  ),
                  Expanded(
                    child: _buildCategoryProducts(supplier, isDark),
                  ),
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
        _buildCategoryItem(
          supplier.id,
          null,
          '全部',
          supplier.products.length,
          selectedCategoryId == null,
          isDark,
        ),
        ...categories.map((cat) => _buildCategoryItem(
          supplier.id,
          cat.id,
          cat.name,
          cat.products.length,
          selectedCategoryId == cat.id,
          isDark,
        )),
      ],
    );
  }
  Widget _buildCategoryItem(int supplierId, int? categoryId, String name, int count, bool isSelected, bool isDark) {
    return HoverButton(
      onPressed: () => _selectCategory(supplierId, categoryId),
      builder: (context, states) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            color: isSelected
                ? typeColor.withOpacity(0.1)
                : (states.isHovered ? (isDark ? const Color(0xFF3D3D3D) : const Color(0xFFF0F0F0)) : Colors.transparent),
            borderRadius: BorderRadius.circular(4),
            border: Border(
              left: BorderSide(
                color: isSelected ? typeColor : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? typeColor : (isDark ? Colors.white : const Color(0xFF333333)),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '$count',
                style: TextStyle(fontSize: 11, color: Colors.grey[120]),
              ),
            ],
          ),
        );
      },
    );
  }
  Widget _buildCategoryProducts(_SupplierGroup supplier, bool isDark) {
    final selectedCategoryId = _selectedCategories[supplier.id];
    List<SupplierProduct> products;
    if (selectedCategoryId == null) {
      products = supplier.products;
    } else {
      products = supplier.categories[selectedCategoryId]?.products ?? [];
    }
    if (products.isEmpty) {
      return Center(
        child: Text('暂无商品', style: TextStyle(color: Colors.grey[120], fontSize: 12)),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        final isSelected = _selectedProducts.containsKey(product.id);
        return _buildProductItem(product, isSelected, isDark);
      },
    );
  }
  Widget _buildProductItem(SupplierProduct product, bool isSelected, bool isDark) {
    final stockQty = isStockIn ? null : _getStockQuantity(product.id);
    final hasStock = isStockIn || (stockQty != null && stockQty > 0);
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: HoverButton(
        onPressed: hasStock ? () => _toggleProduct(product) : null,
        builder: (context, states) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: !hasStock
                  ? (isDark ? const Color(0xFF252525) : const Color(0xFFF5F5F5))
                  : isSelected
                      ? typeColor.withOpacity(0.1)
                      : (states.isHovered
                          ? (isDark ? const Color(0xFF3D3D3D) : const Color(0xFFF0F0F0))
                          : Colors.transparent),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: isSelected ? typeColor : Colors.transparent,
                width: isSelected ? 1 : 0,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: isSelected ? typeColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                      color: !hasStock
                          ? Colors.grey[60]!
                          : isSelected
                              ? typeColor
                              : Colors.grey[100]!,
                      width: 1.5,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(FluentIcons.check_mark, size: 10, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 12,
                      color: !hasStock
                          ? Colors.grey[100]
                          : (isDark ? Colors.white : const Color(0xFF333333)),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (!isStockIn && stockQty != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: stockQty > 0
                          ? Colors.green.withOpacity(0.1)
                          : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      stockQty > 0 ? '库存:${stockQty.toStringAsFixed(stockQty == stockQty.truncate() ? 0 : 1)}' : '无库存',
                      style: TextStyle(
                        fontSize: 10,
                        color: stockQty > 0 ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                ],
                if (product.unit != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      product.unit!,
                      style: TextStyle(fontSize: 10, color: Colors.blue),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
  Widget _buildSelectedList() {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final dividerColor = isDark ? const Color(0xFF333333) : const Color(0xFFE5E5E5);
    return Container(
      color: isDark ? const Color(0xFF252525) : Colors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
              border: Border(bottom: BorderSide(color: dividerColor)),
            ),
            child: Row(
              children: [
                Icon(FluentIcons.shopping_cart, size: 16, color: typeColor),
                const SizedBox(width: 8),
                Text('已选商品', style: theme.typography.bodyStrong),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: typeColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${_selectedProducts.length} 项',
                    style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _selectedProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(FluentIcons.shopping_cart, size: 48, color: Colors.grey[80]),
                        const SizedBox(height: 16),
                        Text('请从左侧选择商品', style: TextStyle(color: Colors.grey[120])),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _selectedProducts.length,
                    itemBuilder: (context, index) {
                      final entry = _selectedProducts.entries.elementAt(index);
                      return _buildSelectedItem(entry.key, entry.value, isDark);
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
              border: Border(top: BorderSide(color: dividerColor)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                if (_selectedProducts.isNotEmpty && !_submitting)
                  Button(
                    onPressed: () => setState(() => _selectedProducts.clear()),
                    child: const Text('清空'),
                  ),
                const Spacer(),
                Button(
                  onPressed: _submitting ? null : () => Navigator.of(context).pop(),
                  child: const Text('取消'),
                ),
                const SizedBox(width: 10),
                FilledButton(
                  onPressed: (_selectedProducts.isEmpty || _submitting) ? null : _submit,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(typeColor),
                    padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 8)),
                  ),
                  child: _submitting
                      ? const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 14, height: 14, child: ProgressRing(strokeWidth: 2)),
                            SizedBox(width: 8),
                            Text('提交中...'),
                          ],
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(isStockIn ? FluentIcons.add : FluentIcons.remove, size: 14),
                            const SizedBox(width: 6),
                            Text('确认$typeLabel'),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildSelectedItem(int productId, _SelectedProduct item, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1F1F1F) : const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: typeColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(item.product.name, style: const TextStyle(fontWeight: FontWeight.w600)),
              ),
              IconButton(
                icon: Icon(FluentIcons.delete, size: 14, color: Colors.red),
                onPressed: () => setState(() => _selectedProducts.remove(productId)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text('数量：', style: TextStyle(fontSize: 13)),
              const SizedBox(width: 8),
              SizedBox(
                width: 200,
                child: NumberBox<double>(
                  value: item.quantity,
                  onChanged: (v) => _updateQuantity(productId, v ?? 0),
                  min: 0.01,
                  smallChange: 1,
                  mode: SpinButtonPlacementMode.inline,
                ),
              ),
              const SizedBox(width: 8),
              Text(item.product.unit ?? '', style: TextStyle(fontSize: 13, color: Colors.grey[120])),
            ],
          ),
          if (isStockIn) ...[
            const SizedBox(height: 12),
            _buildDateField(
              label: '生产日期',
              date: item.productionDate,
              onChanged: (date) => _updateProductionDate(productId, date),
              isDark: isDark,
            ),
            const SizedBox(height: 8),
            _buildDateField(
              label: '保质期',
              date: item.expiryDate,
              onChanged: (date) => _updateExpiryDate(productId, date),
              isDark: isDark,
            ),
          ],
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 6),
                child: Text('原因：', style: TextStyle(fontSize: 13)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextBox(
                  placeholder: isStockIn ? '如：采购入库' : '如：销售出库',
                  controller: _reasonCtrlFor(productId, item.reason),
                  onChanged: (v) => _updateReason(productId, v),
                  maxLength: 100,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildDateField({
    required String label,
    required DateTime? date,
    required ValueChanged<DateTime?> onChanged,
    required bool isDark,
  }) {
    final displayText = date != null
        ? '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}'
        : '点击选择日期';
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: Text('$label：', style: const TextStyle(fontSize: 13)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: HoverButton(
            onPressed: () async {
              final picked = await showDialog<DateTime>(
                context: context,
                builder: (context) => _DatePickerDialog(
                  initialDate: date ?? DateTime.now(),
                  title: '选择$label',
                ),
              );
              if (picked != null) {
                onChanged(picked);
              }
            },
            builder: (context, states) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: states.isHovered ? typeColor : Colors.grey[80]!,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        displayText,
                        style: TextStyle(
                          fontSize: 14,
                          color: date != null
                              ? (isDark ? Colors.white : const Color(0xFF333333))
                              : Colors.grey[100],
                        ),
                      ),
                    ),
                    Icon(FluentIcons.calendar, size: 16, color: Colors.grey[120]),
                  ],
                ),
              );
            },
          ),
        ),
        if (date != null) ...[
          const SizedBox(width: 4),
          IconButton(
            icon: Icon(FluentIcons.clear, size: 12, color: Colors.grey[100]),
            onPressed: () => onChanged(null),
          ),
        ],
      ],
    );
  }
  Widget _buildConfirmDialog() {
    final hasInsufficientStock = !isStockIn && _selectedProducts.values.any(
      (item) => item.maxQuantity != null && item.quantity > item.maxQuantity!,
    );
    return ContentDialog(
      title: Row(
        children: [
          Icon(isStockIn ? FluentIcons.add : FluentIcons.remove, color: typeColor),
          const SizedBox(width: 8),
          Text('确认$typeLabel'),
        ],
      ),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('即将$typeLabel以下 ${_selectedProducts.length} 项商品：'),
            const SizedBox(height: 16),
            Container(
              constraints: const BoxConstraints(maxHeight: 300),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _selectedProducts.length,
                itemBuilder: (context, index) {
                  final item = _selectedProducts.values.elementAt(index);
                  final isInsufficient = !isStockIn && 
                      item.maxQuantity != null && 
                      item.quantity > item.maxQuantity!;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Icon(
                          isInsufficient ? FluentIcons.warning : FluentIcons.product,
                          size: 14,
                          color: isInsufficient ? Colors.red : typeColor,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.product.name),
                              if (isInsufficient)
                                Text(
                                  '库存不足！当前库存: ${item.maxQuantity?.toStringAsFixed(item.maxQuantity == item.maxQuantity?.truncate() ? 0 : 1)}',
                                  style: TextStyle(fontSize: 11, color: Colors.red),
                                ),
                            ],
                          ),
                        ),
                        Text(
                          '${isStockIn ? '+' : '-'}${item.quantity.toStringAsFixed(item.quantity == item.quantity.truncate() ? 0 : 1)} ${item.product.unit ?? ''}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isInsufficient ? Colors.red : typeColor,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            if (hasInsufficientStock) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.red.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(FluentIcons.error_badge, size: 16, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '部分商品库存不足，请返回调整数量后再提交',
                        style: TextStyle(fontSize: 12, color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        Button(onPressed: () => Navigator.of(context).pop(false), child: const Text('取消')),
        FilledButton(
          onPressed: hasInsufficientStock ? null : () => Navigator.of(context).pop(true),
          style: ButtonStyle(backgroundColor: WidgetStateProperty.all(typeColor)),
          child: Text('确认$typeLabel'),
        ),
      ],
    );
  }
}
class _SelectedProduct {
  final SupplierProduct product;
  final double quantity;
  final String reason;
  final DateTime? productionDate;
  final DateTime? expiryDate;
  final double? maxQuantity; 
  _SelectedProduct({
    required this.product,
    required this.quantity,
    required this.reason,
    this.productionDate,
    this.expiryDate,
    this.maxQuantity,
  });
  _SelectedProduct copyWith({
    SupplierProduct? product,
    double? quantity,
    String? reason,
    DateTime? productionDate,
    DateTime? expiryDate,
    double? maxQuantity,
    bool clearProductionDate = false,
    bool clearExpiryDate = false,
  }) {
    return _SelectedProduct(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      reason: reason ?? this.reason,
      productionDate: clearProductionDate ? null : (productionDate ?? this.productionDate),
      expiryDate: clearExpiryDate ? null : (expiryDate ?? this.expiryDate),
      maxQuantity: maxQuantity ?? this.maxQuantity,
    );
  }
}
class _SupplierGroup {
  final int id;
  final String name;
  final Map<int, _CategoryGroup> categories;
  final List<SupplierProduct> products;
  _SupplierGroup({
    required this.id,
    required this.name,
    required this.categories,
    required this.products,
  });
}
class _CategoryGroup {
  final int id;
  final String name;
  final List<SupplierProduct> products;
  _CategoryGroup({
    required this.id,
    required this.name,
    required this.products,
  });
}
class _DatePickerDialog extends StatefulWidget {
  final DateTime initialDate;
  final String title;
  const _DatePickerDialog({
    required this.initialDate,
    required this.title,
  });
  @override
  State<_DatePickerDialog> createState() => _DatePickerDialogState();
}
class _DatePickerDialogState extends State<_DatePickerDialog> {
  late DateTime _selectedDate;
  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return ContentDialog(
      title: Text(widget.title),
      content: SizedBox(
        width: 320,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(FluentIcons.chevron_left),
                  onPressed: () {
                    setState(() {
                      _selectedDate = DateTime(
                        _selectedDate.year,
                        _selectedDate.month - 1,
                        _selectedDate.day,
                      );
                    });
                  },
                ),
                const SizedBox(width: 8),
                Text(
                  '${_selectedDate.year}年${_selectedDate.month}月',
                  style: theme.typography.subtitle,
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(FluentIcons.chevron_right),
                  onPressed: () {
                    setState(() {
                      _selectedDate = DateTime(
                        _selectedDate.year,
                        _selectedDate.month + 1,
                        _selectedDate.day,
                      );
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: ['日', '一', '二', '三', '四', '五', '六']
                  .map((d) => Expanded(
                        child: Center(
                          child: Text(d, style: TextStyle(fontSize: 12, color: Colors.grey[120])),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 8),
            _buildCalendarGrid(),
          ],
        ),
      ),
      actions: [
        Button(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_selectedDate),
          child: const Text('确定'),
        ),
      ],
    );
  }
  Widget _buildCalendarGrid() {
    final firstDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
    final lastDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month + 1, 0);
    final startWeekday = firstDayOfMonth.weekday % 7;
    final daysInMonth = lastDayOfMonth.day;
    final today = DateTime.now();
    final isToday = (DateTime d) => d.year == today.year && d.month == today.month && d.day == today.day;
    final isSelected = (DateTime d) => d.year == _selectedDate.year && d.month == _selectedDate.month && d.day == _selectedDate.day;
    List<Widget> rows = [];
    List<Widget> currentRow = [];
    for (int i = 0; i < startWeekday; i++) {
      currentRow.add(const Expanded(child: SizedBox(height: 36)));
    }
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(_selectedDate.year, _selectedDate.month, day);
      final selected = isSelected(date);
      final todayDate = isToday(date);
      currentRow.add(
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() => _selectedDate = date);
            },
            child: Container(
              height: 36,
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: selected ? Colors.green : (todayDate ? Colors.blue.withOpacity(0.1) : null),
                borderRadius: BorderRadius.circular(4),
                border: todayDate && !selected ? Border.all(color: Colors.blue) : null,
              ),
              child: Center(
                child: Text(
                  '$day',
                  style: TextStyle(
                    fontSize: 14,
                    color: selected ? Colors.white : null,
                    fontWeight: selected || todayDate ? FontWeight.bold : null,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      if (currentRow.length == 7) {
        rows.add(Row(children: currentRow));
        currentRow = [];
      }
    }
    while (currentRow.length < 7 && currentRow.isNotEmpty) {
      currentRow.add(const Expanded(child: SizedBox(height: 36)));
    }
    if (currentRow.isNotEmpty) {
      rows.add(Row(children: currentRow));
    }
    return Column(children: rows);
  }
}
