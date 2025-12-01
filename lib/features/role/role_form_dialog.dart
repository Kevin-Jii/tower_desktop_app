import 'package:fluent_ui/fluent_ui.dart';
import 'role_models.dart';

class RoleFormDialog extends StatefulWidget {
  final RoleItem? editing;
  const RoleFormDialog({super.key, this.editing});
  @override
  State<RoleFormDialog> createState() => _RoleFormDialogState();
}

class _RoleFormDialogState extends State<RoleFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  // 受保护的角色编码，不允许修改编码和名称
  static const _protectedRoleCodes = ['store_admin', 'staff'];

  /// 判断当前编辑的角色是否为受保护角色
  bool get _isProtectedRole {
    if (widget.editing == null) return false;
    final code = widget.editing!.code;
    return _protectedRoleCodes.contains(code);
  }

  @override
  void initState() {
    super.initState();
    if (widget.editing != null) {
      final r = widget.editing!;
      _nameCtrl.text = r.name;
      _codeCtrl.text = r.code ?? '';
      _descCtrl.text = r.description ?? '';
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _codeCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    // 验证必填字段
    if (_nameCtrl.text.trim().isEmpty) {
      return;
    }
    
    if (widget.editing != null) {
      // 受保护角色不允许修改编码和名称
      final req = UpdateRoleRequest(
        name: _isProtectedRole ? null : _nameCtrl.text.trim(),
        code: _isProtectedRole ? null : (_codeCtrl.text.trim().isEmpty ? null : _codeCtrl.text.trim()),
        description: _descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim(),
      );
      Navigator.pop(context, req);
    } else {
      final req = CreateRoleRequest(
        name: _nameCtrl.text.trim(),
        code: _codeCtrl.text.trim().isNotEmpty ? _codeCtrl.text.trim() : 'default_code',
        description: _descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim(),
      );
      Navigator.pop(context, req);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.editing != null;
    
    return ContentDialog(
      title: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isEditing
                ? [Colors.orange.withOpacity(0.1), Colors.orange.withOpacity(0.05)]
                : [Colors.blue.withOpacity(0.1), Colors.blue.withOpacity(0.05)],
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isEditing
                      ? [Colors.orange, Colors.orange.lighter]
                      : [Colors.blue, Colors.blue.lighter],
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: (isEditing ? Colors.orange : Colors.blue).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                isEditing ? FluentIcons.edit : FluentIcons.add,
                size: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isEditing ? '编辑角色' : '新增角色',
                  style: FluentTheme.of(context).typography.subtitle?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  isEditing ? '修改角色信息' : '创建新的系统角色',
                  style: FluentTheme.of(context).typography.caption?.copyWith(
                    color: Colors.grey[130],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      content: Container(
        width: 500,
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoLabel(
                label: '角色名称 *',
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextBox(
                    controller: _nameCtrl,
                    placeholder: '例如：系统管理员、普通用户',
                    autofocus: !_isProtectedRole,
                    enabled: !_isProtectedRole,
                    prefix: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(FluentIcons.contact, size: 16, color: Colors.grey[130]),
                    ),
                  ),
                ),
              ),
              if (_isProtectedRole) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.orange.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(FluentIcons.lock, size: 12, color: Colors.orange),
                      const SizedBox(width: 6),
                      Text(
                        '系统内置角色，名称不可修改',
                        style: TextStyle(fontSize: 11, color: Colors.orange.dark),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 20),
              InfoLabel(
                label: '角色编码',
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextBox(
                    controller: _codeCtrl,
                    placeholder: '例如：admin、user、guest',
                    enabled: !_isProtectedRole,
                    prefix: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(FluentIcons.code, size: 16, color: Colors.grey[130]),
                    ),
                    style: const TextStyle(fontFamily: 'monospace'),
                  ),
                ),
              ),
              if (_isProtectedRole) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.orange.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(FluentIcons.lock, size: 12, color: Colors.orange),
                      const SizedBox(width: 6),
                      Text(
                        '系统内置角色，编码不可修改',
                        style: TextStyle(fontSize: 11, color: Colors.orange.dark),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 20),
              InfoLabel(
                label: '角色描述',
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextBox(
                    controller: _descCtrl,
                    placeholder: '描述该角色的职责和权限范围...',
                    maxLines: 4,
                    minLines: 3,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.withOpacity(0.08),
                      Colors.purple.withOpacity(0.08),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.blue.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(FluentIcons.lightbulb, size: 18, color: Colors.blue),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '💡 温馨提示',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.blue.dark,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '角色编码用于系统内部识别，建议使用英文小写字母和下划线',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue.darker,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Button(
          onPressed: () => Navigator.pop(context),
          style: ButtonStyle(
            padding: ButtonState.all(
              const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(FluentIcons.cancel, size: 14),
              SizedBox(width: 6),
              Text('取消'),
            ],
          ),
        ),
        FilledButton(
          onPressed: _submit,
          style: ButtonStyle(
            padding: ButtonState.all(
              const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(FluentIcons.save, size: 14),
              SizedBox(width: 6),
              Text('保存'),
            ],
          ),
        ),
      ],
    );
  }
}
