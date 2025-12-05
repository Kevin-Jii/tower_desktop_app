import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'models.dart';
import '../dict/dict_provider.dart';
import '../dict/models.dart' as dict;

class SupplierProductFormDialog extends StatefulWidget {
  final int supplierId;
  final int categoryId;
  final SupplierProduct? product;

  const SupplierProductFormDialog({
    super.key,
    required this.supplierId,
    required this.categoryId,
    this.product,
  });

  @override
  State<SupplierProductFormDialog> createState() => _SupplierProductFormDialogState();
}

class _SupplierProductFormDialogState extends State<SupplierProductFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _remarkCtrl = TextEditingController();
  String? _selectedUnit;
  bool _status = true;
  
  List<dict.DictData> _unitOptions = [];
  bool _dictLoading = true;

  bool get isEditMode => widget.product != null;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      final p = widget.product!;
      _nameCtrl.text = p.name;
      _selectedUnit = p.unit;
      _priceCtrl.text = p.price?.toString() ?? '';
      _remarkCtrl.text = p.remark ?? '';
      _status = p.status == 1;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDictData();
    });
  }

  Future<void> _loadDictData() async {
    final dictProvider = context.read<DictProvider>();
    await dictProvider.loadAllDicts();
    if (mounted) {
      setState(() {
        _unitOptions = dictProvider.getDictByCode('GYSGL_SPDW');
        _dictLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _priceCtrl.dispose();
    _remarkCtrl.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final data = {
        'supplier_id': widget.supplierId,
        'category_id': widget.categoryId,
        'name': _nameCtrl.text.trim(),
        'unit': _selectedUnit ?? '',
        'price': double.tryParse(_priceCtrl.text.trim()) ?? 0.0,
        'remark': _remarkCtrl.text.trim(),
        'status': _status ? 1 : 0,
      };
      Navigator.pop(context, data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text(isEditMode ? '编辑商品' : '新增商品'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoLabel(
              label: '商品名称',
              child: TextFormBox(
                controller: _nameCtrl,
                placeholder: '请输入商品名称',
                enabled: !isEditMode, // 编辑模式下禁用
                validator: (v) => v == null || v.isEmpty ? '名称不能为空' : null,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: InfoLabel(
                    label: '单位',
                    child: _dictLoading
                        ? const Center(child: ProgressRing())
                        : ComboBox<String>(
                            value: _selectedUnit,
                            placeholder: const Text('请选择单位'),
                            isExpanded: true,
                            items: _unitOptions.map((d) => ComboBoxItem<String>(
                              value: d.value,
                              child: Text(d.label),
                            )).toList(),
                            onChanged: (v) => setState(() => _selectedUnit = v),
                          ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InfoLabel(
                    label: '价格',
                    child: TextFormBox(
                      controller: _priceCtrl,
                      placeholder: '请输入价格',
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                ),
              ],
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
                maxLines: 2,
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
