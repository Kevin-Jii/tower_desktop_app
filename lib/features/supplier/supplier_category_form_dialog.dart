import 'package:fluent_ui/fluent_ui.dart';
import 'models.dart';

class SupplierCategoryFormDialog extends StatefulWidget {
  final int supplierId;
  final SupplierCategory? category;

  const SupplierCategoryFormDialog({
    super.key,
    required this.supplierId,
    this.category,
  });

  @override
  State<SupplierCategoryFormDialog> createState() => _SupplierCategoryFormDialogState();
}

class _SupplierCategoryFormDialogState extends State<SupplierCategoryFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _sortCtrl = TextEditingController();
  bool _status = true;

  bool get isEditMode => widget.category != null;

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      final c = widget.category!;
      _nameCtrl.text = c.name;
      _sortCtrl.text = (c.sort ?? 0).toString();
      _status = c.status == 1;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _sortCtrl.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final data = {
        'supplier_id': widget.supplierId,
        'name': _nameCtrl.text.trim(),
        'sort': int.tryParse(_sortCtrl.text.trim()) ?? 0,
        'status': _status ? 1 : 0,
      };
      Navigator.pop(context, data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text(isEditMode ? '编辑分类' : '新增分类'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoLabel(
              label: '分类名称',
              child: TextFormBox(
                controller: _nameCtrl,
                placeholder: '请输入分类名称',
                validator: (v) => v == null || v.isEmpty ? '名称不能为空' : null,
              ),
            ),
            const SizedBox(height: 12),
            InfoLabel(
              label: '排序',
              child: TextFormBox(
                controller: _sortCtrl,
                placeholder: '请输入排序值（数字越小越靠前）',
                keyboardType: TextInputType.number,
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
          ],
        ),
      ),
      actions: [
        Button(onPressed: () => Navigator.pop(context), child: const Text('取消')),
        FilledButton(onPressed: _handleSubmit, child: const Text('保存')),
      ],
    );
  }
}
