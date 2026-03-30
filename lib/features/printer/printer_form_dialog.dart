import 'package:fluent_ui/fluent_ui.dart';
import 'models.dart';
class PrinterFormDialog extends StatefulWidget {
  final int storeId;
  final Printer? printer;
  const PrinterFormDialog({
    super.key,
    required this.storeId,
    this.printer,
  });
  @override
  State<PrinterFormDialog> createState() => _PrinterFormDialogState();
}
class _PrinterFormDialogState extends State<PrinterFormDialog> {
  late final TextEditingController _snCtrl;
  late final TextEditingController _nameCtrl;
  late final TextEditingController _remarkCtrl;
  int _type = 1;
  int _isDefault = 0;
  int _status = 1;
  bool get isEditing => widget.printer != null;
  @override
  void initState() {
    super.initState();
    _snCtrl = TextEditingController(text: widget.printer?.sn ?? '');
    _nameCtrl = TextEditingController(text: widget.printer?.name ?? '');
    _remarkCtrl = TextEditingController(text: widget.printer?.remark ?? '');
    if (widget.printer != null) {
      _type = widget.printer!.type ?? 1;
      _isDefault = widget.printer!.isDefault ?? 0;
      _status = widget.printer!.status ?? 1;
    }
  }
  @override
  void dispose() {
    _snCtrl.dispose();
    _nameCtrl.dispose();
    _remarkCtrl.dispose();
    super.dispose();
  }
  void _handleSubmit() {
    if (!isEditing && _snCtrl.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (context) => ContentDialog(
          title: const Text('提示'),
          content: const Text('请输入打印机SN号'),
          actions: [
            Button(
              onPressed: () => Navigator.pop(context),
              child: const Text('确定'),
            ),
          ],
        ),
      );
      return;
    }
    if (_nameCtrl.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (context) => ContentDialog(
          title: const Text('提示'),
          content: const Text('请输入打印机名称'),
          actions: [
            Button(
              onPressed: () => Navigator.pop(context),
              child: const Text('确定'),
            ),
          ],
        ),
      );
      return;
    }
    if (isEditing) {
      Navigator.pop(
        context,
        UpdatePrinterReq(
          name: _nameCtrl.text.trim(),
          type: _type,
          status: _status,
          isDefault: _isDefault,
          remark: _remarkCtrl.text.trim().isEmpty ? null : _remarkCtrl.text.trim(),
        ),
      );
    } else {
      Navigator.pop(
        context,
        BindPrinterReq(
          storeId: widget.storeId,
          sn: _snCtrl.text.trim(),
          name: _nameCtrl.text.trim(),
          type: _type,
          isDefault: _isDefault,
          remark: _remarkCtrl.text.trim().isEmpty ? null : _remarkCtrl.text.trim(),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return ContentDialog(
      title: Text(isEditing ? '编辑打印机' : '绑定打印机'),
      content: Container(
        width: 400,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isEditing) ...[
              _buildLabel('打印机SN号', required: true),
              const SizedBox(height: 8),
              TextBox(
                controller: _snCtrl,
                placeholder: '请输入打印机SN号',
              ),
              const SizedBox(height: 16),
            ],
            _buildLabel('打印机名称', required: true),
            const SizedBox(height: 8),
            TextBox(
              controller: _nameCtrl,
              placeholder: '请输入打印机名称',
            ),
            const SizedBox(height: 16),
            _buildLabel('打印机类型'),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: theme.resources.dividerStrokeColorDefault),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildRadioTile(
                      value: 1,
                      groupValue: _type,
                      label: '小票打印机',
                      icon: FluentIcons.print,
                      onChanged: (value) => setState(() => _type = value),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: theme.resources.dividerStrokeColorDefault,
                  ),
                  Expanded(
                    child: _buildRadioTile(
                      value: 2,
                      groupValue: _type,
                      label: '标签打印机',
                      icon: FluentIcons.tag,
                      onChanged: (value) => setState(() => _type = value),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (isEditing) ...[
              _buildLabel('状态'),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: theme.resources.dividerStrokeColorDefault),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildRadioTile(
                        value: 1,
                        groupValue: _status,
                        label: '正常',
                        icon: FluentIcons.check_mark,
                        onChanged: (value) => setState(() => _status = value),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: theme.resources.dividerStrokeColorDefault,
                    ),
                    Expanded(
                      child: _buildRadioTile(
                        value: 2,
                        groupValue: _status,
                        label: '停用',
                        icon: FluentIcons.cancel,
                        onChanged: (value) => setState(() => _status = value),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
            Row(
              children: [
                ToggleSwitch(
                  checked: _isDefault == 1,
                  onChanged: (value) => setState(() => _isDefault = value ? 1 : 0),
                ),
                const SizedBox(width: 8),
                Text(
                  '设为默认打印机',
                  style: theme.typography.body,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildLabel('备注'),
            const SizedBox(height: 8),
            TextBox(
              controller: _remarkCtrl,
              placeholder: '可选',
              maxLines: 3,
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
          child: Text(isEditing ? '保存' : '绑定'),
        ),
      ],
    );
  }
  Widget _buildLabel(String text, {bool required = false}) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        if (required) ...[
          const SizedBox(width: 4),
          Text(
            '*',
            style: TextStyle(color: Colors.red, fontSize: 13),
          ),
        ],
      ],
    );
  }
  Widget _buildRadioTile({
    required int value,
    required int groupValue,
    required String label,
    required IconData icon,
    required ValueChanged<int> onChanged,
  }) {
    final isSelected = value == groupValue;
    final theme = FluentTheme.of(context);
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.teal.withOpacity(0.1)
              : (theme.brightness == Brightness.dark
                  ? const Color(0xFF2D2D2D)
                  : Colors.white),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.teal : Colors.grey,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: isSelected ? Colors.teal : (theme.brightness == Brightness.dark ? Colors.white : Colors.grey[160]),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}