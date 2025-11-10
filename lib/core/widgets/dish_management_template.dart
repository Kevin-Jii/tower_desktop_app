import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../network/base_provider.dart';
import './admin_table.dart';
import './management_template.dart';

/// 菜品管理专用模板（左侧分类+右侧菜品）
class DishManagementTemplate extends StatelessWidget {
  final List<dynamic> categories;
  final Function(dynamic category) onSelectCategory;
  final dynamic selectedCategory;
  final VoidCallback onCreateCategory;
  final List<AdminTableColumn> dishColumns;
  final Widget Function(dynamic item, int index) dishRowBuilder;
  final VoidCallback onCreateDish;
  final VoidCallback onBatchReport;
  final Widget? header;

  const DishManagementTemplate({
    super.key,
    required this.categories,
    required this.onSelectCategory,
    required this.selectedCategory,
    required this.onCreateCategory,
    required this.dishColumns,
    required this.dishRowBuilder,
    required this.onCreateDish,
    required this.onBatchReport,
    this.header,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildCategorySidebar(context),
        Expanded(child: _buildDishArea(context)),
      ],
    );
  }

  Widget _buildCategorySidebar(BuildContext context) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text(
                  '菜品分类',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.blue),
                  onPressed: onCreateCategory,
                  tooltip: '新增分类',
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (_, i) {
                final category = categories[i];
                final selected = selectedCategory?.id == category.id;
                return ListTile(
                  selected: selected,
                  title: Text(category.name),
                  onTap: () => onSelectCategory(category),
                  selectedColor: Colors.blue,
                  selectedTileColor: Colors.blue.withOpacity(0.1),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDishArea(BuildContext context) {
    return Column(
      children: [
        _buildDishHeader(context),
        Expanded(child: _buildDishContent(context)),
      ],
    );
  }

  Widget _buildDishHeader(BuildContext context) {
    return Consumer<ListProviderMixin>(
      builder: (context, provider, child) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)],
          ),
          child: Row(
            children: [
              const Text(
                '菜品列表',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: selectedCategory == null ? null : onCreateDish,
                icon: const Icon(Icons.add),
                label: const Text('新增菜品'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: provider.items.isEmpty ? null : onBatchReport,
                icon: const Icon(Icons.assignment_add),
                label: const Text('批量报菜'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDishContent(BuildContext context) {
    return Consumer<ListProviderMixin>(
      builder: (context, provider, child) {
        if (selectedCategory == null) {
          return const Center(
            child: Text('请选择左侧分类'),
          );
        }

        if (provider.loading && provider.items.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('加载失败: ${provider.error}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {}, // 需要实现加载逻辑
                  child: const Text('重试'),
                ),
              ],
            ),
          );
        }

        if (provider.items.isEmpty) {
          return const Center(child: Text('暂无菜品'));
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: AdminTable(
            columns: dishColumns,
            data: provider.items,
            rowBuilder: dishRowBuilder,
          ),
        );
      },
    );
  }
}
