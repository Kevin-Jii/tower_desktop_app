import 'package:fluent_ui/fluent_ui.dart';
import '../../core/network/api_client.dart';
import 'models.dart';
import 'member_api.dart';
class MemberFormDialog extends StatefulWidget {
  final Member? member;
  final ApiClient apiClient;
  const MemberFormDialog({
    super.key,
    this.member,
    required this.apiClient,
  });
  @override
  State<MemberFormDialog> createState() => _MemberFormDialogState();
}
class _MemberFormDialogState extends State<MemberFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _remarkController = TextEditingController();
  bool _loading = false;
  String? _error;
  @override
  void initState() {
    super.initState();
    if (widget.member != null) {
      _nameController.text = widget.member?.name ?? '';
      _phoneController.text = widget.member?.phone ?? '';
      _remarkController.text = widget.member?.remark ?? '';
    }
  }
  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _remarkController.dispose();
    super.dispose();
  }
  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final api = MemberApi(widget.apiClient);
      if (widget.member == null) {
        final request = CreateMemberRequest(
          name: _nameController.text.trim(),
          phone: _phoneController.text.trim(),
          remark: _remarkController.text.trim().isEmpty ? null : _remarkController.text.trim(),
        );
        final result = await api.createMember(request);
        if (result != null && mounted) {
          Navigator.of(context).pop(true);
        }
      } else {
        final request = UpdateMemberRequest(
          name: _nameController.text.trim(),
          phone: _phoneController.text.trim(),
          remark: _remarkController.text.trim().isEmpty ? null : _remarkController.text.trim(),
        );
        final result = await api.updateMember(widget.member!.id, request);
        if (result != null && mounted) {
          Navigator.of(context).pop(true);
        }
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final isEdit = widget.member != null;
    return ContentDialog(
      title: Text(isEdit ? '编辑会员' : '新增会员'),
      style: ContentDialogThemeData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: FluentTheme.of(context).micaBackgroundColor,
        ),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoLabel(
              label: '会员姓名',
              child: TextFormBox(
                controller: _nameController,
                placeholder: '请输入会员姓名',
                validator: (v) => v == null || v.isEmpty ? '请输入会员姓名' : null,
              ),
            ),
            const SizedBox(height: 12),
            InfoLabel(
              label: '手机号码',
              child: TextFormBox(
                controller: _phoneController,
                placeholder: '请输入手机号码',
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return '请输入手机号码';
                  }
                  if (v.length != 11) {
                    return '请输入正确的手机号码';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 12),
            InfoLabel(
              label: '备注',
              child: TextFormBox(
                controller: _remarkController,
                placeholder: '请输入备注信息（选填）',
                maxLines: 3,
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: 12),
              InfoBar(
                title: const Text('操作失败'),
                content: Text(_error!),
                severity: InfoBarSeverity.error,
              ),
            ],
          ],
        ),
      ),
      actions: [
        Button(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _loading ? null : _save,
          child: _loading
              ? const ProgressRing(strokeWidth: 2)
              : Text(isEdit ? '保存' : '创建'),
        ),
      ],
    );
  }
}
class AdjustBalanceDialog extends StatefulWidget {
  final Member member;
  final ApiClient apiClient;
  const AdjustBalanceDialog({
    super.key,
    required this.member,
    required this.apiClient,
  });
  @override
  State<AdjustBalanceDialog> createState() => _AdjustBalanceDialogState();
}
class _AdjustBalanceDialogState extends State<AdjustBalanceDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _remarkController = TextEditingController();
  int _adjustType = 1; 
  bool _loading = false;
  String? _error;
  @override
  void dispose() {
    _amountController.dispose();
    _remarkController.dispose();
    super.dispose();
  }
  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final amount = double.tryParse(_amountController.text.trim());
    if (amount == null || amount <= 0) {
      setState(() {
        _error = '请输入有效的金额';
      });
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final api = MemberApi(widget.apiClient);
      final request = AdjustBalanceRequest(
        amount: amount,
        type: _adjustType,
        remark: _remarkController.text.trim().isEmpty ? null : _remarkController.text.trim(),
      );
      final result = await api.adjustBalance(widget.member.id, request);
      if (result != null && mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text('调整余额 - ${widget.member.name}'),
      style: ContentDialogThemeData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: FluentTheme.of(context).micaBackgroundColor,
        ),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[20],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  const Icon(FluentIcons.money, size: 16),
                  const SizedBox(width: 8),
                  Text('当前余额: ¥${(widget.member.balance ?? 0.0).toStringAsFixed(2)}'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text('调整类型', style: FluentTheme.of(context).typography.body),
            const SizedBox(height: 8),
            Row(
              children: [
                RadioButton(
                  checked: _adjustType == 1,
                  onChanged: (value) {
                    if (value) {
                      setState(() {
                        _adjustType = 1;
                      });
                    }
                  },
                  content: const Text('增加余额'),
                ),
                const SizedBox(width: 16),
                RadioButton(
                  checked: _adjustType == 2,
                  onChanged: (value) {
                    if (value) {
                      setState(() {
                        _adjustType = 2;
                      });
                    }
                  },
                  content: const Text('减少余额'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            InfoLabel(
              label: '金额',
              child: TextFormBox(
                controller: _amountController,
                placeholder: '请输入调整金额',
                prefix: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('¥'),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return '请输入金额';
                  }
                  final amount = double.tryParse(v);
                  if (amount == null || amount <= 0) {
                    return '请输入有效的金额';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 12),
            InfoLabel(
              label: '调整原因',
              child: TextFormBox(
                controller: _remarkController,
                placeholder: '请输入调整原因（选填）',
                maxLines: 3,
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: 12),
              InfoBar(
                title: const Text('操作失败'),
                content: Text(_error!),
                severity: InfoBarSeverity.error,
              ),
            ],
          ],
        ),
      ),
      actions: [
        Button(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _loading ? null : _save,
          child: _loading
              ? const ProgressRing(strokeWidth: 2)
              : const Text('确认调整'),
        ),
      ],
    );
  }
}
