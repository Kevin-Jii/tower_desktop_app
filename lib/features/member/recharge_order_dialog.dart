import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../../core/network/api_client.dart';
import '../dict/dict_provider.dart';
import 'models.dart';
import 'member_api.dart';
class CreateRechargeDialog extends StatefulWidget {
  final Member member;
  final ApiClient apiClient;
  const CreateRechargeDialog({
    super.key,
    required this.member,
    required this.apiClient,
  });
  @override
  State<CreateRechargeDialog> createState() => _CreateRechargeDialogState();
}
class _CreateRechargeDialogState extends State<CreateRechargeDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _remarkController = TextEditingController();
  dynamic _payType;
  bool _loading = false;
  String? _error;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dictProvider = context.read<DictProvider>();
      if (dictProvider.getDictByCode('MDGL_ZFFS').isEmpty) {
        dictProvider.loadAllDicts();
      }
    });
  }
  @override
  void dispose() {
    _amountController.dispose();
    _remarkController.dispose();
    super.dispose();
  }
  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_payType == null) {
      setState(() {
        _error = '请选择支付方式';
      });
      return;
    }
    final amount = double.tryParse(_amountController.text.trim());
    if (amount == null || amount <= 0) {
      setState(() {
        _error = '请输入有效的充值金额';
      });
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      int payTypeValue;
      if (_payType is String) {
        payTypeValue = int.parse(_payType!);
      } else if (_payType is int) {
        payTypeValue = _payType!;
      } else {
        payTypeValue = int.tryParse(_payType.toString()) ?? 0;
      }
      final api = MemberApi(widget.apiClient);
      final request = CreateRechargeOrderRequest(
        memberId: widget.member.id,
        payAmount: amount,
        giftAmount: 0,
        payType: payTypeValue,
        remark: _remarkController.text.trim().isEmpty
            ? null
            : _remarkController.text.trim(),
      );
      final result = await api.createRechargeOrder(request);
      if (result != null && mounted) {
        Navigator.of(context).pop(result);
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
    final theme = FluentTheme.of(context);
    return ContentDialog(
      title: const Text('创建充值单'),
      style: ContentDialogThemeData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: FluentTheme.of(context).micaBackgroundColor,
        ),
      ),
      constraints: const BoxConstraints(maxWidth: 600),
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
                  const Icon(FluentIcons.contact, size: 16),
                  const SizedBox(width: 8),
                  Text('会员: ${widget.member.name}'),
                  const SizedBox(width: 16),
                  Text('手机: ${widget.member.phone}'),
                  const SizedBox(width: 16),
                  Text(
                      '当前余额: ¥${(widget.member.balance ?? 0.0).toStringAsFixed(2)}'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            InfoLabel(
              label: '充值金额',
              child: TextFormBox(
                controller: _amountController,
                placeholder: '请输入充值金额',
                prefix: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('¥'),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return '请输入充值金额';
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
            Text('支付方式', style: theme.typography.body),
            const SizedBox(height: 8),
            Consumer<DictProvider>(
              builder: (context, dictProvider, child) {
                final payMethods = dictProvider.getDictByCode('MDGL_ZFFS');
                if (payMethods.isEmpty) {
                  return const Text('加载支付方式中...');
                }
                final rows = <List<dynamic>>[];
                for (var i = 0; i < payMethods.length; i += 3) {
                  rows.add(payMethods.sublist(
                    i,
                    i + 3 > payMethods.length ? payMethods.length : i + 3,
                  ));
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: rows.map((row) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: row.map((item) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: _buildPayTypeOption(
                              item.value,
                              _getPayIcon(item.label),
                              item.label,
                              theme,
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }).toList(),
                );
              },
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
                title: const Text('创建失败'),
                content: Text(_error!),
                severity: InfoBarSeverity.error,
              ),
            ],
          ],
        ),
      ),
      actions: [
        Button(
          onPressed: () => Navigator.of(context).pop(null),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _loading ? null : _save,
          child: _loading
              ? const ProgressRing(strokeWidth: 2)
              : const Text('创建充值单'),
        ),
      ],
    );
  }
  Widget _buildPayTypeOption(
      dynamic type, IconData icon, String label, FluentThemeData theme) {
    final isSelected = _payType == type;
    return HoverButton(
      onPressed: () {
        setState(() {
          _payType = type;
        });
      },
      builder: (context, states) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.accentColor
                : states.isHovered
                    ? Colors.grey[30]
                    : Colors.grey[20],
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: isSelected ? theme.accentColor : Colors.grey[100]!,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16),
              const SizedBox(width: 6),
              Text(label),
            ],
          ),
        );
      },
    );
  }
  IconData _getPayIcon(String label) {
    if (label.contains('微信')) return FluentIcons.chat;
    if (label.contains('支付宝')) return FluentIcons.payment_card;
    if (label.contains('现金')) return FluentIcons.money;
    if (label.contains('银行')) return FluentIcons.bank;
    return FluentIcons.payment_card;
  }
}
class PayRechargeDialog extends StatefulWidget {
  final RechargeOrder order;
  final ApiClient apiClient;
  const PayRechargeDialog({
    super.key,
    required this.order,
    required this.apiClient,
  });
  @override
  State<PayRechargeDialog> createState() => _PayRechargeDialogState();
}
class _PayRechargeDialogState extends State<PayRechargeDialog> {
  dynamic _payType;
  bool _loading = false;
  String? _error;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dictProvider = context.read<DictProvider>();
      if (dictProvider.getDictByCode('MDGL_ZFFS').isEmpty) {
        dictProvider.loadAllDicts();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return ContentDialog(
      title: const Text('支付充值单'),
      style: ContentDialogThemeData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: FluentTheme.of(context).micaBackgroundColor,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[20],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('订单号: ${widget.order.orderNo}'),
                const SizedBox(height: 8),
                Text('会员: ${widget.order.memberName}'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('充值金额: '),
                    Text(
                      '¥${(widget.order.amount ?? 0.0).toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.successPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text('选择支付方式', style: theme.typography.body),
          const SizedBox(height: 8),
          Consumer<DictProvider>(
            builder: (context, dictProvider, child) {
              final payMethods = dictProvider.getDictByCode('MDGL_ZFFS');
              if (payMethods.isEmpty) {
                return const Text('加载支付方式中...');
              }
              final rows = <List<dynamic>>[];
              for (var i = 0; i < payMethods.length; i += 3) {
                rows.add(payMethods.sublist(
                  i,
                  i + 3 > payMethods.length ? payMethods.length : i + 3,
                ));
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: rows.map((row) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: row.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: _buildPayTypeOption(
                            item.value,
                            _getPayIcon(item.label),
                            item.label,
                            theme,
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          if (_error != null) ...[
            const SizedBox(height: 16),
            InfoBar(
              title: const Text('支付失败'),
              content: Text(_error!),
              severity: InfoBarSeverity.error,
            ),
          ],
        ],
      ),
      actions: [
        Button(
          onPressed: _loading ? null : () => Navigator.of(context).pop(false),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _loading ? null : _pay,
          child: _loading
              ? const ProgressRing(strokeWidth: 2)
              : const Text('确认支付'),
        ),
      ],
    );
  }
  Widget _buildPayTypeOption(
      dynamic type, IconData icon, String label, FluentThemeData theme) {
    final isSelected = _payType == type;
    return HoverButton(
      onPressed: () {
        setState(() {
          _payType = type;
        });
      },
      builder: (context, states) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.accentColor
                : states.isHovered
                    ? Colors.grey[30]
                    : Colors.grey[20],
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: isSelected ? theme.accentColor : Colors.grey[100]!,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16),
              const SizedBox(width: 6),
              Text(label),
            ],
          ),
        );
      },
    );
  }
  IconData _getPayIcon(String label) {
    if (label.contains('微信')) return FluentIcons.chat;
    if (label.contains('支付宝')) return FluentIcons.payment_card;
    if (label.contains('现金')) return FluentIcons.money;
    if (label.contains('银行')) return FluentIcons.bank;
    return FluentIcons.payment_card;
  }
  Future<void> _pay() async {
    if (_payType == null) {
      setState(() {
        _error = '请选择支付方式';
      });
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      int payTypeValue;
      if (_payType is String) {
        payTypeValue = int.parse(_payType!);
      } else if (_payType is int) {
        payTypeValue = _payType!;
      } else {
        payTypeValue = int.tryParse(_payType.toString()) ?? 0;
      }
      final api = MemberApi(widget.apiClient);
      final request = PayRechargeOrderRequest(payType: payTypeValue);
      final result = await api.payRechargeOrder(widget.order.orderNo!, request);
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
}
