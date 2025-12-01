import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/fluent_info_bar.dart';
import '../../core/constants/ui_texts.dart';
import '../../core/network/api_client.dart';
import 'role_provider.dart';
import 'role_api.dart';
import 'role_form_dialog.dart';
import 'role_menu_dialog.dart';
import 'role_models.dart';

class RoleManagementPage extends StatefulWidget {
  const RoleManagementPage({super.key});
  @override
  State<RoleManagementPage> createState() => _RoleManagementPageState();
}

class _RoleManagementPageState extends State<RoleManagementPage> {
  final _searchCtrl = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RoleProvider>().loadRoles();
    });
  }
  
  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }
  
  void _handleSearch() {
    context.read<RoleProvider>().loadRoles(keyword: _searchCtrl.text.trim());
  }

  void _openCreate() async {
    final req = await showDialog<CreateRoleRequest>(
      context: context,
      builder: (_) => ChangeNotifierProvider.value(
        value: context.read<RoleProvider>(),
        child: const RoleFormDialog(),
      ),
    );
    if (req != null) {
      final ok = await context.read<RoleProvider>().create(req);
      if (!mounted) return;
      if (ok) {
        await FluentInfoBarHelper.showSuccess(context, UITexts.roleCreateSuccess);
      } else {
        await FluentInfoBarHelper.showError(context, UITexts.roleCreateFailed);
      }
    }
  }

  void _openEdit(RoleItem r) async {
    final req = await showDialog<UpdateRoleRequest>(
      context: context,
      builder: (_) => ChangeNotifierProvider.value(
        value: context.read<RoleProvider>(),
        child: RoleFormDialog(editing: r),
      ),
    );
    if (req != null) {
      final ok = await context.read<RoleProvider>().update(r.id, req);
      if (!mounted) return;
      if (ok) {
        await FluentInfoBarHelper.showSuccess(context, UITexts.roleUpdateSuccess);
      } else {
        await FluentInfoBarHelper.showError(context, UITexts.roleUpdateFailed);
      }
    }
  }

  void _openMenuConfig(RoleItem r) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => RoleMenuDialog(
        roleId: r.id,
        roleName: r.name,
      ),
    );
    
    if (result == true && mounted) {
      // 刷新角色列表
      context.read<RoleProvider>().loadRoles();
    }
  }

  void _delete(RoleItem r) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => ContentDialog(
        title: const Text(UITexts.roleDeleteConfirmTitle),
        content: Text('确定要删除角色 "${r.name}"?'),
        actions: [
          Button(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text(UITexts.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(UITexts.commonOk),
          ),
        ],
      ),
    );
    if (confirm == true) {
      final ok = await context.read<RoleProvider>().remove(r.id);
      if (!mounted) return;
      if (ok) {
        await FluentInfoBarHelper.showSuccess(context, UITexts.roleDeleteSuccess);
      } else {
        await FluentInfoBarHelper.showError(context, UITexts.roleDeleteFailed);
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
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildToolbar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            FluentTheme.of(context).accentColor.withOpacity(0.05),
            FluentTheme.of(context).micaBackgroundColor,
          ],
        ),
        border: Border(
          bottom: BorderSide(
            color: FluentTheme.of(context).resources.dividerStrokeColorDefault,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  FluentIcons.permissions,
                  size: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '角色管理',
                    style: FluentTheme.of(context).typography.title?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '管理系统角色和权限',
                    style: FluentTheme.of(context).typography.caption?.copyWith(
                      color: Colors.grey[130],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              FilledButton(
                onPressed: _openCreate,
                style: ButtonStyle(
                  padding: ButtonState.all(
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(FluentIcons.add, size: 18),
                    SizedBox(width: 8),
                    Text('新增角色', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextBox(
                    controller: _searchCtrl,
                    placeholder: '🔍 搜索角色名称或编码...',
                    style: const TextStyle(fontSize: 14),
                    onSubmitted: (_) => _handleSearch(),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Button(
                onPressed: _handleSearch,
                style: ButtonStyle(
                  padding: ButtonState.all(
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(FluentIcons.search, size: 16),
                    SizedBox(width: 6),
                    Text('搜索'),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Button(
                onPressed: () {
                  _searchCtrl.clear();
                  context.read<RoleProvider>().loadRoles();
                },
                style: ButtonStyle(
                  padding: ButtonState.all(
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(FluentIcons.refresh, size: 16),
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
    return Consumer<RoleProvider>(
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
                  style: FluentTheme.of(context).typography.body?.copyWith(
                    color: Colors.grey[130],
                  ),
                ),
              ],
            ),
          );
        }
        if (provider.error != null) {
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
                    child: Icon(
                      FluentIcons.error_badge,
                      size: 48,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '加载失败',
                    style: FluentTheme.of(context).typography.subtitle?.copyWith(
                      color: Colors.red.dark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    provider.error!,
                    style: FluentTheme.of(context).typography.body?.copyWith(
                      color: Colors.red.darker,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () => provider.loadRoles(),
                    style: ButtonStyle(
                      backgroundColor: ButtonState.all(Colors.red),
                    ),
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
        if (provider.list.isEmpty) {
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
                border: Border.all(
                  color: Colors.blue.withOpacity(0.1),
                  width: 2,
                ),
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
                    child: Icon(
                      FluentIcons.permissions,
                      size: 72,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    provider.keyword?.isNotEmpty == true ? '未找到匹配的角色' : '暂无角色数据',
                    style: FluentTheme.of(context).typography.title?.copyWith(
                      color: Colors.grey[160],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (provider.keyword?.isNotEmpty == true)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.orange.withOpacity(0.3)),
                      ),
                      child: Text(
                        '搜索关键词: "${provider.keyword}"',
                        style: FluentTheme.of(context).typography.body?.copyWith(
                          color: Colors.orange.dark,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  else
                    Text(
                      '点击右上角"新增角色"按钮创建第一个角色',
                      style: FluentTheme.of(context).typography.body?.copyWith(
                        color: Colors.grey[130],
                      ),
                    ),
                  const SizedBox(height: 24),
                  if (provider.keyword?.isNotEmpty == true)
                    Button(
                      onPressed: () {
                        _searchCtrl.clear();
                        provider.loadRoles();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(FluentIcons.clear, size: 16),
                          SizedBox(width: 8),
                          Text('清除搜索'),
                        ],
                      ),
                    )
                  else
                    FilledButton(
                      onPressed: _openCreate,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(FluentIcons.add, size: 18),
                          SizedBox(width: 8),
                          Text('创建第一个角色'),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        }
        return Column(
          children: [
            Expanded(child: _buildRoleList(provider.list)),
            if (provider.list.length > 10) _buildPagination(provider),
          ],
        );
      },
    );
  }

  // 判断是否为超级管理员角色
  bool _isSuperAdminRole(RoleItem role) {
    return role.code == 'super_admin' || role.id == 1;
  }

  Widget _buildRoleList(List<RoleItem> roles) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: roles.length,
      itemBuilder: (context, index) {
        final role = roles[index];
        final isActive = (role.status ?? 1) == 1;
        final isSuperAdmin = _isSuperAdminRole(role);

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSuperAdmin
                  ? Colors.orange.withOpacity(0.5)
                  : (isDark ? Colors.grey[100].withOpacity(0.2) : Colors.grey[40]!),
              width: isSuperAdmin ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // 左侧图标
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isSuperAdmin
                          ? [const Color(0xFFFF6B35), const Color(0xFFFF9F1C)]
                          : isActive
                              ? [Colors.blue, Colors.blue.lighter]
                              : [Colors.grey[100]!, Colors.grey[80]!],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    isSuperAdmin ? FluentIcons.shield : FluentIcons.permissions,
                    size: 22,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                // 中间信息
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            role.name,
                            style: theme.typography.bodyStrong?.copyWith(fontSize: 15),
                          ),
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
                                  Text('超管', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ],
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: (isActive ? Colors.green : Colors.grey).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              isActive ? '启用' : '禁用',
                              style: TextStyle(fontSize: 11, color: isActive ? Colors.green : Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          if (role.code?.isNotEmpty == true) ...[
                            Icon(FluentIcons.code, size: 11, color: Colors.grey[100]),
                            const SizedBox(width: 4),
                            Text(
                              role.code!,
                              style: TextStyle(fontSize: 12, color: Colors.grey[100], fontFamily: 'monospace'),
                            ),
                            const SizedBox(width: 16),
                          ],
                          if (role.description?.isNotEmpty == true)
                            Expanded(
                              child: Text(
                                role.description!,
                                style: TextStyle(fontSize: 12, color: Colors.grey[130]),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                // 右侧操作按钮（超级管理员不显示）
                if (!isSuperAdmin) ...[
                  _buildActionButton(
                    icon: FluentIcons.list,
                    label: '菜单',
                    color: Colors.blue,
                    onPressed: () => _openMenuConfig(role),
                  ),
                  const SizedBox(width: 8),
                  _buildActionButton(
                    icon: FluentIcons.edit,
                    label: '编辑',
                    color: Colors.teal,
                    onPressed: () => _openEdit(role),
                  ),
                  const SizedBox(width: 8),
                  _buildActionButton(
                    icon: FluentIcons.delete,
                    label: '删除',
                    color: Colors.red,
                    onPressed: () => _delete(role),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return HoverButton(
      onPressed: onPressed,
      builder: (context, states) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: states.isHovered ? color.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 4),
              Text(label, style: TextStyle(fontSize: 12, color: color)),
            ],
          ),
        );
      },
    );
  }
}


  Widget _buildPagination(RoleProvider provider) {
    final totalPages = (provider.total / provider.pageSize).ceil();
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey[40]!,
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
              Icon(FluentIcons.database, size: 16, color: Colors.grey[130]),
              const SizedBox(width: 8),
              Text(
                '共 ${provider.total} 条记录',
                style: const TextStyle(
                  color: Color(0xFF666666),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[20],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey[40]!),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    FluentIcons.chevron_left,
                    size: 16,
                    color: provider.page > 1 ? Colors.blue : Colors.grey[100],
                  ),
                  onPressed: provider.page > 1
                      ? () => provider.setPage(provider.page - 1)
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
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    '${provider.page} / $totalPages',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(
                    FluentIcons.chevron_right,
                    size: 16,
                    color: provider.page < totalPages ? Colors.blue : Colors.grey[100],
                  ),
                  onPressed: provider.page < totalPages
                      ? () => provider.setPage(provider.page + 1)
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


class RoleManagementScope extends StatelessWidget {
  const RoleManagementScope({super.key});
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RoleProvider(RoleApi(ApiClient())),
      child: const RoleManagementPage(),
    );
  }
}
