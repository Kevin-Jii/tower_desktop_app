import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tower_desktop_app/core/widgets/management_template.dart';
import 'package:tower_desktop_app/core/widgets/form_dialog_builder.dart';
import 'package:tower_desktop_app/core/widgets/admin_table.dart';
import 'package:tower_desktop_app/core/network/api_client.dart';
import 'package:tower_desktop_app/core/network/base_provider.dart';
import 'package:tower_desktop_app/core/constants/ui_texts.dart';
import 'package:tower_desktop_app/core/network/api_response.dart';
import 'models.dart';
import 'store_api.dart';

class StoreManagement extends StatelessWidget {
  const StoreManagement({super.key});

  static final _columns = <AdminTableColumn>[
    const AdminTableColumn(width: 80, label: 'ID'),
    const AdminTableColumn(width: 150, label: '门店名称'),
    const AdminTableColumn(width: 180, label: '地址'),
    const AdminTableColumn(width: 200, label: '联系电话'),
    const AdminTableColumn(width: 100, label: '状态'),
    const AdminTableColumn(label: '操作', alignment: Alignment.centerRight),
  ];

  static Future<void> _loadStores(BuildContext context) async {
    final api = StoreApi(ApiClient());
    await context.read<StoreProvider>().loadData(() async {
      final response = await api.getStores();
      return ApiResponse<List<Store>>(
          code: 200, message: 'ok', data: response.list);
    });
  }

  static Widget _buildRow(Store store, int index) {
    return Row(
      children: [
        SizedBox(width: 80, child: Text(store.id.toString())),
        SizedBox(width: 150, child: Text(store.name)),
        SizedBox(width: 180, child: Text(store.address ?? '')),
        SizedBox(width: 200, child: Text(store.phone ?? '')),
        SizedBox(width: 100, child: _buildStatusTag(store.status == 1)),
        _buildActions(store),
      ],
    );
  }

  static Widget _buildStatusTag(bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: active
            ? Colors.green.withOpacity(0.1)
            : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        active ? '启用' : '禁用',
        style: TextStyle(
          color: active ? Colors.green : Colors.red,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static Widget _buildActions(Store store) {
    return Consumer<StoreProvider>(
      builder: (context, provider, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Switch(
              value: store.status == 1,
              onChanged: (value) => _handleStatusChange(context, store, value),
            ),
            IconButton(
              icon: const Icon(Icons.edit_outlined, size: 18),
              onPressed: () => _handleEdit(context, store),
            ),
            IconButton(
              icon:
                  const Icon(Icons.delete_outline, size: 18, color: Colors.red),
              onPressed: () => _handleDelete(context, store),
            ),
          ],
        );
      },
    );
  }

  static Future<void> _handleCreate(BuildContext context) async {
    const fields = <FormFieldConfig>[
      FormFieldConfig(
          key: 'name', label: '门店名称', required: true, maxLength: 50),
      FormFieldConfig(key: 'address', label: '地址', maxLength: 200),
      FormFieldConfig(
          key: 'phone',
          label: '联系电话',
          keyboardType: TextInputType.phone,
          maxLength: 20),
    ];

    final result =
        await FormDialog.show(context, title: '新建门店', fields: fields);
    if (result != null) {
      try {
        final api = StoreApi(ApiClient());
        await api.createStore(
          CreateStoreRequest(
            name: result['name']!,
            address: result['address'],
            phone: result['phone'],
          ),
        );
        await _loadStores(context);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('创建成功')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('创建失败: $e'), backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  static Future<void> _handleEdit(BuildContext context, Store store) async {
    final fields = <FormFieldConfig>[
      FormFieldConfig(
          key: 'name', label: '门店名称', initialValue: store.name, required: true),
      FormFieldConfig(
          key: 'address', label: '地址', initialValue: store.address ?? ''),
      FormFieldConfig(
          key: 'phone', label: '联系电话', initialValue: store.phone ?? ''),
    ];

    final result =
        await FormDialog.show(context, title: '编辑门店', fields: fields);
    if (result != null) {
      try {
        final api = StoreApi(ApiClient());
        await api.updateStore(
          store.id,
          UpdateStoreRequest(
            name: result['name']!,
            address: result['address'],
            phone: result['phone'],
          ),
        );
        await _loadStores(context);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('更新成功')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('更新失败: $e'), backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  static Future<void> _handleStatusChange(
      BuildContext context, Store store, bool value) async {
    try {
      final api = StoreApi(ApiClient());
      await api.updateStore(
          store.id, UpdateStoreRequest(status: value ? 1 : 0));
      await _loadStores(context);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('状态已更新')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('状态更新失败: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  static Future<void> _handleDelete(BuildContext context, Store store) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除门店 "${store.name}" 吗?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('取消')),
          ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('删除')),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        final api = StoreApi(ApiClient());
        await api.deleteStore(store.id);
        await _loadStores(context);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('删除成功')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('删除失败: $e'), backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StoreProvider()
        ..loadData(() async {
          final api = StoreApi(ApiClient());
          final response = await api.getStores();
          return ApiResponse<List<Store>>(
              code: 200, message: 'ok', data: response.list);
        }),
      child: Builder(
        builder: (context) {
          return ManagementTemplate<Store>(
            title: '门店管理',
            createPermission: 'system:store:add',
            onCreate: () => _handleCreate(context),
            columns: _columns,
            rowBuilder: _buildRow,
            provider: Consumer<StoreProvider>(
              builder: (context, provider, child) {
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
                          onPressed: () => _loadStores(context),
                          child: Text(UITexts.commonRetry),
                        ),
                      ],
                    ),
                  );
                }

                if (provider.items.isEmpty) {
                  return Center(child: Text(UITexts.commonNoData));
                }

                return AdminTable<Store>(
                  columns: _columns,
                  data: provider.items,
                  rowBuilder: _buildRow,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class StoreProvider extends ChangeNotifier with ListProviderMixin<Store> {}
