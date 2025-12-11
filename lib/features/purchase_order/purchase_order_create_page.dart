import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/fluent_info_bar.dart';
import '../supplier/supplier_provider.dart';
import '../supplier/models.dart';
import '../dict/dict_provider.dart';
import '../dict/models.dart' as dict;
import 'purchase_order_provider.dart';
import 'models.dart';
class PurchaseOrderCreatePage extends StatefulWidget {
  const PurchaseOrderCreatePage({super.key});
  @override
  State<PurchaseOrderCreatePage> createState() => _PurchaseOrderCreatePageState();
}
class _PurchaseOrderCreatePageState extends State<PurchaseOrderCreatePage> {
  DateTime _orderDate = DateTime.now();
  final _remarkController = TextEditingController();
  final List<_OrderItemData> _items = [];
  bool _loading = false;
  List<Supplier> _boundSuppliers = [];
  List<dict.DictData> _unitOptions = []; 
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadBoundSuppliers();
    });
  }
  @override
  void dispose() {
    _remarkController.dispose();
    super.dispose();
  }
  Future<void> _loadBoundSuppliers() async {
    setState(() => _loading = true);
    try {
      final dictProvider = context.read<DictProvider>();
      await dictProvider.loadAllDicts();
      if (mounted) {
        _unitOptions = dictProvider.getDictByCode('GYSGL_SPDW');
      }
      await context.read<SupplierProvider>().loadBoundSuppliers(0); 
      if (mounted) {
        setState(() {
          _boundSuppliers = context.read<SupplierProvider>().boundSuppliers;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _loading = false);
    }
  }
  Future<void> _showAddProductsDialog() async {
    if (_boundSuppliers.isEmpty) {
      FluentInfoBarHelper.showWarning(context, '暂无已绑定的供应商，请先在门店管理中绑定供应商');
      return;
    }
    final result = await showDialog<List<_OrderItemData>>(
      context: context,
      builder: (context) => _AddProductsDialog(
        suppliers: _boundSuppliers,
        existingProductIds: _items.map((e) => e.product?.id ?? 0).toSet(),
      ),
    );
    if (result != null && result.isNotEmpty) {
      setState(() => _items.addAll(result));
    }
  }
  void _removeItem(int index) {
    setState(() => _items.removeAt(index));
  }
  void _updateItemQuantity(int index, double quantity) {
    setState(() => _items[index].quantity = quantity);
  }
  double get _totalAmount {
    return _items.fold(0.0, (sum, item) {
      final price = item.product?.price ?? 0;
      return sum + (price * item.quantity);
    });
  }
  Future<void> _handleSubmit() async {
    if (_items.isEmpty) {
      await FluentInfoBarHelper.showWarning(context, '请至少添加一个商品');
      return;
    }
    final request = CreatePurchaseOrderRequest(
      orderDate: _orderDate.toIso8601String().split('T').first,
      remark: _remarkController.text.isEmpty ? null : _remarkController.text,
      items: _items
          .map((item) => CreatePurchaseOrderItemRequest(
            productId: item.product!.id, 
            quantity: item.quantity,
            unit: item.unit, 
          ))
          .toList(),
    );
    final success = await context.read<PurchaseOrderProvider>().createOrder(request);
    if (success && mounted) {
      await FluentInfoBarHelper.showSuccess(context, '采购单创建成功');
      Navigator.pop(context);
    } else if (mounted) {
      final error = context.read<PurchaseOrderProvider>().error ?? '创建失败';
      await FluentInfoBarHelper.showError(context, error);
    }
  }
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Column(
        children: [_buildHeader(), Expanded(child: _buildContent()), _buildFooter()],
      ),
    );
  }
  Widget _buildHeader() {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [theme.accentColor.withOpacity(0.05), isDark ? const Color(0xFF2D2D2D) : theme.micaBackgroundColor],
        ),
        border: Border(bottom: BorderSide(color: theme.resources.dividerStrokeColorDefault, width: 1)),
      ),
      child: Row(
        children: [
          IconButton(icon: const Icon(FluentIcons.back, size: 20), onPressed: () => Navigator.pop(context)),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.green, Colors.green.lighter]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(FluentIcons.add, size: 24, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('新建采购单', style: theme.typography.title?.copyWith(fontWeight: FontWeight.bold)),
              Text('选择供应商并添加商品',
                  style: theme.typography.caption?.copyWith(color: isDark ? Colors.grey[100] : Colors.grey[130])),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildContent() {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    if (_loading) return const Center(child: ProgressRing());
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            padding: const EdgeInsets.all(20),
            backgroundColor: isDark ? const Color(0xFF2D2D2D) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('基本信息', style: theme.typography.subtitle?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: InfoLabel(
                        label: '采购日期',
                        child: DatePicker(selected: _orderDate, onChanged: (d) => setState(() => _orderDate = d)),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: InfoLabel(
                        label: '备注',
                        child: TextBox(controller: _remarkController, placeholder: '可选，填写备注信息', maxLines: 1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('商品列表', style: theme.typography.subtitle?.copyWith(fontWeight: FontWeight.bold)),
              FilledButton(
                onPressed: _showAddProductsDialog,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(FluentIcons.add, size: 14), SizedBox(width: 6), Text('添加商品')],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_items.isEmpty)
            Card(
              padding: const EdgeInsets.all(32),
              backgroundColor: isDark ? const Color(0xFF2D2D2D) : Colors.white,
              child: Center(
                child: Column(
                  children: [
                    Icon(FluentIcons.shopping_cart, size: 48, color: Colors.grey[100]),
                    const SizedBox(height: 12),
                    Text('暂无商品，点击上方按钮添加', style: TextStyle(color: Colors.grey[100])),
                  ],
                ),
              ),
            )
          else
            ...List.generate(_items.length, (index) => _buildItemCard(index, isDark)),
        ],
      ),
    );
  }
  void _updateItemUnit(int index, String? unit) {
    setState(() => _items[index].unit = unit);
  }
  Widget _buildItemCard(int index, bool isDark) {
    final item = _items[index];
    final price = item.product?.price ?? 0;
    final amount = price * item.quantity;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      backgroundColor: isDark ? const Color(0xFF2D2D2D) : Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.product?.name ?? '-', style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text('供应商: ${item.supplier?.name ?? '-'}', style: TextStyle(fontSize: 12, color: Colors.grey[130])),
              ],
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('单位', style: TextStyle(fontSize: 11, color: Colors.grey[130])),
                const SizedBox(height: 4),
                ComboBox<String>(
                  value: item.unit,
                  placeholder: const Text('选择'),
                  isExpanded: true,
                  items: _unitOptions.map((d) => ComboBoxItem<String>(
                    value: d.value,
                    child: Text(d.label),
                  )).toList(),
                  onChanged: (v) => _updateItemUnit(index, v),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('单价', style: TextStyle(fontSize: 11, color: Colors.grey[130])),
                Text('¥${price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 120,
            child: NumberBox<double>(
              value: item.quantity,
              onChanged: (v) => _updateItemQuantity(index, v ?? 1),
              min: 0.1,
              smallChange: 0.5,
              mode: SpinButtonPlacementMode.inline,
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('小计', style: TextStyle(fontSize: 11, color: Colors.grey[130])),
                Text('¥${amount.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          IconButton(icon: Icon(FluentIcons.delete, size: 16, color: Colors.red), onPressed: () => _removeItem(index)),
        ],
      ),
    );
  }
  Widget _buildFooter() {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final provider = context.watch<PurchaseOrderProvider>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
        border: Border(top: BorderSide(color: isDark ? Colors.grey[100].withOpacity(0.2) : Colors.grey[40]!, width: 1)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -2))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text('共 ${_items.length} 项商品', style: theme.typography.body),
              const SizedBox(width: 24),
              Text('合计: ', style: theme.typography.body),
              Text('¥${_totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange)),
            ],
          ),
          Row(
            children: [
              Button(onPressed: () => Navigator.pop(context), child: const Text('取消')),
              const SizedBox(width: 12),
              FilledButton(
                onPressed: provider.creating ? null : _handleSubmit,
                child: provider.creating
                    ? const SizedBox(width: 16, height: 16, child: ProgressRing(strokeWidth: 2))
                    : const Text('提交采购单'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class _OrderItemData {
  Supplier? supplier;
  SupplierProduct? product;
  double quantity;
  String? unit; 
  _OrderItemData({this.supplier, this.product, this.quantity = 1, this.unit});
}
class _AddProductsDialog extends StatefulWidget {
  final List<Supplier> suppliers;
  final Set<int> existingProductIds;
  const _AddProductsDialog({required this.suppliers, required this.existingProductIds});
  @override
  State<_AddProductsDialog> createState() => _AddProductsDialogState();
}
class _AddProductsDialogState extends State<_AddProductsDialog> {
  Supplier? _selectedSupplier;
  List<SupplierProduct> _products = [];
  final Set<int> _selectedProductIds = {};
  bool _loading = false;
  Future<void> _loadProducts(int? supplierId) async {
    setState(() => _loading = true);
    final provider = context.read<SupplierProvider>();
    await provider.loadPurchasableProducts(supplierId: supplierId);
    setState(() {
      _products = provider.purchasableProducts.where((p) => !widget.existingProductIds.contains(p.id)).toList();
      _selectedProductIds.clear();
      _loading = false;
    });
  }
  void _toggleProduct(int id) {
    setState(() {
      if (_selectedProductIds.contains(id)) {
        _selectedProductIds.remove(id);
      } else {
        _selectedProductIds.add(id);
      }
    });
  }
  void _selectAll() {
    setState(() {
      if (_selectedProductIds.length == _products.length) {
        _selectedProductIds.clear();
      } else {
        _selectedProductIds.addAll(_products.map((p) => p.id));
      }
    });
  }
  void _handleConfirm() {
    if (_selectedSupplier == null || _selectedProductIds.isEmpty) return;
    final items = _products
        .where((p) => _selectedProductIds.contains(p.id))
        .map((p) => _OrderItemData(
          supplier: _selectedSupplier, 
          product: p, 
          quantity: 1,
          unit: p.unit, 
        ))
        .toList();
    Navigator.pop(context, items);
  }
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return ContentDialog(
      constraints: const BoxConstraints(maxWidth: 600, maxHeight: 500),
      title: const Text('添加商品'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoLabel(
            label: '选择供应商',
            child: ComboBox<Supplier>(
              isExpanded: true,
              placeholder: const Text('请选择供应商'),
              value: _selectedSupplier,
              items: widget.suppliers.map((s) => ComboBoxItem<Supplier>(value: s, child: Text(s.name))).toList(),
              onChanged: (supplier) {
                setState(() => _selectedSupplier = supplier);
                if (supplier != null) _loadProducts(supplier.id);
              },
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('商品列表', style: theme.typography.bodyStrong),
              if (_products.isNotEmpty)
                HyperlinkButton(
                  onPressed: _selectAll,
                  child: Text(_selectedProductIds.length == _products.length ? '取消全选' : '全选'),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _loading
                ? const Center(child: ProgressRing())
                : _selectedSupplier == null
                    ? Center(child: Text('请先选择供应商', style: TextStyle(color: Colors.grey[100])))
                    : _products.isEmpty
                        ? Center(child: Text('该供应商暂无可添加的商品', style: TextStyle(color: Colors.grey[100])))
                        : ListView.builder(
                            itemCount: _products.length,
                            itemBuilder: (context, index) {
                              final product = _products[index];
                              final isSelected = _selectedProductIds.contains(product.id);
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: HoverButton(
                                  onPressed: () => _toggleProduct(product.id),
                                  builder: (context, states) {
                                    return Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.blue.withOpacity(0.15)
                                            : states.isHovered
                                                ? (isDark ? Colors.grey[150].withOpacity(0.1) : Colors.grey[30])
                                                : Colors.transparent,
                                        borderRadius: BorderRadius.circular(6),
                                        border: isSelected ? Border.all(color: Colors.blue.withOpacity(0.5)) : null,
                                      ),
                                      child: Row(
                                        children: [
                                          Checkbox(checked: isSelected, onChanged: (_) => _toggleProduct(product.id)),
                                          const SizedBox(width: 8),
                                          Expanded(child: Text(product.name)),
                                          if (product.price != null)
                                            Text('¥${product.price!.toStringAsFixed(2)}',
                                                style: TextStyle(color: Colors.orange)),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
          ),
        ],
      ),
      actions: [
        Button(onPressed: () => Navigator.pop(context), child: const Text('取消')),
        FilledButton(
          onPressed: _selectedProductIds.isNotEmpty ? _handleConfirm : null,
          child: Text('确定添加 (${_selectedProductIds.length})'),
        ),
      ],
    );
  }
}
