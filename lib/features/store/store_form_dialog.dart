import 'package:fluent_ui/fluent_ui.dart';
import 'models.dart';
class StoreFormDialog extends StatefulWidget {
  final Store? store;
  const StoreFormDialog({super.key, this.store});
  @override
  State<StoreFormDialog> createState() => _StoreFormDialogState();
}
class _StoreFormDialogState extends State<StoreFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _contactPersonCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _businessHoursCtrl = TextEditingController();
  final _remarkCtrl = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.store != null) {
      final s = widget.store!;
      _nameCtrl.text = s.name;
      _addressCtrl.text = s.address ?? '';
      _contactPersonCtrl.text = s.contactPerson ?? '';
      _phoneCtrl.text = s.phone ?? '';
      _businessHoursCtrl.text = s.businessHours ?? '';
      _remarkCtrl.text = s.remark ?? '';
    }
  }
  @override
  void dispose() {
    _nameCtrl.dispose();
    _addressCtrl.dispose();
    _contactPersonCtrl.dispose();
    _phoneCtrl.dispose();
    _businessHoursCtrl.dispose();
    _remarkCtrl.dispose();
    super.dispose();
  }
  void _submit() {
    if (widget.store != null) {
      final req = UpdateStoreRequest(
        name: _nameCtrl.text.trim(),
        address: _addressCtrl.text.trim().isEmpty ? null : _addressCtrl.text.trim(),
        contactPerson: _contactPersonCtrl.text.trim().isEmpty
            ? null
            : _contactPersonCtrl.text.trim(),
        phone: _phoneCtrl.text.trim().isEmpty ? null : _phoneCtrl.text.trim(),
        businessHours: _businessHoursCtrl.text.trim().isEmpty
            ? null
            : _businessHoursCtrl.text.trim(),
        remark: _remarkCtrl.text.trim().isEmpty ? null : _remarkCtrl.text.trim(),
      );
      Navigator.pop(context, req);
    } else {
      final req = CreateStoreRequest(
        name: _nameCtrl.text.trim(),
        address: _addressCtrl.text.trim().isEmpty ? null : _addressCtrl.text.trim(),
        contactPerson: _contactPersonCtrl.text.trim().isEmpty
            ? null
            : _contactPersonCtrl.text.trim(),
        phone: _phoneCtrl.text.trim().isEmpty ? null : _phoneCtrl.text.trim(),
        businessHours: _businessHoursCtrl.text.trim().isEmpty
            ? null
            : _businessHoursCtrl.text.trim(),
        remark: _remarkCtrl.text.trim().isEmpty ? null : _remarkCtrl.text.trim(),
        status: 1, 
      );
      Navigator.pop(context, req);
    }
  }
  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text(widget.store == null ? '新增门店' : '编辑门店'),
      content: SizedBox(
        width: 500,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InfoLabel(
                  label: '门店名称 *',
                  child: TextBox(
                    controller: _nameCtrl,
                    placeholder: '请输入门店名称',
                  ),
                ),
                const SizedBox(height: 16),
                InfoLabel(
                  label: '门店地址',
                  child: TextBox(
                    controller: _addressCtrl,
                    placeholder: '请输入门店地址',
                  ),
                ),
                const SizedBox(height: 16),
                InfoLabel(
                  label: '负责人',
                  child: TextBox(
                    controller: _contactPersonCtrl,
                    placeholder: '请输入负责人姓名',
                  ),
                ),
                const SizedBox(height: 16),
                InfoLabel(
                  label: '联系电话',
                  child: TextBox(
                    controller: _phoneCtrl,
                    placeholder: '请输入联系电话',
                  ),
                ),
                const SizedBox(height: 16),
                InfoLabel(
                  label: '营业时间',
                  child: TextBox(
                    controller: _businessHoursCtrl,
                    placeholder: '例如: 09:00-22:00',
                  ),
                ),
                const SizedBox(height: 16),
                InfoLabel(
                  label: '备注',
                  child: TextBox(
                    controller: _remarkCtrl,
                    placeholder: '请输入备注信息',
                    maxLines: 3,
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
