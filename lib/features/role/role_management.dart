import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tower_desktop_app/core/widgets/management_template.dart';
import 'package:tower_desktop_app/core/widgets/form_dialog_builder.dart';
import 'package:tower_desktop_app/core/widgets/admin_table.dart';
import 'package:tower_desktop_app/core/network/api_client.dart';
import 'role_models.dart';
import 'role_api.dart';

class RoleManagement extends StatelessWidget {
  const RoleManagement({super.key});

  static final _columns = [
    const AdminTableColumn(width: 80, label: 'ID'),
    const AdminTableColumn(width: 150, label: '角色名'),
    const AdminTableColumn(width: 200, label: '描述'),
    const AdminTableColumn(label: '操作', alignment: Alignment.centerRight),
  ];

  static Future<void> _loadRoles(BuildContext context) async {
    final api = RoleApi(ApiClient());
    await context.read<RoleProvider>().loadData(() async {
      return await api.getRoles();
    });
  }

  static Widget _buildRow(RoleItem role, int index) {
    return Row(
      children: [
        SizedBox(width: 80, child: Text(role.id.toString())),
        SizedBox(width: 150, child: Text(role.name)),
        SizedBox(width: 200, child: Text(role.description ?? '')),
        _buildActions(role),
      ],
    );
  }

  static Widget _buildActions(RoleItem role) {
    return Consumer<RoleProvider>(
      builder: (context, provider, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => _handleEdit(context, role),
              child: const Text('编辑'),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () => _handleDelete(context, role),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('删除'),
            ),
          ],
        );
      },
    );
  }

  static Future<void> _handleCreate(BuildContext context) async {
    const fields = [
      FormFieldConfig(key: 'name', label: '角色名', required: true, maxLength: 50),
      FormFieldConfig(key: 'key', label: '权限标识', required: true, maxLength: 100),
      FormFieldConfig(key: 'description', label: '描述', maxLength: 200),
    ];

    final result = await FormDialog.show(context, title: '新建角色', fields: fields);
    if (result != null) {
      try {
        final api = RoleApi(ApiClient());
        await api.createRole(
          CreateRoleRequest(
            name: result['name']!,
            key: result['key']!,
            description: result['description'],
          ),
        );
        await _loadRoles(context);

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

  static Future<void> _handleEdit(BuildContext context, RoleItem role) async {
    final fields = [
      FormFieldConfig(key: 'name', label: '角色名', initialValue: role.name, required: true),
      FormFieldConfig(key: 'key', label: '权限标识', initialValue: role.key, required: true),
      FormFieldConfig(key: 'description', label: '描述', initialValue: role.description ?? ''),
    ];

    final result = await FormDialog.show(context, title: '编辑角色', fields: fields);
    if (result != null) {
      try {
        final api = RoleApi(ApiClient());
        await api.updateRole(
          role.id,
          UpdateRoleRequest(
            name: result['name']!,
            key: result['key']!,
            description: result['description'],
          ),
        );
        await _loadRoles(context);

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

  static Future<void> _handleDelete(BuildContext context, RoleItem role) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除角色 "${role.name}" 吗?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('取消')),
          ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('删除')),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        final api = RoleApi(ApiClient());
        await api.deleteRole(role.id);
        await _loadRoles(context);

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
      create: (_) => RoleProvider()..loadData(() async {
        final api = RoleApi(ApiClient());
        final response = await api.getRoles();
        return response.list;
      }),
      child: Builder(
        builder: (context) {
          return ManagementTemplate<RoleItem>(
            title: '角色管理',
            createPermission: 'system:role:add',
            onCreate: () => _handleCreate(context),
            columns: _columns,
            rowBuilder: _buildRow,
            headerBuilder: (context) => TextField(
              decoration: const InputDecoration(
                hintText: '搜索角色名',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _loadRoles(context),
            ),
          );
        },
      ),
    );
  }
}

class RoleProvider extends ChangeNotifier with ListProviderMixin<RoleItem> {}
