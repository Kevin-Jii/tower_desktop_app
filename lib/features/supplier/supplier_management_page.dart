import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/fluent_info_bar.dart';
import 'supplier_provider.dart';
import 'models.dart';
import 'supplier_form_dialog.dart';
import 'supplier_category_form_dialog.dart';
import 'supplier_product_form_dialog.dart';

class SupplierManagementPage extends StatefulWidget {
  const SupplierManagementPage({super.key});

  @override
  State<SupplierManagementPage> createState() => _SupplierManagementPageState();
}

class _SupplierManagementPageState extends State<SupplierManagementPage> {
  final _keywordCtrl = TextEditingController();
  final Set<int> _updatingSuppliers = {};
  Supplier? _selectedSupplier;
  int? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SupplierProvider>().loadSuppliers();
    });
  }

  @override
  void dispose() {
    _keywordCtrl.dispose();
    super.dispose();
  }

  void _handleSearch() {
    final keyword = _keywordCtrl.text.trim();
    context.read<SupplierProvider>().loadSuppliers(
        page: 1, keyword: keyword.isEmpty ? null : keyword);
  }

  void _handleReset() {
    _keywordCtrl.clear();
    context.read<SupplierProvider>().loadSuppliers(page: 1, keyword: null);
  }

  void _handleCreateSupplier() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => const SupplierFormDialog(),
    );
    if (result != null && mounted) {
      final success =
          await context.read<SupplierProvider>().createSupplier(result);
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '供应商创建成功');
      } else if (mounted) {
        final err = context.read<SupplierProvider>().error ?? '创建失败';
        await FluentInfoBarHelper.showError(context, err);
      }
    }
  }

  void _handleEditSupplier(Supplier supplier) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => SupplierFormDialog(supplier: supplier),
    );
    if (result != null && mounted) {
      final success = await context
          .read<SupplierProvider>()
          .updateSupplier(supplier.id, result);
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '供应商更新成功');
      } else if (mounted) {
        final err = context.read<SupplierProvider>().error ?? '更新失败';
        await FluentInfoBarHelper.showError(context, err);
      }
    }
  }

  void _handleDeleteSupplier(Supplier supplier) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除供应商 "${supplier.name}" 吗？'),
        actions: [
          Button(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('取消')),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.red)),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (result == true && mounted) {
      final success =
          await context.read<SupplierProvider>().deleteSupplier(supplier.id);
      if (success && mounted) {
        if (_selectedSupplier?.id == supplier.id) {
          setState(() {
            _selectedSupplier = null;
            _selectedCategoryId = null;
          });
        }
        await FluentInfoBarHelper.showSuccess(context, '供应商删除成功');
      } else if (mounted) {
        final err = context.read<SupplierProvider>().error ?? '删除失败';
        await FluentInfoBarHelper.showError(context, err);
      }
    }
  }

  void _handleStatusChange(Supplier supplier, bool value) async {
    setState(() => _updatingSuppliers.add(supplier.id));
    final newStatus = value ? 1 : 0;
    final success = await context
        .read<SupplierProvider>()
        .updateSupplier(supplier.id, {'status': newStatus});
    if (mounted) setState(() => _updatingSuppliers.remove(supplier.id));
    if (success && mounted) {
      await FluentInfoBarHelper.showSuccess(context, '状态已更新');
    } else if (mounted) {
      final err = context.read<SupplierProvider>().error ?? '状态更新失败';
      await FluentInfoBarHelper.showError(context, err);
    }
  }

  void _handleSelectSupplier(Supplier supplier) {
    setState(() {
      _selectedSupplier = supplier;
      _selectedCategoryId = null;
    });
    context.read<SupplierProvider>().loadCategories(supplier.id);
  }

  void _handleAddCategory() async {
    if (_selectedSupplier == null) return;
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) =>
          SupplierCategoryFormDialog(supplierId: _selectedSupplier!.id),
    );
    if (result != null && mounted) {
      final success =
          await context.read<SupplierProvider>().createCategory(result);
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
        supplierId: _selectedSupplier!.id,
        category: category,
      ),
    );
    if (result != null && mounted) {
      final success = await context
          .read<SupplierProvider>()
          .updateCategory(category.id, result);
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
          Button(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('取消')),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.red)),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (result == true && mounted) {
      final success = await context
          .read<SupplierProvider>()
          .deleteCategory(category.id, _selectedSupplier!.id);
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
          supplierId: _selectedSupplier!.id,
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
        supplierId: _selectedSupplier!.id,
        categoryId: _selectedCategoryId!,
      ),
    );
    if (result != null && mounted) {
      final success =
          await context.read<SupplierProvider>().createProduct(result);
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
        supplierId: _selectedSupplier!.id,
        categoryId: product.categoryId,
        product: product,
      ),
    );
    if (result != null && mounted) {
      final success = await context
          .read<SupplierProvider>()
          .updateProduct(product.id, result);
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
          Button(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('取消')),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.red)),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (result == true && mounted) {
      final success = await context
          .read<SupplierProvider>()
          .deleteProduct(product.id, _selectedSupplier!.id);
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
          _buildToolbar(),
          Expanded(
            child: Row(
              children: [
                // 左侧：供应商列表
                SizedBox(width: 320, child: _buildSupplierList()),
                // 右侧：商品管理区域
                Expanded(child: _buildProductArea()),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildToolbar() {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.accentColor.withOpacity(0.05),
            isDark ? const Color(0xFF2D2D2D) : theme.micaBackgroundColor
          ],
        ),
        border: Border(
            bottom: BorderSide(
                color: theme.resources.dividerStrokeColorDefault, width: 1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.orange, Colors.orange.lighter]),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(FluentIcons.delivery_truck,
                size: 20, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('供应商管理',
                  style: theme.typography.subtitle
                      ?.copyWith(fontWeight: FontWeight.bold)),
              Text('管理供应商及其商品信息',
                  style: theme.typography.caption?.copyWith(
                      color: isDark ? Colors.grey[100] : Colors.grey[130])),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: 180,
            child: TextBox(
              controller: _keywordCtrl,
              placeholder: '搜索供应商',
              onSubmitted: (_) => _handleSearch(),
              suffix: IconButton(
                icon: const Icon(FluentIcons.search, size: 14),
                onPressed: _handleSearch,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Button(onPressed: _handleReset, child: const Text('重置')),
          const SizedBox(width: 12),
          FilledButton(
            onPressed: _handleCreateSupplier,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(FluentIcons.add, size: 14),
                SizedBox(width: 6),
                Text('新增供应商')
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupplierList() {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
        border: Border(
            right: BorderSide(
                color: theme.resources.dividerStrokeColorDefault, width: 1)),
      ),
      child: Consumer<SupplierProvider>(
        builder: (context, provider, _) {
          if (provider.loading && provider.suppliers.isEmpty) {
            return const Center(child: ProgressRing());
          }
          if (provider.suppliers.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(FluentIcons.delivery_truck,
                      size: 48, color: Colors.grey[100]),
                  const SizedBox(height: 12),
                  Text('暂无供应商', style: TextStyle(color: Colors.grey[100])),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: provider.suppliers.length,
            itemBuilder: (context, index) {
              final supplier = provider.suppliers[index];
              final isSelected = _selectedSupplier?.id == supplier.id;
              return _buildSupplierItem(supplier, isSelected, isDark);
            },
          );
        },
      ),
    );
  }

  Widget _buildSupplierItem(Supplier supplier, bool isSelected, bool isDark) {
    final isActive = supplier.status == 1;
    final isUpdating = _updatingSuppliers.contains(supplier.id);

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: HoverButton(
        onPressed: () => _handleSelectSupplier(supplier),
        builder: (context, states) {
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.orange.withOpacity(0.15)
                  : states.isHovered
                      ? (isDark
                          ? Colors.grey[150].withOpacity(0.1)
                          : Colors.grey[30])
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: isSelected
                  ? Border.all(color: Colors.orange.withOpacity(0.5))
                  : null,
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.orange, Colors.orange.lighter]),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      supplier.name.substring(0, 1),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              supplier.name,
                              style: TextStyle(
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                                color: isSelected
                                    ? Colors.orange
                                    : (isDark
                                        ? Colors.white
                                        : const Color(0xFF333333)),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: (isActive ? Colors.green : Colors.grey)
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              isActive ? '启用' : '禁用',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: isActive ? Colors.green : Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      if (supplier.contactPerson != null ||
                          supplier.phone != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            [supplier.contactPerson, supplier.phone]
                                .where((e) => e != null)
                                .join(' · '),
                            style: TextStyle(
                                fontSize: 11, color: Colors.grey[130]),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
                // 操作按钮
                if (isUpdating)
                  const SizedBox(
                      width: 16, height: 16, child: ProgressRing(strokeWidth: 2))
                else
                  DropDownButton(
                    leading: const Icon(FluentIcons.more, size: 14),
                    items: [
                      MenuFlyoutItem(
                        leading: Icon(FluentIcons.edit, size: 14, color: Colors.blue),
                        text: const Text('编辑'),
                        onPressed: () => _handleEditSupplier(supplier),
                      ),
                      MenuFlyoutItem(
                        leading: Icon(
                          isActive ? FluentIcons.cancel : FluentIcons.check_mark,
                          size: 14,
                          color: isActive ? Colors.grey : Colors.green,
                        ),
                        text: Text(isActive ? '禁用' : '启用'),
                        onPressed: () => _handleStatusChange(supplier, !isActive),
                      ),
                      const MenuFlyoutSeparator(),
                      MenuFlyoutItem(
                        leading: Icon(FluentIcons.delete, size: 14, color: Colors.red),
                        text: Text('删除', style: TextStyle(color: Colors.red)),
                        onPressed: () => _handleDeleteSupplier(supplier),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }


  Widget _buildProductArea() {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (_selectedSupplier == null) {
      return Container(
        color: isDark ? const Color(0xFF1F1F1F) : const Color(0xFFF5F7FA),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(FluentIcons.product, size: 64, color: Colors.grey[100]),
              const SizedBox(height: 16),
              Text('请选择一个供应商查看商品',
                  style: TextStyle(color: Colors.grey[100], fontSize: 16)),
            ],
          ),
        ),
      );
    }

    return Container(
      color: isDark ? const Color(0xFF1F1F1F) : const Color(0xFFF5F7FA),
      child: Row(
        children: [
          // 分类列表
          SizedBox(width: 200, child: _buildCategoryList(isDark)),
          // 商品列表
          Expanded(child: _buildProductList(isDark)),
        ],
      ),
    );
  }

  Widget _buildCategoryList(bool isDark) {
    final theme = FluentTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
        border: Border(
            right: BorderSide(
                color: theme.resources.dividerStrokeColorDefault, width: 1)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: theme.resources.dividerStrokeColorDefault,
                      width: 1)),
            ),
            child: Row(
              children: [
                Text('商品分类', style: theme.typography.bodyStrong),
                const Spacer(),
                IconButton(
                  icon: const Icon(FluentIcons.add, size: 14),
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
                        Icon(FluentIcons.folder, size: 36, color: Colors.grey[100]),
                        const SizedBox(height: 8),
                        Text('暂无分类',
                            style:
                                TextStyle(fontSize: 12, color: Colors.grey[100])),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(8),
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

  Widget _buildCategoryItem(
      SupplierCategory category, bool isSelected, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: HoverButton(
        onPressed: () => _handleSelectCategory(category.id),
        builder: (context, states) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.purple.withOpacity(0.15)
                  : states.isHovered
                      ? (isDark
                          ? Colors.grey[150].withOpacity(0.1)
                          : Colors.grey[30])
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Icon(
                  FluentIcons.folder,
                  size: 14,
                  color: isSelected
                      ? Colors.purple
                      : (isDark ? Colors.grey[100] : Colors.grey[130]),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    category.name,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected
                          ? Colors.purple
                          : (isDark ? Colors.white : const Color(0xFF333333)),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (states.isHovered || isSelected) ...[
                  IconButton(
                    icon: Icon(FluentIcons.edit, size: 10, color: Colors.blue),
                    onPressed: () => _handleEditCategory(category),
                  ),
                  IconButton(
                    icon: Icon(FluentIcons.delete, size: 10, color: Colors.red),
                    onPressed: () => _handleDeleteCategory(category),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductList(bool isDark) {
    final theme = FluentTheme.of(context);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
            border: Border(
                bottom: BorderSide(
                    color: theme.resources.dividerStrokeColorDefault, width: 1)),
          ),
          child: Row(
            children: [
              Text('商品列表', style: theme.typography.bodyStrong),
              if (_selectedCategoryId != null) ...[
                const SizedBox(width: 8),
                Consumer<SupplierProvider>(
                  builder: (context, provider, _) {
                    return Text(
                      '(${provider.products.length}个)',
                      style: TextStyle(fontSize: 12, color: Colors.grey[130]),
                    );
                  },
                ),
              ],
              const Spacer(),
              FilledButton(
                onPressed: _selectedCategoryId != null ? _handleAddProduct : null,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(FluentIcons.add, size: 12),
                    SizedBox(width: 4),
                    Text('新增商品', style: TextStyle(fontSize: 12))
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
                      Icon(FluentIcons.product, size: 48, color: Colors.grey[100]),
                      const SizedBox(height: 12),
                      Text('请选择一个分类',
                          style: TextStyle(color: Colors.grey[100])),
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
                      Icon(FluentIcons.product, size: 48, color: Colors.grey[100]),
                      const SizedBox(height: 12),
                      Text('该分类下暂无商品',
                          style: TextStyle(color: Colors.grey[100])),
                    ],
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: provider.products.length,
                itemBuilder: (context, index) =>
                    _buildProductItem(provider.products[index], isDark),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductItem(SupplierProduct product, bool isDark) {
    final theme = FluentTheme.of(context);
    final isActive = product.status == 1;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      backgroundColor: isDark ? const Color(0xFF2D2D2D) : Colors.white,
      borderRadius: BorderRadius.circular(6),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.purple, Colors.purple.lighter]),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                product.name.substring(0, 1),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(product.name, style: theme.typography.bodyStrong),
                    const SizedBox(width: 6),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: (isActive ? Colors.green : Colors.grey)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        isActive ? '启用' : '禁用',
                        style: TextStyle(
                            fontSize: 10,
                            color: isActive ? Colors.green : Colors.grey),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    if (product.unit != null)
                      Text('${product.unit}',
                          style: TextStyle(fontSize: 11, color: Colors.grey[130])),
                    if (product.price != null) ...[
                      if (product.unit != null) const SizedBox(width: 12),
                      Text('¥${product.price!.toStringAsFixed(2)}',
                          style:
                              TextStyle(fontSize: 11, color: Colors.orange)),
                    ],
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(FluentIcons.edit, size: 14, color: Colors.blue),
            onPressed: () => _handleEditProduct(product),
          ),
          IconButton(
            icon: Icon(FluentIcons.delete, size: 14, color: Colors.red),
            onPressed: () => _handleDeleteProduct(product),
          ),
        ],
      ),
    );
  }
}
