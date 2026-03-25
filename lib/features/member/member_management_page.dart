import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/fluent_info_bar.dart';
import 'member_provider.dart';
import 'models.dart';
import 'member_detail_page.dart';
class MemberManagementPage extends StatefulWidget {
  const MemberManagementPage({super.key});
  @override
  State<MemberManagementPage> createState() => _MemberManagementPageState();
}
class _MemberManagementPageState extends State<MemberManagementPage> {
  final _searchCtrl = TextEditingController();
  String? _selectedKeyword;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MemberProvider>().loadMembers();
    });
  }
  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }
  void _handleSearch() {
    setState(() {
      _selectedKeyword = _searchCtrl.text.trim();
    });
    context.read<MemberProvider>().loadMembers(keyword: _selectedKeyword);
  }
  void _handleReset() {
    _searchCtrl.clear();
    setState(() {
      _selectedKeyword = null;
    });
    context.read<MemberProvider>().loadMembers();
  }
  void _handleViewDetail(Member member) {
    Navigator.push(
      context,
      FluentPageRoute(builder: (_) => MemberDetailPage(member: member)),
    );
  }
  void _handleCreate() async {
    final result = await showDialog<CreateMemberReq>(
      context: context,
      builder: (_) => const _MemberFormDialog(),
    );
    if (result != null && mounted) {
      final provider = context.read<MemberProvider>();
      final member = await provider.createMember(result);
      if (member != null && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '创建成功');
      } else if (mounted) {
        await FluentInfoBarHelper.showError(context, provider.error ?? '创建失败');
      }
    }
  }
  void _handleEdit(Member member) async {
    final result = await showDialog<UpdateMemberReq>(
      context: context,
      builder: (_) => _MemberFormDialog(member: member),
    );
    if (result != null && mounted) {
      final provider = context.read<MemberProvider>();
      final updated = await provider.updateMember(member.id, result);
      if (updated != null && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '更新成功');
      } else if (mounted) {
        await FluentInfoBarHelper.showError(context, provider.error ?? '更新失败');
      }
    }
  }
  void _handleDelete(Member member) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => ContentDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除会员 "${member.name}" 吗？此操作不可恢复。'),
        actions: [
          Button(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.red)),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      final provider = context.read<MemberProvider>();
      final success = await provider.deleteMember(member.id);
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '删除成功');
      } else if (mounted) {
        await FluentInfoBarHelper.showError(context, provider.error ?? '删除失败');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Column(
        children: [
          _buildToolbar(theme, isDark),
          Expanded(child: _buildContent(theme, isDark)),
          _buildPagination(),
        ],
      ),
    );
  }
  Widget _buildToolbar(FluentThemeData theme, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.accentColor.withValues(alpha: 0.05),
            isDark ? const Color(0xFF2D2D2D) : theme.micaBackgroundColor,
          ],
        ),
        border: Border(bottom: BorderSide(color: theme.resources.dividerStrokeColorDefault, width: 1)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.purple, Colors.purple.lighter]),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.purple.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 2))],
                ),
                child: const Icon(FluentIcons.people, size: 24, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('会员管理', style: theme.typography.title?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text('管理系统会员信息', style: theme.typography.caption?.copyWith(color: isDark ? Colors.grey[100] : Colors.grey[130])),
                ],
              ),
              const Spacer(),
              FilledButton(
                onPressed: _handleCreate,
                style: ButtonStyle(padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 12))),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(FluentIcons.add, size: 16), SizedBox(width: 8), Text('新建会员', style: TextStyle(fontSize: 14))],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              SizedBox(
                width: 240,
                child: TextBox(
                  controller: _searchCtrl,
                  placeholder: '搜索会员姓名/手机号',
                  onSubmitted: (_) => _handleSearch(),
                ),
              ),
              const SizedBox(width: 12),
              FilledButton(
                onPressed: _handleSearch,
                child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(FluentIcons.search, size: 14), SizedBox(width: 6), Text('查询')]),
              ),
              const SizedBox(width: 8),
              Button(
                onPressed: _handleReset,
                child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(FluentIcons.refresh, size: 14), SizedBox(width: 6), Text('重置')]),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildContent(FluentThemeData theme, bool isDark) {
    return Consumer<MemberProvider>(
      builder: (context, provider, _) {
        if (provider.loading && provider.list.isEmpty) {
          return const Center(child: ProgressRing());
        }
        if (provider.error != null && provider.list.isEmpty) {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(FluentIcons.error_badge, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(provider.error!, style: TextStyle(color: Colors.red.darker)),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => provider.loadMembers(),
                    child: const Text('重试'),
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(FluentIcons.people, size: 72, color: Colors.grey[100]),
                  const SizedBox(height: 24),
                  Text('暂无会员', style: theme.typography.title?.copyWith(color: Colors.grey[160], fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text('点击右上角"新建会员"按钮添加', style: theme.typography.body?.copyWith(color: Colors.grey[130])),
                ],
              ),
            ),
          );
        }
        return Container(
          color: isDark ? const Color(0xFF1F1F1F) : const Color(0xFFF5F7FA),
          child: ListView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: provider.list.length,
            itemBuilder: (context, index) => _buildMemberCard(provider.list[index], isDark),
          ),
        );
      },
    );
  }
  Widget _buildMemberCard(Member member, bool isDark) {
    final theme = FluentTheme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: HoverButton(
        onPressed: () => _handleViewDetail(member),
        builder: (context, states) {
          final isHovered = states.isHovered;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isHovered ? Colors.blue.withValues(alpha: 0.5) : (isDark ? Colors.grey[100]!.withValues(alpha: 0.1) : Colors.grey[30]!),
                width: isHovered ? 2 : 1,
              ),
              boxShadow: [BoxShadow(color: isHovered ? Colors.blue.withValues(alpha: 0.12) : Colors.black.withValues(alpha: isDark ? 0.2 : 0.05), blurRadius: isHovered ? 12 : 6, offset: Offset(0, isHovered ? 4 : 2))],
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.purple, Colors.purple.lighter]),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: Text(member.name?.isNotEmpty == true ? member.name![0] : '?', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(member.name ?? '未知', style: theme.typography.bodyStrong?.copyWith(fontSize: 14)),
                          if (member.levelName != null) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(color: Colors.purple.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
                              child: Text(member.levelName!, style: TextStyle(fontSize: 10, color: Colors.purple)),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(FluentIcons.phone, size: 12, color: Colors.grey[120]),
                          const SizedBox(width: 4),
                          Text(member.phone ?? '-', style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[100] : Colors.grey[130])),
                          const SizedBox(width: 16),
                          Icon(FluentIcons.starburst, size: 12, color: Colors.yellow),
                          const SizedBox(width: 4),
                          Text('${member.points ?? 0} 积分', style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[100] : Colors.grey[130])),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('余额', style: TextStyle(fontSize: 10, color: Colors.grey[120])),
                    const SizedBox(height: 2),
                    Text('¥${member.balance ?? '0.00'}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                  ],
                ),
                const SizedBox(width: 16),
                if (isHovered)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(FluentIcons.edit, size: 16),
                        onPressed: () => _handleEdit(member),
                      ),
                      IconButton(
                        icon: Icon(FluentIcons.delete, size: 16, color: Colors.red),
                        onPressed: () => _handleDelete(member),
                      ),
                    ],
                  )
                else
                  Icon(FluentIcons.chevron_right, size: 14, color: Colors.grey[100]),
              ],
            ),
          );
        },
      ),
    );
  }
  Widget _buildPagination() {
    return Consumer<MemberProvider>(
      builder: (context, provider, _) {
        if (provider.list.isEmpty) return const SizedBox.shrink();
        final totalPages = (provider.total / provider.pageSize).ceil();
        if (totalPages <= 1) return const SizedBox.shrink();
        final theme = FluentTheme.of(context);
        final isDark = theme.brightness == Brightness.dark;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
            border: Border(top: BorderSide(color: isDark ? Colors.grey[100]!.withValues(alpha: 0.2) : Colors.grey[40]!, width: 1)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('共 ${provider.total} 条记录'),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(FluentIcons.chevron_left, size: 16),
                    onPressed: provider.page > 1 ? () => provider.setPage(provider.page - 1) : null,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.purple, Colors.purple.lighter]),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text('${provider.page} / $totalPages', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                  IconButton(
                    icon: const Icon(FluentIcons.chevron_right, size: 16),
                    onPressed: provider.page < totalPages ? () => provider.setPage(provider.page + 1) : null,
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
class _MemberFormDialog extends StatefulWidget {
  final Member? member;
  const _MemberFormDialog({this.member});
  @override
  State<_MemberFormDialog> createState() => _MemberFormDialogState();
}
class _MemberFormDialogState extends State<_MemberFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _phoneCtrl;
  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.member?.name);
    _phoneCtrl = TextEditingController(text: widget.member?.phone);
  }
  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }
  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (widget.member == null) {
      final req = CreateMemberReq(
        name: _nameCtrl.text.trim(),
        phone: _phoneCtrl.text.trim(),
      );
      Navigator.pop(context, req);
    } else {
      final req = UpdateMemberReq(
        name: _nameCtrl.text.trim(),
        phone: _phoneCtrl.text.trim(),
      );
      Navigator.pop(context, req);
    }
  }
  @override
  Widget build(BuildContext context) {
    final isEdit = widget.member != null;
    return ContentDialog(
      title: Text(isEdit ? '编辑会员' : '新建会员'),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InfoLabel(
                label: '姓名',
                child: TextFormBox(
                  controller: _nameCtrl,
                  placeholder: '请输入会员姓名',
                  validator: (v) => v == null || v.trim().isEmpty ? '请输入姓名' : null,
                ),
              ),
              const SizedBox(height: 16),
              InfoLabel(
                label: '手机号',
                child: TextFormBox(
                  controller: _phoneCtrl,
                  placeholder: '请输入手机号',
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return '请输入手机号';
                    if (!RegExp(r'^1[3-9]\d{9}$').hasMatch(v.trim())) return '手机号格式不正确';
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Button(onPressed: () => Navigator.pop(context), child: const Text('取消')),
        FilledButton(onPressed: _submit, child: Text(isEdit ? '保存' : '创建')),
      ],
    );
  }
}