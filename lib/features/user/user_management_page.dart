import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/fluent_info_bar.dart';
import 'user_provider.dart';
import 'models.dart';
import 'user_form_dialog.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  // 超级管理员用户ID（通常是1）或用户名
  static const int superAdminId = 1;
  static const String superAdminUsername = 'admin';
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().loadUsers();
    });
  }
  
  /// 检查是否是超级管理员
  bool _isSuperAdmin(User user) {
    return user.id == superAdminId || user.username == superAdminUsername;
  }

  void _handleCreate() async {
    final result = await showDialog<CreateUserRequest>(
      context: context,
      builder: (ctx) => const UserFormDialog(),
    );
    if (result != null && mounted) {
      final success = await context.read<UserProvider>().createUser(result);
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '用户创建成功');
      } else if (mounted) {
        final err = context.read<UserProvider>().error ?? '创建失败';
        await FluentInfoBarHelper.showError(context, err);
      }
    }
  }

  void _handleEdit(User user) async {
    // 超级管理员保护
    if (_isSuperAdmin(user)) {
      await FluentInfoBarHelper.showWarning(
        context,
        '超级管理员账号不允许编辑',
      );
      return;
    }
    
    final result = await showDialog<UpdateUserRequest>(
      context: context,
      builder: (ctx) => UserFormDialog(user: user),
    );
    if (result != null && mounted) {
      final success =
          await context.read<UserProvider>().updateUser(user.id, result);
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '用户更新成功');
      } else if (mounted) {
        final err = context.read<UserProvider>().error ?? '更新失败';
        await FluentInfoBarHelper.showError(context, err);
      }
    }
  }

  void _handleDelete(User user) async {
    // 超级管理员保护
    if (_isSuperAdmin(user)) {
      await FluentInfoBarHelper.showWarning(
        context,
        '超级管理员账号不允许删除',
      );
      return;
    }
    
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除用户 "${user.username}" 吗？'),
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
      final success = await context.read<UserProvider>().deleteUser(user.id);
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '用户删除成功');
      } else if (mounted) {
        final err = context.read<UserProvider>().error ?? '删除失败';
        await FluentInfoBarHelper.showError(context, err);
      }
    }
  }

  void _handleStatusChange(User user, bool value) async {
    // 超级管理员保护
    if (_isSuperAdmin(user)) {
      await FluentInfoBarHelper.showWarning(
        context,
        '超级管理员账号不允许修改状态',
      );
      return;
    }
    
    final newStatus = value ? 1 : 0;
    final req = UpdateUserRequest(status: newStatus);

    final success =
        await context.read<UserProvider>().updateUser(user.id, req);

    if (success && mounted) {
      await FluentInfoBarHelper.showSuccess(context, '状态已更新');
    } else if (mounted) {
      final err = context.read<UserProvider>().error ?? '状态更新失败';
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
            '用户管理',
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
                Text('新增用户'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Consumer<UserProvider>(
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
                  onPressed: () => provider.loadUsers(),
                  child: const Text('重试'),
                ),
              ],
            ),
          );
        }

        if (provider.users.isEmpty) {
          return const Center(child: Text('暂无用户数据'));
        }

        return _buildUserList(provider.users);
      },
    );
  }

  Widget _buildUserList(List<User> users) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        final isActive = user.status == 1;
        final isSuperAdmin = _isSuperAdmin(user);

        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isSuperAdmin ? Colors.orange : Colors.blue,
              child: Text(
                user.username.substring(0, 1).toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Row(
              children: [
                Text(
                  user.username,
                  style: FluentTheme.of(context).typography.bodyStrong,
                ),
                if (isSuperAdmin) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF6B35), Color(0xFFFF9F1C)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '👑 超级管理员',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (user.nickname?.isNotEmpty == true) Text('昵称: ${user.nickname}'),
                if (user.phone.isNotEmpty) Text('手机: ${user.phone}'),
                if (user.email?.isNotEmpty == true) Text('邮箱: ${user.email}'),
                if (user.role != null) Text('角色: ${user.role!.name}'),
                if (isSuperAdmin)
                  Text(
                    '⚠️ 此账号受保护，不允许编辑、删除或修改状态',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ToggleSwitch(
                  checked: isActive,
                  onChanged: isSuperAdmin ? null : (value) => _handleStatusChange(user, value),
                ),
                const SizedBox(width: 8),
                Button(
                  onPressed: isSuperAdmin ? null : () => _handleEdit(user),
                  child: const Text('编辑'),
                ),
                const SizedBox(width: 8),
                Button(
                  onPressed: isSuperAdmin ? null : () => _handleDelete(user),
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
    return Consumer<UserProvider>(
      builder: (context, provider, _) {
        if (provider.users.isEmpty) {
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
                        ? () => provider.loadUsers(page: currentPage - 1)
                        : null,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('$currentPage / $totalPages'),
                  ),
                  IconButton(
                    icon: const Icon(FluentIcons.chevron_right),
                    onPressed: currentPage < totalPages
                        ? () => provider.loadUsers(page: currentPage + 1)
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
