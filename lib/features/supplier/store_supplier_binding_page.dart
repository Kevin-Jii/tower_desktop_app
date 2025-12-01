import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/fluent_info_bar.dart';
import 'supplier_provider.dart';
import 'models.dart';
import 'bind_product_dialog.dart';

class StoreSupplierBindingPage extends StatefulWidget {
  final int storeId;
  final String storeName;

  const StoreSupplierBindingPage({
    super.key,
    required this.storeId,
    required this.storeName,
  });

  @override
  State<StoreSupplierBindingPage> createState() => _StoreSupplierBindingPageState();
}

class _StoreSupplierBindingPageState extends State<StoreSupplierBindingPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SupplierProvider>().loadStoreBindings(storeId: widget.storeId);
    });
  }

  void _handleBindProduct() async {
    final provider = context.read<SupplierProvider>();
    final boundProductIds = provider.storeBindings.map((b) => b.supplierProductId).toList();
    
    final result = await showDialog<BindSupplierProductRequest>(
      context: context,
      builder: (ctx) => BindProductDialog(
        storeId: widget.storeId,
        excludeProductIds: boundProductIds,
      ),
    );
    if (result != null && mounted) {
      final success = await provider.bindProduct(result);
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '绑定成功');
      } else if (mounted) {
        final err = provider.error ?? '绑定失败';
        await FluentInfoBarHelper.showError(context, err);
      }
    }
  }

  void _handleUnbind(StoreSupplierProduct binding) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('确认解绑'),
        content: Text('确定要解绑商品 "${binding.supplierProduct?.name ?? ''}" 吗？'),
        actions: [
          Button(onPressed: () => Navigator.pop(context, false), child: const Text('取消')),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.red)),
            child: const Text('解绑'),
          ),
        ],
      ),
    );
    if (result == true && mounted) {
      final success = await context.read<SupplierProvider>().unbindProduct(binding.id, widget.storeId);
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '解绑成功');
      } else if (mounted) {
        final err = context.read<SupplierProvider>().error ?? '解绑失败';
        await FluentInfoBarHelper.showError(context, err);
      }
    }
  }

  void _handleSetDefault(StoreSupplierProduct binding) async {
    final success = await context.read<SupplierProvider>().setDefaultSupplier(binding.id, widget.storeId);
    if (success && mounted) {
      await FluentInfoBarHelper.showSuccess(context, '已设为默认供应商');
    } else if (mounted) {
      final err = context.read<SupplierProvider>().error ?? '设置失败';
      await FluentInfoBarHelper.showError(context, err);
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
          _buildPagination(),
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
          IconButton(
            icon: const Icon(FluentIcons.back, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.teal, Colors.teal.lighter]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(FluentIcons.link, size: 24, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.storeName} - 供应商绑定',
                style: theme.typography.title?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                '管理门店可采购的供应商商品',
                style: theme.typography.caption?.copyWith(color: isDark ? Colors.grey[100] : Colors.grey[130]),
              ),
            ],
          ),
          const Spacer(),
          FilledButton(
            onPressed: _handleBindProduct,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(FluentIcons.add, size: 18),
                SizedBox(width: 8),
                Text('绑定商品'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Consumer<SupplierProvider>(
      builder: (context, provider, _) {
        if (provider.loading) {
          return const Center(child: ProgressRing());
        }
        if (provider.storeBindings.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(FluentIcons.link, size: 64, color: Colors.grey[100]),
                const SizedBox(height: 16),
                Text('暂无绑定商品', style: TextStyle(color: Colors.grey[100], fontSize: 16)),
                const SizedBox(height: 16),
                FilledButton(onPressed: _handleBindProduct, child: const Text('绑定商品')),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(24),
          itemCount: provider.storeBindings.length,
          itemBuilder: (context, index) => _buildBindingCard(provider.storeBindings[index], isDark),
        );
      },
    );
  }

  Widget _buildBindingCard(StoreSupplierProduct binding, bool isDark) {
    final theme = FluentTheme.of(context);
    final product = binding.supplierProduct;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      backgroundColor: isDark ? const Color(0xFF2D2D2D) : Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.teal, Colors.teal.lighter]),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                product?.name.substring(0, 1) ?? '?',
                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(product?.name ?? '未知商品', style: theme.typography.bodyStrong),
                    const SizedBox(width: 8),
                    if (binding.isDefault)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.orange.withOpacity(0.3)),
                        ),
                        child: const Text('默认', style: TextStyle(fontSize: 11, color: Colors.orange)),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    if (product?.supplier != null)
                      Text('供应商: ${product!.supplier!.name}', style: TextStyle(fontSize: 12, color: Colors.grey[130])),
                    if (product?.price != null) ...[
                      const SizedBox(width: 16),
                      Text('价格: ¥${product!.price!.toStringAsFixed(2)}', style: TextStyle(fontSize: 12, color: Colors.orange)),
                    ],
                  ],
                ),
              ],
            ),
          ),
          if (!binding.isDefault)
            Button(
              onPressed: () => _handleSetDefault(binding),
              child: const Text('设为默认'),
            ),
          const SizedBox(width: 8),
          Button(
            onPressed: () => _handleUnbind(binding),
            child: Text('解绑', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildPagination() {
    return Consumer<SupplierProvider>(
      builder: (context, provider, _) {
        if (provider.storeBindings.isEmpty) return const SizedBox.shrink();
        final totalPages = (provider.bindingTotal / 10).ceil();
        if (totalPages <= 1) return const SizedBox.shrink();

        final theme = FluentTheme.of(context);
        final isDark = theme.brightness == Brightness.dark;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
            border: Border(top: BorderSide(color: isDark ? Colors.grey[100].withOpacity(0.2) : Colors.grey[40]!, width: 1)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('共 ${provider.bindingTotal} 条记录'),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(FluentIcons.chevron_left, size: 16),
                    onPressed: provider.bindingPage > 1
                        ? () => provider.loadStoreBindings(storeId: widget.storeId, page: provider.bindingPage - 1)
                        : null,
                  ),
                  Text('${provider.bindingPage} / $totalPages'),
                  IconButton(
                    icon: const Icon(FluentIcons.chevron_right, size: 16),
                    onPressed: provider.bindingPage < totalPages
                        ? () => provider.loadStoreBindings(storeId: widget.storeId, page: provider.bindingPage + 1)
                        : null,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
