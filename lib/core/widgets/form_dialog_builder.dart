import 'package:flutter/material.dart';

/// 表单字段配置
class FormFieldConfig {
  final String key;
  final String label;
  final String? hint;
  final TextInputType? keyboardType;
  final bool required;
  final int? maxLength;
  final int? maxLines;
  final String? initialValue;
  final Widget? suffix;
  final String? Function(String? value)? validator;

  const FormFieldConfig({
    required this.key,
    required this.label,
    this.hint,
    this.keyboardType,
    this.required = false,
    this.maxLength,
    this.maxLines = 1,
    this.initialValue,
    this.suffix,
    this.validator,
  });
}

/// 通用表单 Dialog 构建器
class FormDialog extends StatefulWidget {
  final String title;
  final List<FormFieldConfig> fields;
  final Map<String, dynamic> initialData;

  const FormDialog({
    super.key,
    required this.title,
    required this.fields,
    this.initialData = const {},
  });

  static Future<Map<String, String>?> show(
    BuildContext context, {
    required String title,
    required List<FormFieldConfig> fields,
    Map<String, dynamic> initialData = const {},
  }) async {
    return showDialog<Map<String, String>?>(
      context: context,
      builder: (_) => FormDialog(
        title: title,
        fields: fields,
        initialData: initialData,
      ),
    );
  }

  @override
  State<FormDialog> createState() => _FormDialogState();
}

class _FormDialogState extends State<FormDialog> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    for (final field in widget.fields) {
      _controllers[field.key] = TextEditingController(
        text: widget.initialData[field.key]?.toString() ??
              (field.initialValue ?? ''),
      );
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final result = {
        for (final field in widget.fields)
          field.key: _controllers[field.key]!.text.trim(),
      };
      Navigator.pop(context, result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 20),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      children: widget.fields.map((field) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: TextFormField(
                            controller: _controllers[field.key],
                            keyboardType: field.keyboardType,
                            maxLength: field.maxLength,
                            maxLines: field.maxLines,
                            decoration: InputDecoration(
                              labelText:
                                  field.label +
                                  (field.required ? ' *' : ''),
                              hintText: field.hint,
                              suffixIcon: field.suffix,
                              border: const OutlineInputBorder(),
                            ),
                            validator: field.validator ??
                                (field.required
                                    ? (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return '此项为必填';
                                        }
                                        return null;
                                      }
                                    : null),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('取消'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _submit,
                        child: const Text('确定'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
