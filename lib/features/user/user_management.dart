import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/network/api_response.dart';
import '../../core/network/base_provider.dart';
import 'user_api.dart';
import 'models.dart';
import '../../core/widgets/management_template.dart';
import '../../core/widgets/form_dialog_builder.dart';
import '../../core/widgets/admin_table.dart';
import '../../features/auth/permission_gate.dart';
import '../store/store_api.dart';
import '../../core/network/api_client.dart';
import '../../core/constants/ui_texts.dart';

class UserProvider extends ChangeNotifier with ListProviderMixin<User> {}

class UserManagement extends StatelessWidget {
  const UserManagement({super.key});

  static final _columns = <AdminTableColumn>[
    const AdminTableColumn(width: 80, label: 'ID'),
    const AdminTableColumn(width: 150, label: '用户名'),
    const AdminTableColumn(width: 150, label: '昵称'),
    const AdminTableColumn(width: 150, label: '手机号'),
    const AdminTableColumn(width: 100, label: '状态'),
    const AdminTableColumn(label: '操作', alignment: Alignment.centerRight),
  ];

  static Future<void> _loadUsers(BuildContext context) async {
    final storeApi = StoreApi(ApiClient());
    final userApi = UserApi(ApiClient());
    final stores = await storeApi.listStores();

    // 创建一个 storeId 到 storeName 的映射
    final storeNames = {for (var store in stores) store.id: store.name};

    await context.read<UserProvider>().loadData(() async {
      final response = await userApi.getUsers();

      return ApiResponse<List<User>>(
        code: 200,
        message: '加载成功',
        data: response.list
            .map((u) => u.copyWith(storeName: storeNames[u.storeId]))
            .toList(),
      );
    });
  }

  static Widget _buildRow(User user, int index) {
    return Row(
      children: [
        SizedBox(width: 80, child: Text(user.id.toString())),
        SizedBox(width: 150, child: Text(user.username)),
        SizedBox(width: 150, child: Text(user.nickname ?? '')),
        SizedBox(width: 150, child: Text(user.phone ?? '无')),
        SizedBox(width: 100, child: _buildStatusTag(user.status == 1)),
        _buildActions(user),
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

  static Widget _buildActions(User user) {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            PermissionGate(
              required: 'system:user:edit',
              child: IconButton(
                icon: const Icon(Icons.edit_outlined, size: 18),
                onPressed: () => _handleEdit(context, user),
              ),
            ),
            PermissionGate(
              required: 'system:user:delete',
              child: IconButton(
                icon: const Icon(Icons.delete_outline,
                    size: 18, color: Colors.red),
                onPressed: () => _handleDelete(context, user),
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<void> _handleCreate(BuildContext context) async {
    const fields = <FormFieldConfig>[
      FormFieldConfig(
          key: 'username', label: '用户名', required: true, maxLength: 50),
      FormFieldConfig(
          key: 'password', label: '密码', required: true, maxLength: 50),
      FormFieldConfig(key: 'nickname', label: '昵称', maxLength: 50),
      FormFieldConfig(
          key: 'phone',
          label: '手机号',
          keyboardType: TextInputType.phone,
          maxLength: 11),
      FormFieldConfig(
          key: 'email',
          label: '邮箱',
          keyboardType: TextInputType.emailAddress,
          maxLength: 100),
    ];

    final result =
        await FormDialog.show(context, title: '新建用户', fields: fields);
    if (result != null) {
      try {
        final api = UserApi(ApiClient());
        await api.createUser(
          CreateUserRequest(
            username: result['username']!,
            password: result['password']!,
            phone: result['phone'] ?? '',
            nickname: result['nickname'],
            email: result['email'],
            status: 1, // 默认启用
          ),
        );
        await _loadUsers(context);

        if (context.mounted) {
          _showSuccessMessage(context, '创建成功');
        }
      } catch (e) {
        if (context.mounted) {
          _showErrorMessage(context, '创建失败: $e');
        }
      }
    }
  }

  static Future<void> _handleEdit(BuildContext context, User user) async {
    final fields = <FormFieldConfig>[
      FormFieldConfig(
          key: 'username',
          label: '用户名',
          initialValue: user.username,
          required: true),
      FormFieldConfig(
          key: 'nickname', label: '昵称', initialValue: user.nickname ?? ''),
      FormFieldConfig(
          key: 'phone', label: '手机号', initialValue: user.phone ?? ''),
      FormFieldConfig(
          key: 'email',
          label: '邮箱',
          initialValue: user.email ?? '',
          keyboardType: TextInputType.emailAddress),
      FormFieldConfig(key: 'password', label: '新密码(留空不修改)', maxLength: 50),
    ];

    final result = await FormDialog.show(
      context,
      title: '编辑用户',
      fields: fields,
      initialData: user.toJson(),
    );
    if (result != null) {
      try {
        final api = UserApi(ApiClient());
        await api.updateUser(
          user.id,
          UpdateUserRequest(
            nickname: result['nickname'],
            phone: result['phone'],
            email: result['email'],
            password: result['password']?.isNotEmpty == true
                ? result['password']
                : null,
          ),
        );
        await _loadUsers(context);

        if (context.mounted) {
          _showSuccessMessage(context, '更新成功');
        }
      } catch (e) {
        if (context.mounted) {
          _showErrorMessage(context, '更新失败: $e');
        }
      }
    }
  }

  static Future<void> _handleDelete(BuildContext context, User user) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除用户 "${user.username}" 吗?'),
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
        final api = UserApi(ApiClient());
        await api.deleteUser(user.id);
        await _loadUsers(context);

        if (context.mounted) {
          _showSuccessMessage(context, '删除成功');
        }
      } catch (e) {
        if (context.mounted) {
          _showErrorMessage(context, '删除失败: $e');
        }
      }
    }
  }

  static void _showSuccessMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static void _showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: Builder(
        builder: (context) {
          return ManagementTemplate<User>(
            title: '用户管理',
            createPermission: 'system:user:add',
            onCreate: () => _handleCreate(context),
            columns: _columns,
            rowBuilder: _buildRow,
            provider: Consumer<UserProvider>(
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
                          onPressed: () => _loadUsers(context),
                          child: const Text(UITexts.commonRetry),
                        ),
                      ],
                    ),
                  );
                }

                if (provider.items.isEmpty) {
                  return const Center(child: Text(UITexts.commonNoData));
                }

                return AdminTable<User>(
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
