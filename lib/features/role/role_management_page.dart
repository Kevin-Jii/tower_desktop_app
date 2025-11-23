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
    // TODO: 从后端获取该角色已配置的菜单ID列表
    final initialMenuIds = <int>[];
    
    final selectedMenuIds = await showDialog<List<int>>(
      context: context,
      builder: (_) => RoleMenuDialog(
        roleId: r.id,
        roleName: r.name,
        initialMenuIds: initialMenuIds,
      ),
    );
    
    if (selectedMenuIds != null) {
      // TODO: 调用API保存角色菜单配置
      // await context.read<RoleProvider>().updateRoleMenus(r.id, selectedMenuIds);
      if (!mounted) return;
      await FluentInfoBarHelper.showSuccess(context, '角色菜单配置已保存');
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

  Widget _buildRoleList(List<RoleItem> roles) {
    return GridView.builder(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 450,
        childAspectRatio: 2.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: roles.length,
      itemBuilder: (context, index) {
        final role = roles[index];
        final isActive = (role.status ?? 1) == 1;
        
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Card(
            padding: const EdgeInsets.all(20),
            backgroundColor: Colors.white,
            borderRadius: BorderRadius.circular(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // 角色图标
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: isActive
                              ? [Colors.blue, Colors.blue.lighter]
                              : [Colors.grey[100]!, Colors.grey[80]!],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: (isActive ? Colors.blue : Colors.grey).withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        FluentIcons.permissions,
                        size: 28,
                        color: isActive ? Colors.white : Colors.grey[130],
                      ),
                    ),
                    const SizedBox(width: 16),
                    
                    // 角色信息
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  role.name,
                                  style: FluentTheme.of(context).typography.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
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
                          if (role.code?.isNotEmpty == true)
                            Row(
                              children: [
                                Icon(FluentIcons.code, size: 12, color: Colors.grey[130]),
                                const SizedBox(width: 4),
                                Text(
                                  role.code!,
                                  style: FluentTheme.of(context).typography.caption?.copyWith(
                                    color: Colors.grey[130],
                                    fontFamily: 'monospace',
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
                
                // 描述
                if (role.description?.isNotEmpty == true)
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[20],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      role.description!,
                      style: FluentTheme.of(context).typography.caption?.copyWith(
                        color: Colors.grey[140],
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[20],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[40]!, style: BorderStyle.solid),
                    ),
                    child: Text(
                      '暂无描述',
                      style: FluentTheme.of(context).typography.caption?.copyWith(
                        color: Colors.grey[100],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                
                const Spacer(),
                
                // 底部信息和操作
                Row(
                  children: [
                    if (role.createdAt != null)
                      Expanded(
                        child: Row(
                          children: [
                            Icon(FluentIcons.calendar, size: 12, color: Colors.grey[100]),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                role.createdAt!,
                                style: FluentTheme.of(context).typography.caption?.copyWith(
                                  color: Colors.grey[100],
                                  fontSize: 11,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(width: 8),
                    // 操作按钮
                    Button(
                      onPressed: () => _openMenuConfig(role),
                      style: ButtonStyle(
                        padding: ButtonState.all(
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(FluentIcons.list, size: 12, color: Colors.blue),
                          const SizedBox(width: 4),
                          const Text('菜单', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    Button(
                      onPressed: () => _openEdit(role),
                      style: ButtonStyle(
                        padding: ButtonState.all(
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(FluentIcons.edit, size: 12),
                          SizedBox(width: 4),
                          Text('编辑', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    Button(
                      onPressed: () => _delete(role),
                      style: ButtonStyle(
                        padding: ButtonState.all(
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
            ),
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
