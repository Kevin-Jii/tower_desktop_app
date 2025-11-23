import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'models.dart';
import '../role/role_provider.dart';
import '../store/store_provider.dart';

class UserFormDialog extends StatefulWidget {
  final User? user;

  const UserFormDialog({super.key, this.user});

  @override
  State<UserFormDialog> createState() => _UserFormDialogState();
}

class _UserFormDialogState extends State<UserFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _nicknameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  
  int? _roleId;
  int? _storeId;
  int _status = 1;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      final u = widget.user!;
      _usernameCtrl.text = u.username;
      _nicknameCtrl.text = u.nickname ?? '';
      _phoneCtrl.text = u.phone;
      _emailCtrl.text = u.email ?? '';
      _roleId = u.roleId;
      _storeId = u.storeId;
      _status = u.status ?? 1;
    }
    
    // 加载角色和门店列表
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StoreProvider>().loadStores(pageSize: 1000);
    });
  }

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _nicknameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (widget.user != null) {
      // 编辑模式
      final req = UpdateUserRequest(
        phone: _phoneCtrl.text.trim(),
        nickname: _nicknameCtrl.text.trim().isEmpty
            ? null
            : _nicknameCtrl.text.trim(),
        email: _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
        password: _passwordCtrl.text.isEmpty ? null : _passwordCtrl.text,
        roleId: _roleId,
        storeId: _storeId,
        status: _status,
      );
      Navigator.pop(context, req);
    } else {
      // 新增模式
      final req = CreateUserRequest(
        username: _usernameCtrl.text.trim(),
        phone: _phoneCtrl.text.trim(),
        password: _passwordCtrl.text,
        nickname: _nicknameCtrl.text.trim().isEmpty
            ? null
            : _nicknameCtrl.text.trim(),
        email: _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
        roleId: _roleId,
        storeId: _storeId,
        status: _status,
      );
      Navigator.pop(context, req);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text(widget.user == null ? '新增用户' : '编辑用户'),
      content: SizedBox(
        width: 500,
        height: 500,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InfoLabel(
                  label: '用户名 *',
                  child: TextBox(
                    controller: _usernameCtrl,
                    placeholder: '请输入用户名',
                  ),
                ),
                const SizedBox(height: 16),
                InfoLabel(
                  label: '昵称',
                  child: TextBox(
                    controller: _nicknameCtrl,
                    placeholder: '请输入昵称',
                  ),
                ),
                const SizedBox(height: 16),
                InfoLabel(
                  label: '手机号 *',
                  child: TextBox(
                    controller: _phoneCtrl,
                    placeholder: '请输入11位手机号',
                  ),
                ),
                const SizedBox(height: 16),
                InfoLabel(
                  label: '邮箱',
                  child: TextBox(
                    controller: _emailCtrl,
                    placeholder: '请输入邮箱地址',
                  ),
                ),
                const SizedBox(height: 16),
                InfoLabel(
                  label: widget.user == null ? '密码 *' : '密码（留空不修改）',
                  child: PasswordBox(
                    controller: _passwordCtrl,
                    placeholder: widget.user == null ? '请输入密码' : '留空则不修改密码',
                  ),
                ),
                const SizedBox(height: 16),
                InfoLabel(
                  label: '所属门店',
                  child: Consumer<StoreProvider>(
                    builder: (context, provider, _) {
                      if (provider.loading) {
                        return const ProgressRing();
                      }
                      return ComboBox<int>(
                        value: _storeId,
                        placeholder: const Text('请选择门店'),
                        items: provider.stores
                            .map((store) => ComboBoxItem<int>(
                                  value: store.id,
                                  child: Text(store.name),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() => _storeId = value);
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                InfoLabel(
                  label: '状态',
                  child: ComboBox<int>(
                    value: _status,
                    items: const [
                      ComboBoxItem(value: 1, child: Text('启用')),
                      ComboBoxItem(value: 0, child: Text('禁用')),
                    ],
                    onChanged: (value) {
                      setState(() => _status = value ?? 1);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        Button(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _submit,
          child: const Text('保存'),
        ),
      ],
    );
  }
}
