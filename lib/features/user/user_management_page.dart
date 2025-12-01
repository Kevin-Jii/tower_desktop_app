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
  static const int superAdminId = 1;
  static const String superAdminUsername = 'admin';
  
  final _usernameCtrl = TextEditingController();
  final _phoneSuffixCtrl = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().loadUsers();
    });
  }
  
  @override
  void dispose() {
    _usernameCtrl.dispose();
    _phoneSuffixCtrl.dispose();
    super.dispose();
  }
  
  void _handleSearch() {
    final username = _usernameCtrl.text.trim();
    final phoneSuffix = _phoneSuffixCtrl.text.trim();
    
    // 组合查询关键字
    String? keyword;
    if (username.isNotEmpty && phoneSuffix.isNotEmpty) {
      keyword = '$username,$phoneSuffix';
    } else if (username.isNotEmpty) {
      keyword = username;
    } else if (phoneSuffix.isNotEmpty) {
      keyword = phoneSuffix;
    }
    
    context.read<UserProvider>().loadUsers(page: 1, keyword: keyword);
  }
  
  void _handleReset() {
    _usernameCtrl.clear();
    _phoneSuffixCtrl.clear();
    context.read<UserProvider>().loadUsers(page: 1, keyword: null);
  }
  
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
    if (_isSuperAdmin(user)) {
      await FluentInfoBarHelper.showWarning(context, '超级管理员账号不允许编辑');
      return;
    }
    
    final result = await showDialog<UpdateUserRequest>(
      context: context,
      builder: (ctx) => UserFormDialog(user: user),
    );
    if (result != null && mounted) {
      final success = await context.read<UserProvider>().updateUser(user.id, result);
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '用户更新成功');
      } else if (mounted) {
        final err = context.read<UserProvider>().error ?? '更新失败';
        await FluentInfoBarHelper.showError(context, err);
      }
    }
  }

  void _handleDelete(User user) async {
    if (_isSuperAdmin(user)) {
      await FluentInfoBarHelper.showWarning(context, '超级管理员账号不允许删除');
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
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.red),
            ),
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
    if (_isSuperAdmin(user)) {
      await FluentInfoBarHelper.showWarning(context, '超级管理员账号不允许修改状态');
      return;
    }
    
    final newStatus = value ? 1 : 0;
    final req = UpdateUserRequest(status: newStatus);
    final success = await context.read<UserProvider>().updateUser(user.id, req);

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
          bottom: BorderSide(
            color: theme.resources.dividerStrokeColorDefault,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // 标题行
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.blue.lighter],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  FluentIcons.people,
                  size: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '用户管理',
                    style: theme.typography.title?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '管理系统用户账号和权限',
                    style: theme.typography.caption?.copyWith(
                      color: isDark ? Colors.grey[100] : Colors.grey[130],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              FilledButton(
                onPressed: _handleCreate,
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(FluentIcons.add, size: 18),
                    SizedBox(width: 8),
                    Text('新增用户', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 查询行
          Row(
            children: [
              SizedBox(
                width: 180,
                child: TextBox(
                  controller: _usernameCtrl,
                  placeholder: '用户名',
                  prefix: const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(FluentIcons.contact, size: 14),
                  ),
                  onSubmitted: (_) => _handleSearch(),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 180,
                child: TextBox(
                  controller: _phoneSuffixCtrl,
                  placeholder: '手机号后四位',
                  prefix: const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(FluentIcons.phone, size: 14),
                  ),
                  onSubmitted: (_) => _handleSearch(),
                ),
              ),
              const SizedBox(width: 12),
              FilledButton(
                onPressed: _handleSearch,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(FluentIcons.search, size: 14),
                    SizedBox(width: 6),
                    Text('查询'),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Button(
                onPressed: _handleReset,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(FluentIcons.refresh, size: 14),
                    SizedBox(width: 6),
                    Text('重置'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Consumer<UserProvider>(
      builder: (context, provider, _) {
        if (provider.loading) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ProgressRing(),
                const SizedBox(height: 20),
                Text(
                  '加载中...',
                  style: theme.typography.body?.copyWith(
                    color: isDark ? Colors.grey[100] : Colors.grey[130],
                  ),
                ),
              ],
            ),
          );
        }

        if (provider.error != null) {
          return _buildErrorState(provider);
        }

        if (provider.users.isEmpty) {
          return _buildEmptyState();
        }

        return _buildUserGrid(provider.users);
      },
    );
  }

  Widget _buildErrorState(UserProvider provider) {
    final theme = FluentTheme.of(context);
    
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        margin: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.red.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(FluentIcons.error_badge, size: 48, color: Colors.red),
            ),
            const SizedBox(height: 20),
            Text(
              '加载失败',
              style: theme.typography.subtitle?.copyWith(
                color: Colors.red.dark,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              provider.error!,
              style: theme.typography.body?.copyWith(color: Colors.red.darker),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => provider.loadUsers(),
              style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.red)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(FluentIcons.refresh, size: 16),
                  SizedBox(width: 8),
                  Text('重试'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    final theme = FluentTheme.of(context);
    
    return Center(
      child: Container(
        padding: const EdgeInsets.all(48),
        margin: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.withOpacity(0.05),
              Colors.purple.withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue.withOpacity(0.1), width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.withOpacity(0.1), Colors.purple.withOpacity(0.1)],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(FluentIcons.people, size: 72, color: Colors.blue),
            ),
            const SizedBox(height: 24),
            Text(
              '暂无用户数据',
              style: theme.typography.title?.copyWith(
                color: Colors.grey[160],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '点击右上角"新增用户"按钮创建第一个用户',
              style: theme.typography.body?.copyWith(color: Colors.grey[130]),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _handleCreate,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(FluentIcons.add, size: 18),
                  SizedBox(width: 8),
                  Text('创建第一个用户'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserGrid(List<User> users) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      color: isDark ? const Color(0xFF1F1F1F) : const Color(0xFFF5F7FA),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final availableWidth = width - 48; // 减去左右padding
          // 宽屏时两列，窄屏时一列
          final crossAxisCount = width > 900 ? 2 : 1;
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: _buildRows(users, crossAxisCount, availableWidth),
            ),
          );
        },
      ),
    );
  }
  
  List<Widget> _buildRows(List<User> users, int crossAxisCount, double availableWidth) {
    final List<Widget> rows = [];
    final spacing = 16.0;
    final cardWidth = crossAxisCount == 2 
        ? (availableWidth - spacing) / 2 
        : availableWidth;
    
    for (int i = 0; i < users.length; i += crossAxisCount) {
      final rowUsers = users.skip(i).take(crossAxisCount).toList();
      rows.add(
        Padding(
          padding: EdgeInsets.only(bottom: i + crossAxisCount < users.length ? spacing : 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int j = 0; j < rowUsers.length; j++) ...[
                SizedBox(
                  width: cardWidth,
                  child: _buildUserCard(rowUsers[j]),
                ),
                if (j < rowUsers.length - 1) SizedBox(width: spacing),
              ],
            ],
          ),
        ),
      );
    }
    return rows;
  }

  Widget _buildUserCard(User user) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isActive = user.status == 1;
    final isSuperAdmin = _isSuperAdmin(user);
    
    return Card(
      padding: const EdgeInsets.all(20),
      backgroundColor: isDark ? const Color(0xFF2D2D2D) : Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // 用户头像
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isSuperAdmin
                        ? [const Color(0xFFFF6B35), const Color(0xFFFF9F1C)]
                        : [Colors.blue, Colors.blue.lighter],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: (isSuperAdmin ? Colors.orange : Colors.blue).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    user.username.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              
              // 用户信息
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          user.username,
                          style: theme.typography.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // 超级管理员标签（放在名称后面）
                        if (isSuperAdmin) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF6B35), Color(0xFFFF9F1C)],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('👑', style: TextStyle(fontSize: 10)),
                                SizedBox(width: 2),
                                Text(
                                  '超级管理员',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        const Spacer(),
                        // 状态标签
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: isActive
                                  ? [Colors.green.lighter, Colors.green]
                                  : [Colors.grey[60]!, Colors.grey[80]!],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: (isActive ? Colors.green : Colors.grey).withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Text(
                            isActive ? '✓ 启用' : '✕ 禁用',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    if (user.nickname?.isNotEmpty == true)
                      Row(
                        children: [
                          Icon(FluentIcons.contact, size: 12, color: isDark ? Colors.grey[100] : Colors.grey[130]),
                          const SizedBox(width: 4),
                          Text(
                            user.nickname!,
                            style: theme.typography.caption?.copyWith(
                              color: isDark ? Colors.grey[100] : Colors.grey[130],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // 详细信息
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[150].withOpacity(0.1) : Colors.grey[20],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                if (user.phone.isNotEmpty)
                  _buildInfoRow(FluentIcons.phone, '手机', user.phone, isDark),
                if (user.email?.isNotEmpty == true)
                  _buildInfoRow(FluentIcons.mail, '邮箱', user.email!, isDark),
                if (user.role != null)
                  _buildInfoRow(FluentIcons.permissions, '角色', user.role!.name, isDark),
              ],
            ),
          ),
          
          // 操作按钮（超级管理员不显示）
          if (!isSuperAdmin) ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ToggleSwitch(
                  checked: isActive,
                  onChanged: (value) => _handleStatusChange(user, value),
                ),
                const SizedBox(width: 12),
                Button(
                  onPressed: () => _handleEdit(user),
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(FluentIcons.edit, size: 12, color: Colors.blue),
                      const SizedBox(width: 4),
                      const Text('编辑', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                Button(
                  onPressed: () => _handleDelete(user),
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(FluentIcons.delete, size: 12, color: Colors.red),
                      const SizedBox(width: 4),
                      Text('删除', style: TextStyle(fontSize: 12, color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 12, color: isDark ? Colors.grey[100] : Colors.grey[130]),
          const SizedBox(width: 6),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.grey[100] : Colors.grey[130],
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white : Colors.grey[160],
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPagination() {
    return Consumer<UserProvider>(
      builder: (context, provider, _) {
        if (provider.users.isEmpty) {
          return const SizedBox.shrink();
        }

        final totalPages = (provider.total / provider.pageSize).ceil();
        if (totalPages <= 1) {
          return const SizedBox.shrink();
        }
        
        final theme = FluentTheme.of(context);
        final isDark = theme.brightness == Brightness.dark;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
            border: Border(
              top: BorderSide(
                color: isDark ? Colors.grey[100].withOpacity(0.2) : Colors.grey[40]!,
                width: 1,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(FluentIcons.database, size: 16, color: isDark ? Colors.grey[100] : Colors.grey[130]),
                  const SizedBox(width: 8),
                  Text(
                    '共 ${provider.total} 条记录',
                    style: TextStyle(
                      color: isDark ? Colors.grey[100] : const Color(0xFF666666),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[150].withOpacity(0.1) : Colors.grey[20],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: isDark ? Colors.grey[100].withOpacity(0.2) : Colors.grey[40]!),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        FluentIcons.chevron_left,
                        size: 16,
                        color: provider.page > 1 ? Colors.blue : (isDark ? Colors.grey[100] : Colors.grey[100]),
                      ),
                      onPressed: provider.page > 1
                          ? () => provider.loadUsers(page: provider.page - 1)
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue, Colors.blue.lighter],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Text(
                        '${provider.page} / $totalPages',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Icon(
                        FluentIcons.chevron_right,
                        size: 16,
                        color: provider.page < totalPages ? Colors.blue : (isDark ? Colors.grey[100] : Colors.grey[100]),
                      ),
                      onPressed: provider.page < totalPages
                          ? () => provider.loadUsers(page: provider.page + 1)
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
