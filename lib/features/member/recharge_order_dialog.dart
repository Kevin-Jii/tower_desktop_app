import 'package:fluent_ui/fluent_ui.dart';
import '../../core/network/api_client.dart';
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
  int _payType = 1; 
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
        _error = '请输入有效的充值金额';
      });
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final api = MemberApi(widget.apiClient);
      final request = CreateRechargeOrderRequest(
        memberId: widget.member.id,
        amount: amount,
        payType: _payType,
        remark: _remarkController.text.trim().isEmpty ? null : _remarkController.text.trim(),
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
                  Text('当前余额: ¥${(widget.member.balance ?? 0.0).toStringAsFixed(2)}'),
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
            Row(
              children: [
                _buildPayTypeOption(1, FluentIcons.chat, '微信', theme),
                const SizedBox(width: 12),
                _buildPayTypeOption(2, FluentIcons.payment_card, '支付宝', theme),
                const SizedBox(width: 12),
                _buildPayTypeOption(3, FluentIcons.money, '现金', theme),
                const SizedBox(width: 12),
                _buildPayTypeOption(4, FluentIcons.bank, '银行卡', theme),
              ],
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
  Widget _buildPayTypeOption(int type, IconData icon, String label, FluentThemeData theme) {
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
              color: isSelected
                  ? theme.accentColor
                  : Colors.grey[100]!,
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
  int _payType = 1;
  bool _loading = false;
  String? _error;
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
          Row(
            children: [
              _buildPayTypeOption(1, FluentIcons.chat, '微信', theme),
              const SizedBox(width: 12),
              _buildPayTypeOption(2, FluentIcons.payment_card, '支付宝', theme),
              const SizedBox(width: 12),
              _buildPayTypeOption(3, FluentIcons.money, '现金', theme),
              const SizedBox(width: 12),
              _buildPayTypeOption(4, FluentIcons.bank, '银行卡', theme),
            ],
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
  Widget _buildPayTypeOption(int type, IconData icon, String label, FluentThemeData theme) {
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
              color: isSelected
                  ? theme.accentColor
                  : Colors.grey[100]!,
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
  Future<void> _pay() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final api = MemberApi(widget.apiClient);
      final request = PayRechargeOrderRequest(payType: _payType);
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
