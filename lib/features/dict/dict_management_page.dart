import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/fluent_info_bar.dart';
import '../../core/network/api_client.dart';
import 'dict_provider.dart';
import 'dict_api.dart';
import 'dict_repository.dart';
import 'dict_type_form_dialog.dart';
import 'dict_data_form_dialog.dart';
import 'models.dart';

class DictManagementPage extends StatefulWidget {
  const DictManagementPage({super.key});

  @override
  State<DictManagementPage> createState() => _DictManagementPageState();
}

class _DictManagementPageState extends State<DictManagementPage> {
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DictProvider>().loadTypes();
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _handleSearch() {
    context.read<DictProvider>().loadTypes(keyword: _searchCtrl.text.trim());
  }

  // ============= 字典类型操作 =============

  void _openCreateType() async {
    final req = await showDialog<CreateDictTypeRequest>(
      context: context,
      builder: (_) => const DictTypeFormDialog(),
    );
    if (req != null && mounted) {
      final ok = await context.read<DictProvider>().createType(req);
      if (mounted) {
        if (ok) {
          await FluentInfoBarHelper.showSuccess(context, '字典类型创建成功');
        } else {
          await FluentInfoBarHelper.showError(context, '创建失败');
        }
      }
    }
  }

  void _openEditType(DictType type) async {
    final req = await showDialog<UpdateDictTypeRequest>(
      context: context,
      builder: (_) => DictTypeFormDialog(editing: type),
    );
    if (req != null && mounted) {
      final ok = await context.read<DictProvider>().updateType(type.id, req);
      if (mounted) {
        if (ok) {
          await FluentInfoBarHelper.showSuccess(context, '更新成功');
        } else {
          await FluentInfoBarHelper.showError(context, '更新失败');
        }
      }
    }
  }

