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
  final _searchCtrl = TextEditingController();
  int? _selectedProductId;
  bool _isDefault = false;
  List<SupplierProduct> _products = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadProducts({String? keyword}) async {
    setState(() => _loading = true);
    final provider = context.read<SupplierProvider>();
    await provider.loadProducts(page: 1, pageSize: 100, keyword: keyword);
    if (mounted) {
      setState(() {
        _products = provider.products
            .where((p) => !widget.excludeProductIds.contains(p.id))
            .toList();
        _loading = false;
      });
    }
  }

  void _handleSearch() {
    final keyword = _searchCtrl.text.trim();
    _loadProducts(keyword: keyword.isEmpty ? null : keyword);
  }

  void _handleSubmit() {
    if (_selectedProductId == null) return;
    final request = BindSupplierProductRequest(
      storeId: widget.storeId,
      supplierProductId: _selectedProductId!,
      isDefault: _isDefault,
    );
    Navigator.pop(context, request);
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ContentDialog(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
      title: const Text('绑定商品'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextBox(
                  controller: _searchCtrl,
                  placeholder: '搜索商品名称',
                  onSubmitted: (_) => _handleSearch(),
                ),
              ),
              const SizedBox(width: 8),
              Button(onPressed: _handleSearch, child: const Text('搜索')),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 300,
            child: _loading
                ? const Center(child: ProgressRing())
                : _products.isEmpty
                    ? Center(child: Text('暂无可绑定的商品', style: TextStyle(color: Colors.grey[100])))
                    : ListView.builder(
                        itemCount: _products.length,
                        itemBuilder: (context, index) {
                          final product = _products[index];
                          final isSelected = _selectedProductId == product.id;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: HoverButton(
                              onPressed: () => setState(() => _selectedProductId = product.id),
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
                                      Icon(
                                        isSelected ? FluentIcons.radio_btn_on : FluentIcons.radio_btn_off,
                                        size: 16,
                                        color: isSelected ? Colors.blue : Colors.grey[100],
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(product.name, style: TextStyle(fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal)),
                                            if (product.supplier != null)
                                              Text('供应商: ${product.supplier!.name}', style: TextStyle(fontSize: 11, color: Colors.grey[100])),
                                          ],
                                        ),
                                      ),
                                      if (product.price != null)
                                        Text('¥${product.price!.toStringAsFixed(2)}', style: TextStyle(color: Colors.orange)),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Checkbox(
                checked: _isDefault,
                onChanged: (v) => setState(() => _isDefault = v ?? false),
                content: const Text('设为默认供应商'),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Button(onPressed: () => Navigator.pop(context), child: const Text('取消')),
        FilledButton(
          onPressed: _selectedProductId != null ? _handleSubmit : null,
          child: const Text('确定绑定'),
        ),
      ],
    );
  }
}
