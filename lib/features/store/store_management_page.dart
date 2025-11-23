import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/fluent_info_bar.dart';
import 'store_provider.dart';
import 'models.dart';
import 'store_form_dialog.dart';

class StoreManagementPage extends StatefulWidget {
  const StoreManagementPage({super.key});

  @override
  State<StoreManagementPage> createState() => _StoreManagementPageState();
}

class _StoreManagementPageState extends State<StoreManagementPage> {
  final Set<int> _updatingStores = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StoreProvider>().loadStores();
    });
  }

  void _handleCreate() async {
    final result = await showDialog<CreateStoreRequest>(
      context: context,
      builder: (ctx) => const StoreFormDialog(),
    );
    if (result != null && mounted) {
      final success = await context.read<StoreProvider>().createStore(result);
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '创建成功');
      } else if (mounted) {
        final err = context.read<StoreProvider>().error ?? '创建失败';
        await FluentInfoBarHelper.showError(context, err);
      }
    }
  }

  void _handleEdit(Store store) async {
    final result = await showDialog<UpdateStoreRequest>(
      context: context,
      builder: (ctx) => StoreFormDialog(store: store),
    );
    if (result != null && mounted) {
      final success =
          await context.read<StoreProvider>().updateStore(store.id, result);
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '更新成功');
      } else if (mounted) {
        final err = context.read<StoreProvider>().error ?? '更新失败';
        await FluentInfoBarHelper.showError(context, err);
      }
    }
  }

  void _handleDelete(Store store) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除门店 "${store.name}" 吗？'),
        actions: [
          Button(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    if (result == true && mounted) {
      final success = await context.read<StoreProvider>().deleteStore(store.id);
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '删除成功');
      } else if (mounted) {
        final err = context.read<StoreProvider>().error ?? '删除失败';
        await FluentInfoBarHelper.showError(context, err);
      }
    }
  }

  void _handleStatusChange(Store store, bool value) async {
    setState(() => _updatingStores.add(store.id));

    final newStatus = value ? 1 : 0;
    final req = UpdateStoreRequest(status: newStatus);

    final success =
        await context.read<StoreProvider>().updateStore(store.id, req);

    if (mounted) {
      setState(() => _updatingStores.remove(store.id));
    }

    if (success && mounted) {
      await FluentInfoBarHelper.showSuccess(context, '状态已更新');
    } else if (mounted) {
      final err = context.read<StoreProvider>().error ?? '状态更新失败';
      await FluentInfoBarHelper.showError(context, err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Column(
        children: [
          _buildToolbar(),
          Expanded(child: _buildContent()),
          _buildPagination(),
        ],
      ),
    );
  }

  Widget _buildToolbar() {
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
            '门店管理',
            style: FluentTheme.of(context).typography.subtitle,
          ),
          const Spacer(),
          FilledButton(
            onPressed: _handleCreate,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(FluentIcons.add, size: 16),
                SizedBox(width: 8),
                Text('新增门店'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Consumer<StoreProvider>(
      builder: (context, provider, _) {
        if (provider.loading) {
          return const Center(child: ProgressRing());
        }

        if (provider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(provider.error!),
                const SizedBox(height: 16),
                Button(
                  onPressed: () => provider.loadStores(),
                  child: const Text('重试'),
                ),
              ],
            ),
          );
        }

        if (provider.stores.isEmpty) {
          return const Center(child: Text('暂无门店数据'));
        }

        return _buildStoreList(provider.stores);
      },
    );
  }

  Widget _buildStoreList(List<Store> stores) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: stores.length,
      itemBuilder: (context, index) {
        final store = stores[index];
        final isActive = store.status == 1;
        final isUpdating = _updatingStores.contains(store.id);

        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            title: Text(
              store.name,
              style: FluentTheme.of(context).typography.bodyStrong,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (store.address != null && store.address!.isNotEmpty)
                  Text('地址: ${store.address}'),
                if (store.contactPerson != null &&
                    store.contactPerson!.isNotEmpty)
                  Text('负责人: ${store.contactPerson}'),
                if (store.phone != null && store.phone!.isNotEmpty)
                  Text('电话: ${store.phone}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isUpdating)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: ProgressRing(strokeWidth: 2),
                  )
                else
                  ToggleSwitch(
                    checked: isActive,
                    onChanged: (value) => _handleStatusChange(store, value),
                  ),
                const SizedBox(width: 8),
                Button(
                  onPressed: () => _handleEdit(store),
                  child: const Text('编辑'),
                ),
                const SizedBox(width: 8),
                Button(
                  onPressed: () => _handleDelete(store),
                  child: const Text('删除'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPagination() {
    return Consumer<StoreProvider>(
      builder: (context, provider, _) {
        if (provider.stores.isEmpty) {
          return const SizedBox.shrink();
        }

        final totalPages = (provider.total / provider.pageSize).ceil();
        final currentPage = provider.page;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: FluentTheme.of(context).micaBackgroundColor,
            border: Border(
              top: BorderSide(
                color:
                    FluentTheme.of(context).resources.dividerStrokeColorDefault,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('共 ${provider.total} 条记录'),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(FluentIcons.chevron_left),
                    onPressed: currentPage > 1
                        ? () => provider.loadStores(page: currentPage - 1)
                        : null,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('$currentPage / $totalPages'),
                  ),
                  IconButton(
                    icon: const Icon(FluentIcons.chevron_right),
                    onPressed: currentPage < totalPages
                        ? () => provider.loadStores(page: currentPage + 1)
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