  void _deleteType(DictType type) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => ContentDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除字典类型 "${type.name}" 吗？\n删除后该类型下的所有字典数据也将被删除。'),
        actions: [
          Button(onPressed: () => Navigator.pop(ctx, false), child: const Text('取消')),
          FilledButton(
            style: ButtonStyle(backgroundColor: ButtonState.all(Colors.red)),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (confirm == true && mounted) {
      final ok = await context.read<DictProvider>().deleteType(type.id);
      if (mounted) {
        if (ok) {
          await FluentInfoBarHelper.showSuccess(context, '删除成功');
        } else {
          await FluentInfoBarHelper.showError(context, '删除失败');
        }
      }
    }
  }

  // ============= 字典数据操作 =============

  void _openCreateData() async {
    final selectedType = context.read<DictProvider>().selectedType;
    if (selectedType == null) return;

    final req = await showDialog<CreateDictDataRequest>(
      context: context,
      builder: (_) => DictDataFormDialog(typeCode: selectedType.code),
    );
    if (req != null && mounted) {
      final ok = await context.read<DictProvider>().createData(req);
      if (mounted) {
        if (ok) {
          await FluentInfoBarHelper.showSuccess(context, '字典数据创建成功');
        } else {
          await FluentInfoBarHelper.showError(context, '创建失败');
        }
      }
    }
  }

  void _openEditData(DictData data) async {
    final selectedType = context.read<DictProvider>().selectedType;
    if (selectedType == null) return;

    final req = await showDialog<UpdateDictDataRequest>(
      context: context,
      builder: (_) => DictDataFormDialog(typeCode: selectedType.code, editing: data),
    );
    if (req != null && mounted) {
      final ok = await context.read<DictProvider>().updateData(data.id, req);
      if (mounted) {
        if (ok) {
          await FluentInfoBarHelper.showSuccess(context, '更新成功');
        } else {
          await FluentInfoBarHelper.showError(context, '更新失败');
        }
      }
    }
  }

  void _deleteData(DictData data) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => ContentDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除字典数据 "${data.label}" 吗？'),
        actions: [
          Button(onPressed: () => Navigator.pop(ctx, false), child: const Text('取消')),
          FilledButton(
            style: ButtonStyle(backgroundColor: ButtonState.all(Colors.red)),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (confirm == true && mounted) {
      final ok = await context.read<DictProvider>().deleteData(data.id);
      if (mounted) {
        if (ok) {
          await FluentInfoBarHelper.showSuccess(context, '删除成功');
        } else {
          await FluentInfoBarHelper.showError(context, '删除失败');
        }
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
                // 左侧：字典类型列表
                SizedBox(width: 320, child: _buildTypeList()),
                // 分隔线
                Container(width: 1, color: FluentTheme.of(context).resources.dividerStrokeColorDefault),
                // 右侧：字典数据列表
                Expanded(child: _buildDataList()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final theme = FluentTheme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [theme.accentColor.withOpacity(0.05), theme.micaBackgroundColor],
        ),
        border: Border(bottom: BorderSide(color: theme.resources.dividerStrokeColorDefault, width: 1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.purple, Colors.purple.lighter]),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.purple.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: const Icon(FluentIcons.dictionary, size: 24, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('字典管理', style: theme.typography.title?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Text('管理系统字典类型和数据', style: theme.typography.caption?.copyWith(color: Colors.grey[130])),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildTypeList() {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      color: isDark ? const Color(0xFF1F1F1F) : Colors.grey[10],
      child: Column(
        children: [
          // 搜索和新增
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextBox(
                        controller: _searchCtrl,
                        placeholder: '搜索字典类型...',
                        onSubmitted: (_) => _handleSearch(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(FluentIcons.search, size: 16),
                      onPressed: _handleSearch,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _openCreateType,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FluentIcons.add, size: 14),
                        SizedBox(width: 6),
                        Text('新增字典类型'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          // 类型列表
          Expanded(
            child: Consumer<DictProvider>(
              builder: (context, provider, _) {
                if (provider.loading) {
                  return const Center(child: ProgressRing());
                }
                if (provider.types.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FluentIcons.dictionary, size: 48, color: Colors.grey[100]),
                        const SizedBox(height: 12),
                        Text('暂无字典类型', style: TextStyle(color: Colors.grey[100])),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  itemCount: provider.types.length,
                  itemBuilder: (context, index) {
                    final type = provider.types[index];
                    final isSelected = provider.selectedType?.id == type.id;
                    return _buildTypeItem(type, isSelected, isDark);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeItem(DictType type, bool isSelected, bool isDark) {
    final isActive = type.status == 1;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: HoverButton(
        onPressed: () => context.read<DictProvider>().selectType(type),
        builder: (context, states) {
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.purple.withOpacity(0.15)
                  : states.isHovered
                      ? (isDark ? Colors.grey[150].withOpacity(0.1) : Colors.white)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: isSelected ? Border.all(color: Colors.purple.withOpacity(0.5)) : null,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              type.name,
                              style: TextStyle(
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                color: isSelected ? Colors.purple : null,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: (isActive ? Colors.green : Colors.grey).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              isActive ? '启用' : '禁用',
                              style: TextStyle(fontSize: 10, color: isActive ? Colors.green : Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        type.code,
                        style: TextStyle(fontSize: 12, color: Colors.grey[130], fontFamily: 'monospace'),
                      ),
                    ],
                  ),
                ),
                if (states.isHovered || isSelected) ...[
                  IconButton(
                    icon: Icon(FluentIcons.edit, size: 14, color: Colors.teal),
                    onPressed: () => _openEditType(type),
                  ),
                  IconButton(
                    icon: Icon(FluentIcons.delete, size: 14, color: Colors.red),
                    onPressed: () => _deleteType(type),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDataList() {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Consumer<DictProvider>(
      builder: (context, provider, _) {
        final selectedType = provider.selectedType;

        if (selectedType == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FluentIcons.list, size: 64, color: Colors.grey[80]),
                const SizedBox(height: 16),
                Text('请选择左侧的字典类型', style: TextStyle(fontSize: 16, color: Colors.grey[100])),
                const SizedBox(height: 8),
                Text('选择后可查看和管理该类型下的字典数据', style: TextStyle(color: Colors.grey[130])),
              ],
            ),
          );
        }

        return Column(
          children: [
            // 数据列表头部
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
                border: Border(bottom: BorderSide(color: theme.resources.dividerStrokeColorDefault)),
              ),
              child: Row(
                children: [
                  Icon(FluentIcons.dictionary, size: 20, color: Colors.purple),
                  const SizedBox(width: 8),
                  Text(selectedType.name, style: theme.typography.bodyStrong),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      selectedType.code,
                      style: TextStyle(fontSize: 12, color: Colors.purple, fontFamily: 'monospace'),
                    ),
                  ),
                  const Spacer(),
                  FilledButton(
                    onPressed: _openCreateData,
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(FluentIcons.add, size: 14),
                        SizedBox(width: 6),
                        Text('新增数据'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // 数据列表
            Expanded(
              child: provider.dataLoading
                  ? const Center(child: ProgressRing())
                  : provider.dataList.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(FluentIcons.database, size: 48, color: Colors.grey[100]),
                              const SizedBox(height: 12),
                              Text('暂无字典数据', style: TextStyle(color: Colors.grey[100])),
                              const SizedBox(height: 16),
                              FilledButton(
                                onPressed: _openCreateData,
                                child: const Text('添加第一条数据'),
                              ),
                            ],
                          ),
                        )
                      : _buildDataTable(provider.dataList, isDark),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDataTable(List<DictData> dataList, bool isDark) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        final data = dataList[index];
        final isActive = data.status == 1;

        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: isDark ? Colors.grey[100].withOpacity(0.2) : Colors.grey[40]!),
          ),
          child: Row(
            children: [
              // 排序
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey[30],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text('${data.sort}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[130])),
              ),
              const SizedBox(width: 16),
              // 标签和值
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(data.label, style: const TextStyle(fontWeight: FontWeight.w600)),
                        if (data.isDefault) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text('默认', style: TextStyle(fontSize: 10, color: Colors.orange)),
                          ),
                        ],
                        if (data.listClass != null && data.listClass!.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          _buildListClassBadge(data.listClass!),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '值: ${data.value}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[130], fontFamily: 'monospace'),
                    ),
                  ],
                ),
              ),
              // 状态
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (isActive ? Colors.green : Colors.grey).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  isActive ? '启用' : '禁用',
                  style: TextStyle(fontSize: 11, color: isActive ? Colors.green : Colors.grey),
                ),
              ),
              const SizedBox(width: 16),
              // 操作
              IconButton(
                icon: Icon(FluentIcons.edit, size: 16, color: Colors.teal),
                onPressed: () => _openEditData(data),
              ),
              IconButton(
                icon: Icon(FluentIcons.delete, size: 16, color: Colors.red),
                onPressed: () => _deleteData(data),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListClassBadge(String listClass) {
    Color color;
    switch (listClass) {
      case 'success':
        color = Colors.green;
        break;
      case 'info':
        color = Colors.blue;
        break;
      case 'warning':
        color = Colors.orange;
        break;
      case 'danger':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(listClass, style: TextStyle(fontSize: 10, color: color)),
    );
  }
}

/// 字典管理页面入口（带 Provider）
class DictManagementScope extends StatelessWidget {
  const DictManagementScope({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DictProvider(DictRepository(DictApi(ApiClient()))),
      child: const DictManagementPage(),
    );
  }
}
