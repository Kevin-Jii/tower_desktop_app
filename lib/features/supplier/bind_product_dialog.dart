import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'supplier_provider.dart';
import 'models.dart';

class BindProductDialog extends StatefulWidget {
  final int storeId;
  final List<int> excludeProductIds;

  const BindProductDialog({
    super.key,
    required this.storeId,
    required this.excludeProductIds,
  });

  @override
  State<BindProductDialog> createState() => _BindProductDialogState();
}

class _BindProductDialogState extends State<BindProductDialog> {
  Supplier? _selectedSupplier;
  SupplierProduct? _selectedProduct;
  bool _isDefault = false;
  
  List<Supplier> _suppliers = [];
  List<SupplierProduct> _products = [];
  bool _loadingSuppliers = true;
  bool _loadingProducts = false;

  @override
  void initState() {
    super.initState();
    _loadSuppliers();
  }

  Future<void> _loadSuppliers() async {
    setState(() => _loadingSuppliers = true);
    final provider = context.read<SupplierProvider>();
    await provider.loadSuppliers(page: 1, pageSize: 100);
    if (mounted) {
      setState(() {
        _suppliers = provider.suppliers;
        _loadingSuppliers = false;
      });
    }
  }

  Future<void> _loadProducts(int supplierId) async {
    setState(() {
      _loadingProducts = true;
      _selectedProduct = null;
    });
    final provider = context.read<SupplierProvider>();
    await provider.loadProducts(page: 1, pageSize: 100, supplierId: supplierId);
    if (mounted) {
      setState(() {
        _products = provider.products
            .where((p) => !widget.excludeProductIds.contains(p.id))
            .toList();
        _loadingProducts = false;
      });
    }
  }

  void _handleSubmit() {
    if (_selectedProduct == null) return;
    final request = BindSupplierProductRequest(
      storeId: widget.storeId,
      supplierProductId: _selectedProduct!.id,
      isDefault: _isDefault,
    );
    Navigator.pop(context, request);
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: const BoxConstraints(maxWidth: 450),
      title: const Text('绑定商品'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 供应商选择
          InfoLabel(
            label: '选择供应商',
            child: _loadingSuppliers
                ? const SizedBox(height: 32, child: Center(child: ProgressRing()))
                : ComboBox<Supplier>(
                    isExpanded: true,
                    placeholder: const Text('请选择供应商'),
                    value: _selectedSupplier,
                    items: _suppliers.map((s) => ComboBoxItem<Supplier>(
                      value: s,
                      child: Text(s.name),
                    )).toList(),
                    onChanged: (supplier) {
                      setState(() => _selectedSupplier = supplier);
                      if (supplier != null) {
                        _loadProducts(supplier.id);
                      }
                    },
                  ),
          ),
          const SizedBox(height: 16),
          // 商品选择
          InfoLabel(
            label: '选择商品',
            child: _loadingProducts
                ? const SizedBox(height: 32, child: Center(child: ProgressRing()))
                : ComboBox<SupplierProduct>(
                    isExpanded: true,
                    placeholder: Text(_selectedSupplier == null ? '请先选择供应商' : '请选择商品'),
                    value: _selectedProduct,
                    items: _products.map((p) => ComboBoxItem<SupplierProduct>(
                      value: p,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(p.name, overflow: TextOverflow.ellipsis)),
                          if (p.price != null)
                            Text('¥${p.price!.toStringAsFixed(2)}', 
                              style: TextStyle(color: Colors.orange, fontSize: 12)),
                        ],
                      ),
                    )).toList(),
                    onChanged: _selectedSupplier == null 
                        ? null 
                        : (product) => setState(() => _selectedProduct = product),
                  ),
          ),
          const SizedBox(height: 16),
          // 设为默认
          Checkbox(
            checked: _isDefault,
            onChanged: (v) => setState(() => _isDefault = v ?? false),
            content: const Text('设为默认供应商'),
          ),
        ],
      ),
      actions: [
        Button(onPressed: () => Navigator.pop(context), child: const Text('取消')),
        FilledButton(
          onPressed: _selectedProduct != null ? _handleSubmit : null,
          child: const Text('确定绑定'),
        ),
      ],
    );
  }
}
