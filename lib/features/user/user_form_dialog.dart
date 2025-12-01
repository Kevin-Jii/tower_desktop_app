import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'models.dart';
import '../store/store_provider.dart';
import '../role/role_api.dart';
import '../role/role_models.dart';
import '../../core/di/service_locator.dart';

class UserFormDialog extends StatefulWidget {
  final User? user;

  const UserFormDialog({super.key, this.user});

  @override
  State<UserFormDialog> createState() => _UserFormDialogState();
}

class _UserFormDialogState extends State<UserFormDialog> {
  final _usernameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  int? _roleId;
  int? _storeId;
  int _status = 1;

  List<RoleItem> _roles = [];
  bool _loadingRoles = true;

  bool get isEditMode => widget.user != null;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      final u = widget.user!;
      _usernameCtrl.text = u.username;
      _emailCtrl.text = u.email ?? '';
      _roleId = u.roleId;
      _storeId = u.storeId;
      _status = u.status ?? 1;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isEditMode) {
        context.read<StoreProvider>().loadStores(pageSize: 1000);
      }
      _loadRoles();
    });
  }

  Future<void> _loadRoles() async {
    try {
      final roleApi = sl.get<RoleApi>();
      final roles = await roleApi.getRoles();
      if (mounted) {
        setState(() {
          _roles = roles;
          _loadingRoles = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _loadingRoles = false);
      }
    }
  }

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (isEditMode) {
      final req = UpdateUserRequest(
        phone: widget.user!.phone,
        email: _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
        password: _passwordCtrl.text.isEmpty ? null : _passwordCtrl.text,
        roleId: _roleId,
        storeId: _storeId,
        status: _status,
      );
      Navigator.pop(context, req);
    } else {
      final req = CreateUserRequest(
        username: _usernameCtrl.text.trim(),
        phone: _phoneCtrl.text.trim(),
        password: _passwordCtrl.text,
        email: _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
        roleId: _roleId,
        status: 1,
      );
      Navigator.pop(context, req);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ContentDialog(
      constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.blue.lighter],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isEditMode ? FluentIcons.edit : FluentIcons.add_friend,
              size: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            isEditMode ? '编辑用户' : '新增用户',
            style: theme.typography.subtitle?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // 基本信息（编辑模式在标题后显示用户名）
            _buildSectionTitle(
              '基本信息',
              FluentIcons.contact_info,
              isDark,
              suffix: isEditMode ? widget.user!.username : null,
            ),
            const SizedBox(height: 12),
            // 新增模式：用户名和手机号一行
            if (!isEditMode)
              Row(
                children: [
                  Expanded(
                    child: _buildCompactTextField('用户名', _usernameCtrl, '请输入用户名', required: true),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildCompactTextField('手机号', _phoneCtrl, '请输入11位手机号', required: true),
                  ),
                ],
              ),
            if (!isEditMode) const SizedBox(height: 12),
            // 邮箱和密码一行
            Row(
              children: [
                Expanded(
                  child: _buildCompactTextField('邮箱', _emailCtrl, '请输入邮箱地址（选填）'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('密码', required: !isEditMode, isDark: isDark),
                      const SizedBox(height: 6),
                      PasswordBox(
                        controller: _passwordCtrl,
                        placeholder: isEditMode ? '留空则不修改密码' : '请输入密码',
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            _buildSectionTitle('角色分配', FluentIcons.permissions, isDark),
            const SizedBox(height: 12),
            _buildRoleSelector(isDark),

            // 编辑模式显示门店
            if (isEditMode) ...[
              const SizedBox(height: 16),
              _buildSectionTitle('其他设置', FluentIcons.settings, isDark),
              const SizedBox(height: 12),
              _buildStoreSelector(isDark),
            ],
          ],
        ),
      ),
      actions: [
        Button(
          onPressed: () => Navigator.pop(context),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('取消'),
          ),
        ),
        FilledButton(
          onPressed: _submit,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(isEditMode ? FluentIcons.save : FluentIcons.add, size: 14),
                const SizedBox(width: 6),
                Text(isEditMode ? '保存' : '创建'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, IconData icon, bool isDark, {String? suffix}) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.blue),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : const Color(0xFF333333),
          ),
        ),
        if (suffix != null) ...[
          const SizedBox(width: 12),
          Text(
            '【$suffix】',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.blue,
            ),
          ),
        ],
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 1,
            color: isDark
                ? Colors.grey[100].withOpacity(0.2)
                : const Color(0xFFE5E7EB),
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String label,
      {bool required = false, required bool isDark}) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.grey[100] : const Color(0xFF666666),
          ),
        ),
        if (required)
          Text(
            ' *',
            style: TextStyle(
              fontSize: 13,
              color: const Color(0xFFE81123),
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, String placeholder,
      {bool required = false, bool enabled = true}) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(label, required: required, isDark: isDark),
          const SizedBox(height: 6),
          TextBox(
            controller: controller,
            placeholder: placeholder,
            enabled: enabled,
          ),
        ],
      ),
    );
  }

  Widget _buildCompactTextField(
      String label, TextEditingController controller, String placeholder,
      {bool required = false, bool enabled = true}) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label, required: required, isDark: isDark),
        const SizedBox(height: 6),
        TextBox(
          controller: controller,
          placeholder: placeholder,
          enabled: enabled,
        ),
      ],
    );
  }

  /// 角色选择器 - 使用固定高度的列表
  Widget _buildRoleSelector(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('角色', isDark: isDark),
        const SizedBox(height: 6),
        Container(
          height: 120,
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[150].withOpacity(0.1) : Colors.grey[20],
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: isDark
                  ? Colors.grey[100].withOpacity(0.2)
                  : const Color(0xFFE5E7EB),
            ),
          ),
          child: _loadingRoles
              ? const Center(child: ProgressRing(strokeWidth: 2))
              : _roles.isEmpty
                  ? Center(
                      child: Text(
                        '暂无角色数据',
                        style: TextStyle(
                          color:
                              isDark ? Colors.grey[100] : const Color(0xFF999999),
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(4),
                      itemCount: _roles.length,
                      itemBuilder: (context, index) {
                        final role = _roles[index];
                        final isSelected = _roleId == role.id;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: HoverButton(
                            onPressed: () {
                              setState(() => _roleId = role.id);
                            },
                            builder: (context, states) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.blue.withOpacity(0.15)
                                      : states.isHovered
                                          ? (isDark
                                              ? Colors.grey[150].withOpacity(0.1)
                                              : Colors.grey[30])
                                          : Colors.transparent,
                                  borderRadius: BorderRadius.circular(4),
                                  border: isSelected
                                      ? Border.all(
                                          color: Colors.blue.withOpacity(0.5))
                                      : null,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      isSelected
                                          ? FluentIcons.radio_btn_on
                                          : FluentIcons.radio_btn_off,
                                      size: 16,
                                      color: isSelected
                                          ? Colors.blue
                                          : (isDark
                                              ? Colors.grey[100]
                                              : Colors.grey[130]),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        role.name,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: isSelected
                                              ? FontWeight.w600
                                              : FontWeight.normal,
                                          color: isSelected
                                              ? Colors.blue
                                              : (isDark
                                                  ? Colors.white
                                                  : const Color(0xFF333333)),
                                        ),
                                      ),
                                    ),
                                    if (role.code?.isNotEmpty == true)
                                      Text(
                                        role.code!,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: isDark
                                              ? Colors.grey[100]
                                              : Colors.grey[130],
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
        ),
      ],
    );
  }

  /// 门店选择器 - 使用固定高度的列表
  Widget _buildStoreSelector(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('所属门店', isDark: isDark),
        const SizedBox(height: 6),
        Consumer<StoreProvider>(
          builder: (context, provider, _) {
            if (provider.loading) {
              return Container(
                height: 100,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[150].withOpacity(0.1) : Colors.grey[20],
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: isDark
                        ? Colors.grey[100].withOpacity(0.2)
                        : const Color(0xFFE5E7EB),
                  ),
                ),
                child: const Center(child: ProgressRing(strokeWidth: 2)),
              );
            }
            
            if (provider.stores.isEmpty) {
              return Container(
                height: 100,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[150].withOpacity(0.1) : Colors.grey[20],
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: isDark
                        ? Colors.grey[100].withOpacity(0.2)
                        : const Color(0xFFE5E7EB),
                  ),
                ),
                child: Center(
                  child: Text(
                    '暂无门店数据',
                    style: TextStyle(
                      color: isDark ? Colors.grey[100] : const Color(0xFF999999),
                    ),
                  ),
                ),
              );
            }
            
            return Container(
              height: 100,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[150].withOpacity(0.1) : Colors.grey[20],
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isDark
                      ? Colors.grey[100].withOpacity(0.2)
                      : const Color(0xFFE5E7EB),
                ),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(4),
                itemCount: provider.stores.length,
                itemBuilder: (context, index) {
                  final store = provider.stores[index];
                  final isSelected = _storeId == store.id;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: HoverButton(
                      onPressed: () {
                        setState(() => _storeId = store.id);
                      },
                      builder: (context, states) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.blue.withOpacity(0.15)
                                : states.isHovered
                                    ? (isDark
                                        ? Colors.grey[150].withOpacity(0.1)
                                        : Colors.grey[30])
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                            border: isSelected
                                ? Border.all(color: Colors.blue.withOpacity(0.5))
                                : null,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isSelected
                                    ? FluentIcons.radio_btn_on
                                    : FluentIcons.radio_btn_off,
                                size: 16,
                                color: isSelected
                                    ? Colors.blue
                                    : (isDark
                                        ? Colors.grey[100]
                                        : Colors.grey[130]),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  store.name,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                    color: isSelected
                                        ? Colors.blue
                                        : (isDark
                                            ? Colors.white
                                            : const Color(0xFF333333)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  /// 状态切换
  Widget _buildStatusToggle(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('状态', isDark: isDark),
        const SizedBox(height: 6),
        Row(
          children: [
            ToggleSwitch(
              checked: _status == 1,
              onChanged: (value) {
                setState(() => _status = value ? 1 : 0);
              },
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: _status == 1
                    ? Colors.green.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _status == 1
                      ? Colors.green.withOpacity(0.3)
                      : Colors.grey.withOpacity(0.3),
                ),
              ),
              child: Text(
                _status == 1 ? '已启用' : '已禁用',
                style: TextStyle(
                  fontSize: 12,
                  color: _status == 1 ? Colors.green : Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
