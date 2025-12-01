import 'package:fluent_ui/fluent_ui.dart';
import 'models.dart';

class SupplierFormDialog extends StatefulWidget {
  final Supplier? supplier;

  const SupplierFormDialog({super.key, this.supplier});

  @override
  State<SupplierFormDialog> createState() => _SupplierFormDialogState();
}

class _SupplierFormDialogState extends State<SupplierFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _contactPersonCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _remarkCtrl = TextEditingController();
  bool _status = true;

  @override
  void initState() {
    super.initState();
    if (widget.supplier != null) {
      final s = widget.supplier!;
      _nameCtrl.text = s.name;
      _contactPersonCtrl.text = s.contactPerson ?? '';
      _phoneCtrl.text = s.phone ?? '';
      _addressCtrl.text = s.address ?? '';
      _remarkCtrl.text = s.remark ?? '';
      _status = s.status == 1;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _contactPersonCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _remarkCtrl.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final data = {
        'supplier_name': _nameCtrl.text.trim(),
        'contact_person': _contactPersonCtrl.text.trim(),
        'contact_phone': _phoneCtrl.text.trim(),
        'supplier_address': _addressCtrl.text.trim(),
        'remark': _remarkCtrl.text.trim(),
        'status': _status ? 1 : 0,
      };
      Navigator.pop(context, data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text(widget.supplier == null ? '新增供应商' : '编辑供应商'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoLabel(
              label: '供应商名称',
              child: TextFormBox(
                controller: _nameCtrl,
                placeholder: '请输入供应商名称',
                validator: (v) => v == null || v.isEmpty ? '名称不能为空' : null,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: InfoLabel(
                    label: '联系人',
                    child: TextFormBox(
                      controller: _contactPersonCtrl,
                      placeholder: '请输入联系人姓名',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InfoLabel(
                    label: '联系电话',
                    child: TextFormBox(
                      controller: _phoneCtrl,
                      placeholder: '请输入联系电话',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            InfoLabel(
              label: '地址',
              child: TextFormBox(
                controller: _addressCtrl,
                placeholder: '请输入地址',
              ),
            ),
            const SizedBox(height: 12),
            InfoLabel(
              label: '状态',
              child: ToggleSwitch(
                checked: _status,
                content: Text(_status ? '启用' : '禁用'),
                onChanged: (v) => setState(() => _status = v),
              ),
            ),
            const SizedBox(height: 12),
            InfoLabel(
              label: '备注',
              child: TextFormBox(
                controller: _remarkCtrl,
                placeholder: '请输入备注信息',
                maxLines: 3,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Button(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _handleSubmit,
          child: const Text('保存'),
        ),
      ],
    );
  }
}
