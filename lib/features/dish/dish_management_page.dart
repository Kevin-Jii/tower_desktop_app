import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../../core/constants/ui_texts.dart';
import '../../core/constants/error_texts.dart';
import '../../core/widgets/fluent_info_bar.dart';
import '../../core/widgets/fluent_buttons.dart';
import '../auth/permission_gate.dart';
import '../auth/permission_provider.dart';
import '../../core/constants/app_constants.dart';
import 'dish_api.dart';
import 'models.dart';
import '../../core/network/api_client.dart';
import 'providers/store_selector_provider.dart';
import 'providers/dish_category_provider.dart';
import 'providers/dish_list_provider.dart';
import 'dish_category_api.dart';
import '../store/store_api.dart';

class DishManagementPage extends StatefulWidget {
  const DishManagementPage({super.key});
  @override
  State<DishManagementPage> createState() => _DishManagementPageState();
}

class _DishManagementPageState extends State<DishManagementPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StoreSelectorProvider>().initializeStore();
    });
  }

  void _openCreateDish() async {
    final categoryProvider = context.read<DishCategoryProvider>();
    if (categoryProvider.selectedCategory == null) return;
    
    final req = await showDialog<CreateDishRequest>(
      context: context,
      builder: (_) => const DishFormDialog(),
    );
    
    if (req != null) {
      final ok = await context.read<DishListProvider>().createDish(req);
      if (!mounted) return;
      
      if (ok) {
        await FluentInfoBarHelper.showSuccess(
          context,
          UITexts.dishCreateSuccess,
        );
      } else {
        await FluentInfoBarHelper.showError(
          context,
          UITexts.dishCreateFailed,
        );
      }
    }
  }

  void _openBatchReportDialog() async {
    final dishList = context.read<DishListProvider>();
    if (dishList.dishes.isEmpty) {
      await FluentInfoBarHelper.showWarning(
        context,
        '当前分类下没有菜品，请先添加菜品',
      );
      return;
    }

    final bool? success = await showDialog<bool>(
      context: context,
      builder: (_) => BatchReportDialog(dishes: dishList.dishes),
    );

    if (success == true && mounted) {
      await FluentInfoBarHelper.showSuccess(context, '批量报菜成功');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Row(
        children: [
          _buildCategorySidebar(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: FluentTheme.of(context).resources.dividerStrokeColorDefault,
                    width: 1,
                  ),
                ),
              ),
              child: _buildDishArea(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySidebar() {
    return Consumer2<DishCategoryProvider, DishListProvider>(
      builder: (context, categoryProvider, dishList, __) {
        if (categoryProvider.error != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              FluentInfoBarHelper.showError(
                context,
                '${UITexts.dishCategoryError}: ${categoryProvider.error}',
              );
            }
          });
        }

        return Container(
          width: 260,
          decoration: BoxDecoration(
            color: FluentTheme.of(context).micaBackgroundColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      UITexts.dishCategoryTitle,
                      style: FluentTheme.of(context).typography.subtitle,
                    ),
                    const Spacer(),
                    PermissionGate(
                      required: PermissionCodes.dishAdd,
                      child: IconButton(
                        icon: Icon(FluentIcons.add),
                        onPressed: () => _addCategory(categoryProvider),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: _buildCategoryList(categoryProvider, dishList),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoryList(
    DishCategoryProvider categoryProvider,
    DishListProvider dishList,
  ) {
    if (categoryProvider.loading) {
      return const Center(child: ProgressRing());
    }

    if (categoryProvider.categories.isEmpty) {
      return Center(
        child: Text(
          UITexts.dishCategoryEmpty,
          style: FluentTheme.of(context).typography.body,
        ),
      );
    }

    return ListView.builder(
      itemCount: categoryProvider.categories.length,
      itemBuilder: (context, index) {
        final category = categoryProvider.categories[index];
        final isSelected = categoryProvider.selectedCategory?.id == category.id;

        return ListTile.selectable(
          selected: isSelected,
          title: Text(category.name),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(FluentIcons.edit, size: 16),
                onPressed: () => _editCategory(categoryProvider, category),
              ),
              IconButton(
                icon: const Icon(FluentIcons.delete, size: 16),
                onPressed: () => _deleteCategory(categoryProvider, category, dishList),
              ),
            ],
          ),
          onPressed: () => categoryProvider.selectCategory(category),
        );
      },
    );
  }

  Future<void> _addCategory(DishCategoryProvider provider) async {
    final name = await _showCategoryDialog(context, null);
    if (name != null && name.trim().isNotEmpty) {
      final ok = await provider.createCategory(name.trim());
      if (!mounted) return;
      if (!ok) {
        await FluentInfoBarHelper.showError(context, ErrorTexts.createCategory);
      }
    }
  }

  Future<void> _editCategory(
    DishCategoryProvider provider,
    dynamic category,
  ) async {
    final name = await _showCategoryDialog(context, category);
    if (name != null && name.trim().isNotEmpty && name.trim() != category.name) {
      final ok = await provider.updateCategory(category, name.trim());
      if (!mounted) return;
      if (!ok) {
        await FluentInfoBarHelper.showError(context, ErrorTexts.updateCategory);
      }
    }
  }

  Future<void> _deleteCategory(
    DishCategoryProvider provider,
    dynamic category,
    DishListProvider dishList,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text(UITexts.dishCategoryDelete),
        content: const Text(UITexts.dishCategoryDeleteConfirm),
        actions: [
          Button(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(UITexts.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(UITexts.commonOk),
          ),
        ],
      ),
    );

    if (result == true) {
      final ok = await provider.deleteCategory(
        category,
        hasDishes: (cat) {
          final selected = provider.selectedCategory;
          if (selected?.id == cat.id) {
            return dishList.dishes.isNotEmpty;
          }
          return false;
        },
      );
      if (!mounted) return;
      if (!ok) {
        await FluentInfoBarHelper.showError(
          context,
          provider.error ?? ErrorTexts.deleteCategory,
        );
      }
    }
  }

  Future<String?> _showCategoryDialog(
    BuildContext context,
    dynamic editing,
  ) async {
    final controller = TextEditingController(text: editing?.name ?? '');
    
    return await showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        title: Text(editing == null 
            ? UITexts.dishCategoryAdd 
            : UITexts.dishCategoryEdit),
        content: TextBox(
          controller: controller,
          placeholder: '请输入分类名称',
          autofocus: true,
        ),
        actions: [
          Button(
            onPressed: () => Navigator.pop(context),
            child: const Text(UITexts.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text(UITexts.commonOk),
          ),
        ],
      ),
    );
  }

  Widget _buildDishArea() {
    return Consumer3<StoreSelectorProvider, DishCategoryProvider, DishListProvider>(
      builder: (context, storeSelector, categoryProvider, dishList, __) {
        if (dishList.error != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              FluentInfoBarHelper.showError(
                context,
                '${UITexts.dishError}: ${dishList.error}',
              );
            }
          });
        }

        return Column(
          children: [
            _buildToolbar(storeSelector, categoryProvider),
            Expanded(
              child: categoryProvider.selectedCategory == null
                  ? const Center(child: Text('请选择左侧分类'))
                  : dishList.loading
                      ? const Center(child: ProgressRing())
                      : dishList.dishes.isEmpty
                          ? const Center(child: Text(UITexts.dishEmpty))
                          : _buildDishList(dishList.dishes),
            ),
          ],
        );
      },
    );
  }

  Widget _buildToolbar(
    StoreSelectorProvider storeSelector,
    DishCategoryProvider categoryProvider,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: FluentTheme.of(context).micaBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: FluentTheme.of(context).resources.dividerStrokeColorDefault,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            UITexts.dishTitle,
            style: FluentTheme.of(context).typography.subtitle,
          ),
          const SizedBox(width: 16),
          if (storeSelector.isAdmin)
            SizedBox(
              width: 200,
              child: storeSelector.loading
                  ? const ProgressRing()
                  : ComboBox<int>(
                      value: storeSelector.selectedStoreId,
                      placeholder: const Text(UITexts.dishStoreSelectLabel),
                      items: storeSelector.stores
                          .map((s) => ComboBoxItem<int>(
                                value: s.id,
                                child: Text(s.name),
                              ))
                          .toList(),
                      onChanged: (v) {
                        if (v != null) storeSelector.selectStore(v);
                      },
                    ),
            ),
          const Spacer(),
          PermissionGate(
            required: PermissionCodes.dishAdd,
            child: FilledButton(
              onPressed: categoryProvider.selectedCategory == null
                  ? null
                  : _openCreateDish,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(FluentIcons.add, size: 16),
                  SizedBox(width: 8),
                  Text(UITexts.dishAdd),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Button(
            onPressed: _openBatchReportDialog,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(FluentIcons.clipboard_list, size: 16),
                SizedBox(width: 8),
                Text('批量报菜'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDishList(List<Dish> dishes) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: dishes.length,
      itemBuilder: (context, index) {
        final dish = dishes[index];
        final active = (dish.status ?? 1) == 1;

        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            title: Text(dish.name),
            subtitle: dish.price != null
                ? Text('¥${dish.price!.toStringAsFixed(2)}')
                : null,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ToggleSwitch(
                  checked: active,
                  onChanged: (value) => _toggleDishStatus(dish, value),
                ),
                const SizedBox(width: 8),
                PermissionGate(
                  required: PermissionCodes.dishEdit,
                  child: Button(
                    onPressed: () => _editDish(dish),
                    child: const Text(UITexts.dishEdit),
                  ),
                ),
                const SizedBox(width: 8),
                PermissionGate(
                  required: PermissionCodes.dishDelete,
                  child: Button(
                    onPressed: () => _deleteDish(dish),
                    child: const Text(UITexts.dishDelete),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _toggleDishStatus(Dish dish, bool active) async {
    final provider = context.read<DishListProvider>();
    final updated = UpdateDishRequest(status: active ? 1 : 0);
    final ok = await provider.updateDish(dish, updated);
    if (!mounted) return;
    if (!ok) {
      await FluentInfoBarHelper.showError(context, UITexts.dishUpdateFailed);
    }
  }

  Future<void> _editDish(Dish dish) async {
    final updated = await showDialog<UpdateDishRequest>(
      context: context,
      builder: (_) => DishFormDialog(editing: dish),
    );
    if (updated != null) {
      final ok = await context.read<DishListProvider>().updateDish(dish, updated);
      if (!mounted) return;
      if (ok) {
        await FluentInfoBarHelper.showSuccess(context, UITexts.dishUpdateSuccess);
      } else {
        await FluentInfoBarHelper.showError(context, UITexts.dishUpdateFailed);
      }
    }
  }

  Future<void> _deleteDish(Dish dish) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: Text(UITexts.dishDeleteConfirmTitle),
        content: Text('${UITexts.dishDeleteConfirmMessage} "${dish.name}"?'),
        actions: [
          Button(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(UITexts.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(UITexts.commonOk),
          ),
        ],
      ),
    );

    if (result == true) {
      final ok = await context.read<DishListProvider>().deleteDish(dish);
      if (!mounted) return;
      if (ok) {
        await FluentInfoBarHelper.showSuccess(context, UITexts.dishDeleteSuccess);
      } else {
        await FluentInfoBarHelper.showError(context, UITexts.dishDeleteFailed);
      }
    }
  }
}

/// 菜品表单对话框
class DishFormDialog extends StatefulWidget {
  final Dish? editing;
  const DishFormDialog({super.key, this.editing});
  @override
  State<DishFormDialog> createState() => _DishFormDialogState();
}

class _DishFormDialogState extends State<DishFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  bool _status = true;

  @override
  void initState() {
    super.initState();
    if (widget.editing != null) {
      final d = widget.editing!;
      _nameCtrl.text = d.name;
      _descCtrl.text = d.description ?? '';
      _priceCtrl.text = d.price?.toString() ?? '';
      _status = (d.status ?? 1) == 1;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (widget.editing != null) {
      final req = UpdateDishRequest(
        name: _nameCtrl.text.trim(),
        description: _descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim(),
        price: double.tryParse(_priceCtrl.text.trim()),
        status: _status ? 1 : 0,
      );
      Navigator.pop(context, req);
    } else {
      final req = CreateDishRequest(
        name: _nameCtrl.text.trim(),
        description: _descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim(),
        price: double.tryParse(_priceCtrl.text.trim()),
      );
      Navigator.pop(context, req);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text(widget.editing == null ? UITexts.dishAdd : UITexts.dishEdit),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoLabel(
              label: UITexts.dishFormName,
              child: TextBox(
                controller: _nameCtrl,
                placeholder: '请输入菜品名称',
              ),
            ),
            const SizedBox(height: 12),
            InfoLabel(
              label: UITexts.dishFormDesc,
              child: TextBox(
                controller: _descCtrl,
                placeholder: '请输入描述',
                maxLines: 3,
              ),
            ),
            const SizedBox(height: 12),
            InfoLabel(
              label: UITexts.dishFormPrice,
              child: TextBox(
                controller: _priceCtrl,
                placeholder: '请输入价格',
              ),
            ),
            const SizedBox(height: 12),
            Checkbox(
              checked: _status,
              onChanged: (v) => setState(() => _status = v ?? true),
              content: const Text(UITexts.dishFormStatus),
            ),
          ],
        ),
      ),
      actions: [
        Button(
          onPressed: () => Navigator.pop(context),
          child: const Text(UITexts.commonCancel),
        ),
        FilledButton(
          onPressed: _submit,
          child: const Text(UITexts.commonOk),
        ),
      ],
    );
  }
}

/// 批量报菜对话框
class BatchReportDialog extends StatefulWidget {
  final List<Dish> dishes;
  const BatchReportDialog({super.key, required this.dishes});
  @override
  State<BatchReportDialog> createState() => _BatchReportDialogState();
}

class _BatchReportDialogState extends State<BatchReportDialog> {
  final _messageCtrl = TextEditingController();
  final List<Dish> _selectedDishes = [];
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDishes.addAll(widget.dishes);
    _selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    _messageCtrl.dispose();
    super.dispose();
  }

  void _toggleDish(Dish dish) {
    setState(() {
      if (_selectedDishes.contains(dish)) {
        _selectedDishes.remove(dish);
      } else {
        _selectedDishes.add(dish);
      }
    });
  }

  Future<void> _submit() async {
    if (_selectedDishes.isEmpty) {
      await FluentInfoBarHelper.showWarning(context, '请至少选择一个菜品');
      return;
    }

    try {
      final dishApi = context.read<DishApi>();
      final categoryProvider = context.read<DishCategoryProvider>();
      final storeSelector = context.read<StoreSelectorProvider>();

      final success = await dishApi.batchReport(
        dishes: _selectedDishes,
        message: _messageCtrl.text.trim().isEmpty ? null : _messageCtrl.text.trim(),
        category: categoryProvider.selectedCategory?.name ?? '未知分类',
        storeId: storeSelector.selectedStoreId ?? 0,
      );

      if (mounted) {
        Navigator.pop(context, success);
      }
    } catch (e) {
      if (mounted) {
        await FluentInfoBarHelper.showError(context, '批量报菜失败: $e');
        Navigator.pop(context, false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = context.read<DishCategoryProvider>();

    return ContentDialog(
      title: Text('批量报菜 - ${categoryProvider.selectedCategory?.name ?? ""}'),
      content: SizedBox(
        width: 600,
        height: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('已选择 ${_selectedDishes.length} 个菜品（共 ${widget.dishes.length} 个）'),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: widget.dishes.length,
                itemBuilder: (context, index) {
                  final dish = widget.dishes[index];
                  final isSelected = _selectedDishes.contains(dish);
                  return Checkbox(
                    checked: isSelected,
                    onChanged: (_) => _toggleDish(dish),
                    content: Row(
                      children: [
                        Expanded(child: Text(dish.name)),
                        if (dish.price != null)
                          Text('¥${dish.price!.toStringAsFixed(2)}'),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            InfoLabel(
              label: '报菜日期',
              child: DatePicker(
                selected: _selectedDate,
                onChanged: (date) {
                  setState(() => _selectedDate = date);
                },
              ),
            ),
            const SizedBox(height: 16),
            InfoLabel(
              label: '报菜备注（可选）',
              child: TextBox(
                controller: _messageCtrl,
                placeholder: '请输入报菜备注信息',
                maxLines: 3,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Button(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _submit,
          child: const Text('确认报菜'),
        ),
      ],
    );
  }
}

/// DishManagementScope
class DishManagementScope extends StatelessWidget {
  const DishManagementScope({super.key});
  @override
  Widget build(BuildContext context) {
    final client = ApiClient();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StoreSelectorProvider>(
          create: (_) => StoreSelectorProvider(StoreApi(client)),
        ),
        ChangeNotifierProvider<DishCategoryProvider>(
          create: (ctx) => DishCategoryProvider(
              DishCategoryApi(client), ctx.read<StoreSelectorProvider>()),
        ),
        ChangeNotifierProvider<DishListProvider>(
          create: (ctx) => DishListProvider(
              DishApi(client),
              ctx.read<StoreSelectorProvider>(),
              ctx.read<DishCategoryProvider>()),
        ),
      ],
      child: const DishManagementPage(),
    );
  }
}
