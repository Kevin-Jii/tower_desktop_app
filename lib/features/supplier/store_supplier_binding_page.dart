import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/fluent_info_bar.dart';
import 'supplier_provider.dart';
import 'models.dart';

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
      context.read<SupplierProvider>().loadBoundSuppliers(widget.storeId);
    });
  }

  void _handleBindSupplier() async {
    final provider = context.read<SupplierProvider>();
    final boundIds = provider.boundSuppliers.map((s) => s.id).toSet();

    // 加载所有供应商
    await provider.loadSuppliers(page: 1, pageSize: 100);
    final allSuppliers = provider.suppliers.where((s) => !boundIds.contains(s.id)).toList();

    if (allSuppliers.isEmpty) {
      if (mounted) FluentInfoBarHelper.showWarning(context, '没有可绑定的供应商');
      return;
    }

    final result = await showDialog<List<int>>(
      context: context,
      builder: (ctx) => _BindSupplierDialog(suppliers: allSuppliers),
    );

    if (result != null && result.isNotEmpty && mounted) {
      final success = await provider.bindSuppliers(widget.storeId, result);
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '绑定成功');
      } else if (mounted) {
        final err = provider.error ?? '绑定失败';
        await FluentInfoBarHelper.showError(context, err);
      }
    }
  }

  void _handleUnbind(Supplier supplier) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('确认解绑'),
        content: Text('确定要解绑供应商 "${supplier.name}" 吗？\n解绑后将无法在采购单中选择该供应商的商品。'),
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
      final success = await context.read<SupplierProvider>().unbindSupplier(widget.storeId, supplier.id);
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '解绑成功');
      } else if (mounted) {
        final err = context.read<SupplierProvider>().error ?? '解绑失败';
        await FluentInfoBarHelper.showError(context, err);
      }
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
              gradient: LinearGradient(colors: [Colors.teal, Colors.teal.lighter]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(FluentIcons.link, size: 24, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${widget.storeName} - 绑定供应商', style: theme.typography.title?.copyWith(fontWeight: FontWeight.bold)),
              Text('绑定后可在采购单中选择该供应商的商品',
                  style: theme.typography.caption?.copyWith(color: isDark ? Colors.grey[100] : Colors.grey[130])),
            ],
          ),
          const Spacer(),
          FilledButton(
            onPressed: _handleBindSupplier,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(FluentIcons.add, size: 18), SizedBox(width: 8), Text('绑定供应商')],
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
        if (provider.boundSuppliers.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(FluentIcons.link, size: 64, color: Colors.grey[100]),
                const SizedBox(height: 16),
                Text('暂未绑定供应商', style: TextStyle(color: Colors.grey[100], fontSize: 16)),
                const SizedBox(height: 8),
                Text('绑定供应商后，可在采购单中选择其商品', style: TextStyle(color: Colors.grey[100], fontSize: 12)),
                const SizedBox(height: 16),
                FilledButton(onPressed: _handleBindSupplier, child: const Text('绑定供应商')),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(24),
          itemCount: provider.boundSuppliers.length,
          itemBuilder: (context, index) => _buildSupplierCard(provider.boundSuppliers[index], isDark),
        );
      },
    );
  }

  Widget _buildSupplierCard(Supplier supplier, bool isDark) {
    final theme = FluentTheme.of(context);

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
              child: Text(supplier.name.substring(0, 1),
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(supplier.name, style: theme.typography.bodyStrong),
                const SizedBox(height: 4),
                Row(
                  children: [
                    if (supplier.contactPerson != null)
                      Text('联系人: ${supplier.contactPerson}', style: TextStyle(fontSize: 12, color: Colors.grey[130])),
                    if (supplier.phone != null) ...[
                      const SizedBox(width: 16),
                      Text('电话: ${supplier.phone}', style: TextStyle(fontSize: 12, color: Colors.grey[130])),
                    ],
                  ],
                ),
              ],
            ),
          ),
          Button(
            onPressed: () => _handleUnbind(supplier),
            child: Text('解绑', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}


/// 绑定供应商对话框 - 多选
class _BindSupplierDialog extends StatefulWidget {
  final List<Supplier> suppliers;

  const _BindSupplierDialog({required this.suppliers});

  @override
  State<_BindSupplierDialog> createState() => _BindSupplierDialogState();
}

class _BindSupplierDialogState extends State<_BindSupplierDialog> {
  final Set<int> _selectedIds = {};

  void _toggleSupplier(int id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
    });
  }

  void _selectAll() {
    setState(() {
      if (_selectedIds.length == widget.suppliers.length) {
        _selectedIds.clear();
      } else {
        _selectedIds.addAll(widget.suppliers.map((s) => s.id));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ContentDialog(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 450),
      title: const Text('选择供应商'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('共 ${widget.suppliers.length} 个供应商可绑定', style: theme.typography.body),
              HyperlinkButton(
                onPressed: _selectAll,
                child: Text(_selectedIds.length == widget.suppliers.length ? '取消全选' : '全选'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: widget.suppliers.length,
              itemBuilder: (context, index) {
                final supplier = widget.suppliers[index];
                final isSelected = _selectedIds.contains(supplier.id);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: HoverButton(
                    onPressed: () => _toggleSupplier(supplier.id),
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
                            Checkbox(checked: isSelected, onChanged: (_) => _toggleSupplier(supplier.id)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(supplier.name, style: const TextStyle(fontWeight: FontWeight.w500)),
                                  if (supplier.contactPerson != null || supplier.phone != null)
                                    Text(
                                      [supplier.contactPerson, supplier.phone].where((e) => e != null).join(' | '),
                                      style: TextStyle(fontSize: 11, color: Colors.grey[130]),
                                    ),
                                ],
                              ),
                            ),
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
          onPressed: _selectedIds.isNotEmpty ? () => Navigator.pop(context, _selectedIds.toList()) : null,
          child: Text('确定绑定 (${_selectedIds.length})'),
        ),
      ],
    );
  }
}
