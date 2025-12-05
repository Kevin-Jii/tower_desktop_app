import 'package:fluent_ui/fluent_ui.dart';
import 'models.dart';

class DictTypeFormDialog extends StatefulWidget {
  final DictType? editing;

  const DictTypeFormDialog({super.key, this.editing});

  @override
  State<DictTypeFormDialog> createState() => _DictTypeFormDialogState();
}

class _DictTypeFormDialogState extends State<DictTypeFormDialog> {
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _remarkController = TextEditingController();
  int _status = 1;

  bool get isEditing => widget.editing != null;

  @override
  void initState() {
    super.initState();
    if (widget.editing != null) {
      _codeController.text = widget.editing!.code;
      _nameController.text = widget.editing!.name;
      _remarkController.text = widget.editing!.remark ?? '';
      _status = widget.editing!.status;
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    _remarkController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final code = _codeController.text.trim();
    final name = _nameController.text.trim();

    if (code.isEmpty || name.isEmpty) {
      return;
    }

    if (isEditing) {
      Navigator.pop(
        context,
        UpdateDictTypeRequest(
          code: code != widget.editing!.code ? code : null,
          name: name != widget.editing!.name ? name : null,
          remark: _remarkController.text.trim(),
          status: _status,
        ),
      );
    } else {
      Navigator.pop(
        context,
        CreateDictTypeRequest(
          code: code,
          name: name,
          remark: _remarkController.text.trim(),
          status: _status,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text(isEditing ? '编辑字典类型' : '新增字典类型'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InfoLabel(
            label: '类型编码 *',
            child: TextBox(
              controller: _codeController,
              placeholder: '如: sys_status',
              enabled: !isEditing,
            ),
          ),
          const SizedBox(height: 16),
          InfoLabel(
            label: '类型名称 *',
            child: TextBox(
              controller: _nameController,
              placeholder: '如: 系统状态',
            ),
          ),
          const SizedBox(height: 16),
          InfoLabel(
            label: '备注',
            child: TextBox(
              controller: _remarkController,
              placeholder: '可选',
              maxLines: 2,
            ),
          ),
          const SizedBox(height: 16),
          InfoLabel(
            label: '状态',
            child: Row(
              children: [
                RadioButton(
                  checked: _status == 1,
                  onChanged: (v) => setState(() => _status = 1),
                  content: const Text('启用'),
                ),
                const SizedBox(width: 24),
                RadioButton(
                  checked: _status == 0,
                  onChanged: (v) => setState(() => _status = 0),
                  content: const Text('禁用'),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Button(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _handleSubmit,
          child: const Text('确定'),
        ),
      ],
    );
  }
}
