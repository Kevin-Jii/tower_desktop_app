import 'package:fluent_ui/fluent_ui.dart';
import 'models.dart';

class DictDataFormDialog extends StatefulWidget {
  final String typeCode;
  final DictData? editing;

  const DictDataFormDialog({
    super.key,
    required this.typeCode,
    this.editing,
  });

  @override
  State<DictDataFormDialog> createState() => _DictDataFormDialogState();
}

class _DictDataFormDialogState extends State<DictDataFormDialog> {
  final _labelController = TextEditingController();
  final _valueController = TextEditingController();
  final _sortController = TextEditingController();
  final _cssClassController = TextEditingController();
  final _remarkController = TextEditingController();
  String? _listClass;
  bool _isDefault = false;
  int _status = 1;

  bool get isEditing => widget.editing != null;

  static const _listClassOptions = [
    ('', '无'),
    ('success', '成功(绿色)'),
    ('info', '信息(蓝色)'),
    ('warning', '警告(橙色)'),
    ('danger', '危险(红色)'),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.editing != null) {
      _labelController.text = widget.editing!.label;
      _valueController.text = widget.editing!.value;
      _sortController.text = widget.editing!.sort.toString();
      _cssClassController.text = widget.editing!.cssClass ?? '';
      _remarkController.text = widget.editing!.remark ?? '';
      _listClass = widget.editing!.listClass;
      _isDefault = widget.editing!.isDefault;
      _status = widget.editing!.status;
    } else {
      _sortController.text = '0';
    }
  }

  @override
  void dispose() {
    _labelController.dispose();
    _valueController.dispose();
    _sortController.dispose();
    _cssClassController.dispose();
    _remarkController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final label = _labelController.text.trim();
    final value = _valueController.text.trim();

    if (label.isEmpty || value.isEmpty) {
      return;
    }

    final sort = int.tryParse(_sortController.text.trim()) ?? 0;

    if (isEditing) {
      Navigator.pop(
        context,
        UpdateDictDataRequest(
          label: label,
          value: value,
          sort: sort,
          cssClass: _cssClassController.text.trim(),
          listClass: _listClass,
          isDefault: _isDefault,
          remark: _remarkController.text.trim(),
          status: _status,
        ),
      );
    } else {
      Navigator.pop(
        context,
        CreateDictDataRequest(
          typeCode: widget.typeCode,
          label: label,
          value: value,
          sort: sort,
          cssClass: _cssClassController.text.trim(),
          listClass: _listClass,
          isDefault: _isDefault,
          remark: _remarkController.text.trim(),
          status: _status,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text(isEditing ? '编辑字典数据' : '新增字典数据'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: InfoLabel(
                    label: '标签 *',
                    child: TextBox(
                      controller: _labelController,
                      placeholder: '显示文本',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: InfoLabel(
                    label: '值 *',
                    child: TextBox(
                      controller: _valueController,
                      placeholder: '实际值',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: InfoLabel(
                    label: '排序',
                    child: NumberBox<int>(
                      value: int.tryParse(_sortController.text) ?? 0,
                      onChanged: (v) => _sortController.text = (v ?? 0).toString(),
                      min: 0,
                      mode: SpinButtonPlacementMode.none,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: InfoLabel(
                    label: '列表样式',
                    child: ComboBox<String>(
                      isExpanded: true,
                      value: _listClass ?? '',
                      items: _listClassOptions
                          .map((e) => ComboBoxItem<String>(value: e.$1, child: Text(e.$2)))
                          .toList(),
                      onChanged: (v) => setState(() => _listClass = v?.isEmpty == true ? null : v),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            InfoLabel(
              label: 'CSS类名',
              child: TextBox(
                controller: _cssClassController,
                placeholder: '可选，自定义样式类',
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
            Row(
              children: [
                Expanded(
                  child: InfoLabel(
                    label: '状态',
                    child: Row(
                      children: [
                        RadioButton(
                          checked: _status == 1,
                          onChanged: (v) => setState(() => _status = 1),
                          content: const Text('启用'),
                        ),
                        const SizedBox(width: 16),
                        RadioButton(
                          checked: _status == 0,
                          onChanged: (v) => setState(() => _status = 0),
                          content: const Text('禁用'),
                        ),
                      ],
                    ),
                  ),
                ),
                Checkbox(
                  checked: _isDefault,
                  onChanged: (v) => setState(() => _isDefault = v ?? false),
                  content: const Text('设为默认'),
                ),
              ],
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
          child: const Text('确定'),
        ),
      ],
    );
  }
}
