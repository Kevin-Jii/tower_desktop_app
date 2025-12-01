import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/fluent_info_bar.dart';
import 'supplier_provider.dart';
import 'models.dart';
import 'supplier_category_form_dialog.dart';
import 'supplier_product_form_dialog.dart';

class SupplierProductManagementPage extends StatefulWidget {
  final int supplierId;
  final String supplierName;

  const SupplierProductManagementPage({
    super.key,
    required this.supplierId,
    required this.supplierName,
  });

  @override
  State<SupplierProductManagementPage> createState() => _SupplierProductManagementPageState();
}

class _SupplierProductManagementPageState extends State<SupplierProductManagementPage> {
  int? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SupplierProvider>().loadCategories(widget.supplierId);
    });
  }

  void _handleAddCategory() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => SupplierCategoryFormDialog(supplierId: widget.supplierId),
    );
    if (result != null && mounted) {
      final success = await context.read<SupplierProvider>().createCategory(result);
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '分类创建成功');
      } else if (mounted) {
        final err = context.read<SupplierProvider>().error ?? '创建失败';
        await FluentInfoBarHelper.showError(context, err);
      }
    }
  }

  void _handleEditCategory(SupplierCategory category) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => SupplierCategoryFormDialog(
        supplierId: widget.supplierId,
        category: category,
      ),
    );
    if (result != null && mounted) {
      final success = await context.read<SupplierProvider>().updateCategory(category.id, result);
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '分类更新成功');
      } else if (mounted) {
        final err = context.read<SupplierProvider>().error ?? '更新失败';
        await FluentInfoBarHelper.showError(context, err);
      }
    }
  }


  void _handleDeleteCategory(SupplierCategory category) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除分类 "${category.name}" 吗？'),
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
    if (result == true && mounted) {
      final success = await context.read<SupplierProvider>().deleteCategory(category.id, widget.supplierId);
      if (success && mounted) {
        if (_selectedCategoryId == category.id) {
          setState(() => _selectedCategoryId = null);
        }
        await FluentInfoBarHelper.showSuccess(context, '分类删除成功');
      } else if (mounted) {
        final err = context.read<SupplierProvider>().error ?? '删除失败';
        await FluentInfoBarHelper.showError(context, err);
      }
    }
  }

  void _handleSelectCategory(int categoryId) {
    setState(() => _selectedCategoryId = categoryId);
    context.read<SupplierProvider>().loadProducts(
      page: 1,
      supplierId: widget.supplierId,
      categoryId: categoryId,
    );
  }

  void _handleAddProduct() async {
    if (_selectedCategoryId == null) {
      await FluentInfoBarHelper.showWarning(context, '请先选择一个分类');
      return;
    }
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => SupplierProductFormDialog(
        supplierId: widget.supplierId,
        categoryId: _selectedCategoryId!,
      ),
    );
    if (result != null && mounted) {
      final success = await context.read<SupplierProvider>().createProduct(result);
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '商品创建成功');
      } else if (mounted) {
        final err = context.read<SupplierProvider>().error ?? '创建失败';
        await FluentInfoBarHelper.showError(context, err);
      }
    }
  }

  void _handleEditProduct(SupplierProduct product) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => SupplierProductFormDialog(
        supplierId: widget.supplierId,
        categoryId: product.categoryId,
        product: product,
      ),
    );
    if (result != null && mounted) {
      final success = await context.read<SupplierProvider>().updateProduct(product.id, result);
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '商品更新成功');
      } else if (mounted) {
        final err = context.read<SupplierProvider>().error ?? '更新失败';
        await FluentInfoBarHelper.showError(context, err);
      }
    }
  }

  void _handleDeleteProduct(SupplierProduct product) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除商品 "${product.name}" 吗？'),
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
    if (result == true && mounted) {
      final success = await context.read<SupplierProvider>().deleteProduct(product.id, widget.supplierId);
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '商品删除成功');
      } else if (mounted) {
        final err = context.read<SupplierProvider>().error ?? '删除失败';
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
          Expanded(
            child: Row(
              children: [
                _buildCategorySidebar(),
                Expanded(child: _buildProductList()),
              ],
            ),
          ),
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
        border: Border(
          bottom: BorderSide(color: theme.resources.dividerStrokeColorDefault, width: 1),
        ),
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
              gradient: LinearGradient(colors: [Colors.purple, Colors.purple.lighter]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(FluentIcons.product, size: 24, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.supplierName} - 商品管理',
                style: theme.typography.title?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                '管理供应商的商品分类和商品信息',
                style: theme.typography.caption?.copyWith(
                  color: isDark ? Colors.grey[100] : Colors.grey[130],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySidebar() {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
        border: Border(
          right: BorderSide(color: theme.resources.dividerStrokeColorDefault, width: 1),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text('商品分类', style: theme.typography.bodyStrong),
                const Spacer(),
                IconButton(
                  icon: const Icon(FluentIcons.add, size: 16),
                  onPressed: _handleAddCategory,
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<SupplierProvider>(
              builder: (context, provider, _) {
                if (provider.loading && provider.categories.isEmpty) {
                  return const Center(child: ProgressRing());
                }
                if (provider.categories.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(FluentIcons.folder, size: 48, color: Colors.grey[100]),
                        const SizedBox(height: 12),
                        Text('暂无分类', style: TextStyle(color: Colors.grey[100])),
                        const SizedBox(height: 12),
                        Button(onPressed: _handleAddCategory, child: const Text('新增分类')),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: provider.categories.length,
                  itemBuilder: (context, index) {
                    final category = provider.categories[index];
                    final isSelected = _selectedCategoryId == category.id;
                    return _buildCategoryItem(category, isSelected, isDark);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(SupplierCategory category, bool isSelected, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: HoverButton(
        onPressed: () => _handleSelectCategory(category.id),
        builder: (context, states) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.purple.withOpacity(0.15)
                  : states.isHovered
                      ? (isDark ? Colors.grey[150].withOpacity(0.1) : Colors.grey[30])
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: isSelected ? Border.all(color: Colors.purple.withOpacity(0.5)) : null,
            ),
            child: Row(
              children: [
                Icon(
                  FluentIcons.folder,
                  size: 16,
                  color: isSelected ? Colors.purple : (isDark ? Colors.grey[100] : Colors.grey[130]),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    category.name,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected ? Colors.purple : (isDark ? Colors.white : const Color(0xFF333333)),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(FluentIcons.edit, size: 12, color: Colors.blue),
                  onPressed: () => _handleEditCategory(category),
                ),
                IconButton(
                  icon: Icon(FluentIcons.delete, size: 12, color: Colors.red),
                  onPressed: () => _handleDeleteCategory(category),
                ),
              ],
            ),
          );
        },
      ),
    );
  }


  Widget _buildProductList() {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      color: isDark ? const Color(0xFF1F1F1F) : const Color(0xFFF5F7FA),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text('商品列表', style: theme.typography.bodyStrong),
                const Spacer(),
                FilledButton(
                  onPressed: _handleAddProduct,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(FluentIcons.add, size: 14),
                      SizedBox(width: 6),
                      Text('新增商品'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<SupplierProvider>(
              builder: (context, provider, _) {
                if (_selectedCategoryId == null) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(FluentIcons.product, size: 64, color: Colors.grey[100]),
                        const SizedBox(height: 16),
                        Text('请先选择一个分类', style: TextStyle(color: Colors.grey[100], fontSize: 16)),
                      ],
                    ),
                  );
                }
                if (provider.loading) {
                  return const Center(child: ProgressRing());
                }
                if (provider.products.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(FluentIcons.product, size: 64, color: Colors.grey[100]),
                        const SizedBox(height: 16),
                        Text('该分类下暂无商品', style: TextStyle(color: Colors.grey[100])),
                        const SizedBox(height: 16),
                        FilledButton(onPressed: _handleAddProduct, child: const Text('新增商品')),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: provider.products.length,
                  itemBuilder: (context, index) => _buildProductCard(provider.products[index], isDark),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(SupplierProduct product, bool isDark) {
    final theme = FluentTheme.of(context);
    final isActive = product.status == 1;

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
              gradient: LinearGradient(colors: [Colors.purple, Colors.purple.lighter]),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                product.name.substring(0, 1),
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
                    Text(product.name, style: theme.typography.bodyStrong),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: isActive ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        isActive ? '启用' : '禁用',
                        style: TextStyle(fontSize: 11, color: isActive ? Colors.green : Colors.grey),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    if (product.unit != null) ...[
                      Text('单位: ${product.unit}', style: TextStyle(fontSize: 12, color: Colors.grey[130])),
                      const SizedBox(width: 16),
                    ],
                    if (product.price != null)
                      Text('价格: ¥${product.price!.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 12, color: Colors.orange)),
                  ],
                ),
              ],
            ),
          ),
          Button(
            onPressed: () => _handleEditProduct(product),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(FluentIcons.edit, size: 12, color: Colors.blue), const SizedBox(width: 4), const Text('编辑')],
            ),
          ),
          const SizedBox(width: 8),
          Button(
            onPressed: () => _handleDeleteProduct(product),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(FluentIcons.delete, size: 12, color: Colors.red), const SizedBox(width: 4), Text('删除', style: TextStyle(color: Colors.red))],
            ),
          ),
        ],
      ),
    );
  }
}
