import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/fluent_info_bar.dart';
import '../supplier/supplier_provider.dart';
import '../supplier/models.dart';
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
  bool _loadingProducts = false;
  List<StoreSupplierProduct> _availableProducts = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  void dispose() {
    _remarkController.dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    setState(() => _loadingProducts = true);
    try {
      await context.read<SupplierProvider>().loadStoreSupplierProducts();
      if (mounted) {
        setState(() {
          _availableProducts = context.read<SupplierProvider>().storeSupplierProducts;
          _loadingProducts = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _loadingProducts = false);
      }
    }
  }

  void _addItem() {
    if (_availableProducts.isEmpty) {
      FluentInfoBarHelper.showWarning(context, '暂无可选商品，请先绑定供应商商品');
      return;
    }
    setState(() {
      _items.add(_OrderItemData(
        product: _availableProducts.first,
        quantity: 1,
      ));
    });
  }

  void _removeItem(int index) {
    setState(() => _items.removeAt(index));
  }

  void _updateItemProduct(int index, StoreSupplierProduct product) {
    setState(() => _items[index].product = product);
  }

  void _updateItemQuantity(int index, double quantity) {
    setState(() => _items[index].quantity = quantity);
  }

  double get _totalAmount {
    return _items.fold(0.0, (sum, item) {
      final price = item.product?.product?.price ?? 0;
      return sum + (price * item.quantity);
    });
  }

  Future<void> _handleSubmit() async {
    if (_items.isEmpty) {
      await FluentInfoBarHelper.showWarning(context, '请至少添加一个商品');
      return;
    }

    // 检查是否有无效的商品
    for (var item in _items) {
      if (item.product == null || item.quantity <= 0) {
        await FluentInfoBarHelper.showWarning(context, '请检查商品信息是否完整');
        return;
      }
    }

    final request = CreatePurchaseOrderRequest(
      orderDate: _orderDate.toIso8601String().split('T').first,
      remark: _remarkController.text.isEmpty ? null : _remarkController.text,
      items: _items.map((item) => CreatePurchaseOrderItemRequest(
        productId: item.product!.productId,
        quantity: item.quantity,
      )).toList(),
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
        children: [
          _buildHeader(),
          Expanded(child: _buildContent()),
          _buildFooter(),
        ],
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
          colors: [
            theme.accentColor.withOpacity(0.05),
            isDark ? const Color(0xFF2D2D2D) : theme.micaBackgroundColor,
          ],
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
              Text('添加商品并提交采购订单', style: theme.typography.caption?.copyWith(color: isDark ? Colors.grey[100] : Colors.grey[130])),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (_loadingProducts) {
      return const Center(child: ProgressRing());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 基本信息
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
                        child: DatePicker(
                          selected: _orderDate,
                          onChanged: (d) => setState(() => _orderDate = d),
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: InfoLabel(
                        label: '备注',
                        child: TextBox(
                          controller: _remarkController,
                          placeholder: '可选，填写备注信息',
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // 商品列表
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('商品列表', style: theme.typography.subtitle?.copyWith(fontWeight: FontWeight.bold)),
              FilledButton(
                onPressed: _addItem,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(FluentIcons.add, size: 14),
                    SizedBox(width: 6),
                    Text('添加商品'),
                  ],
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

  Widget _buildItemCard(int index, bool isDark) {
    final item = _items[index];
    final product = item.product?.product;
    final price = product?.price ?? 0;
    final amount = price * item.quantity;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      backgroundColor: isDark ? const Color(0xFF2D2D2D) : Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          // 商品选择
          Expanded(
            flex: 3,
            child: ComboBox<StoreSupplierProduct>(
              value: item.product,
              items: _availableProducts.map((p) => ComboBoxItem<StoreSupplierProduct>(
                value: p,
                child: Text('${p.product?.name ?? '未知'} (${p.product?.supplier?.name ?? ''})'),
              )).toList(),
              onChanged: (v) {
                if (v != null) _updateItemProduct(index, v);
              },
              placeholder: const Text('选择商品'),
              isExpanded: true,
            ),
          ),
          const SizedBox(width: 16),
          // 单价显示
          SizedBox(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('单价', style: TextStyle(fontSize: 11, color: Colors.grey[130])),
                Text('¥${price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // 数量输入
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
          // 小计
          SizedBox(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('小计', style: TextStyle(fontSize: 11, color: Colors.grey[130])),
                Text('¥${amount.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // 删除按钮
          IconButton(
            icon: Icon(FluentIcons.delete, size: 16, color: Colors.red),
            onPressed: () => _removeItem(index),
          ),
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text('共 ${_items.length} 项商品', style: theme.typography.body),
              const SizedBox(width: 24),
              Text('合计: ', style: theme.typography.body),
              Text(
                '¥${_totalAmount.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange),
              ),
            ],
          ),
          Row(
            children: [
              Button(
                onPressed: () => Navigator.pop(context),
                child: const Text('取消'),
              ),
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

/// 订单项数据类
class _OrderItemData {
  StoreSupplierProduct? product;
  double quantity;

  _OrderItemData({this.product, this.quantity = 1});
}
