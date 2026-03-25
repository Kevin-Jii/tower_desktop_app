import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show TabController;
import 'package:provider/provider.dart';
import '../../core/di/service_locator.dart';
import '../../core/widgets/fluent_info_bar.dart';
import '../dict/dict_provider.dart';
import '../dict/models.dart';
import 'member_api.dart';
import 'member_provider.dart';
import 'models.dart';
class MemberDetailPage extends StatefulWidget {
  final Member member;
  const MemberDetailPage({super.key, required this.member});
  @override
  State<MemberDetailPage> createState() => _MemberDetailPageState();
}
class _MemberDetailPageState extends State<MemberDetailPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late MemberDetailProvider _detailProvider;
  List<DictData> _payTypes = [];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _detailProvider = MemberDetailProvider(sl.get<MemberApi>());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _detailProvider.loadMember(widget.member.id);
      _detailProvider.loadWalletLogs(widget.member.id);
      _detailProvider.loadRechargeOrders(widget.member.id);
      _loadPayTypes();
    });
  }
  Future<void> _loadPayTypes() async {
    final dictProvider = context.read<DictProvider>();
    await dictProvider.loadAllDicts();
    if (mounted) {
      setState(() {
        _payTypes = dictProvider.getDictByCode('MDGL_ZFFS');
      });
    }
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  void _handleRecharge() async {
    if (_detailProvider.member == null) return;
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => _RechargeDialog(member: _detailProvider.member!, payTypes: _payTypes),
    );
    if (result != null && mounted) {
      final success = await _detailProvider.recharge(
        memberId: _detailProvider.member!.id,
        payAmount: result['payAmount'],
        giftAmount: result['giftAmount'],
        payType: int.tryParse(result['payType'] ?? '0') ?? 0,
        remark: result['remark'],
      );
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '充值成功');
        if (mounted) context.read<MemberProvider>().loadMembers();
      } else if (mounted) {
        await FluentInfoBarHelper.showError(context, _detailProvider.error ?? '充值失败');
      }
    }
  }
  void _handleAdjustBalance() async {
    if (_detailProvider.member == null) return;
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => _AdjustBalanceDialog(member: _detailProvider.member!),
    );
    if (result != null && mounted) {
      final success = await _detailProvider.adjustBalance(
        memberId: _detailProvider.member!.id,
        amount: result['amount'],
        type: result['type'],
        remark: result['remark'],
        version: result['version'],
      );
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '余额调整成功');
        if (mounted) context.read<MemberProvider>().loadMembers();
      } else if (mounted) {
        await FluentInfoBarHelper.showError(context, _detailProvider.error ?? '调整失败');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return ChangeNotifierProvider.value(
      value: _detailProvider,
      child: ScaffoldPage(
        header: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              IconButton(icon: const Icon(FluentIcons.back), onPressed: () => Navigator.pop(context)),
              const SizedBox(width: 8),
              Consumer<MemberDetailProvider>(
                builder: (context, provider, _) {
                  final member = provider.member ?? widget.member;
                  return Text('${member.name} - 会员详情', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
                },
              ),
              const Spacer(),
              FilledButton(
                onPressed: _handleRecharge,
                child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(FluentIcons.add, size: 16), SizedBox(width: 6), Text('充值')]),
              ),
              const SizedBox(width: 8),
              Button(
                onPressed: _handleAdjustBalance,
                child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(FluentIcons.edit, size: 16), SizedBox(width: 6), Text('调整余额')]),
              ),
            ],
          ),
        ),
        content: Consumer<MemberDetailProvider>(
          builder: (context, provider, _) {
            if (provider.loading && provider.member == null) {
              return const Center(child: ProgressRing());
            }
            final member = provider.member ?? widget.member;
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [theme.accentColor, theme.accentColor.withValues(alpha: 0.7)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
                        child: Center(
                          child: Text(
                            member.name?.isNotEmpty == true ? member.name![0] : '?',
                            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: theme.accentColor),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(member.name ?? '未知', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(FluentIcons.phone, size: 16, color: Colors.white.withValues(alpha: 0.7)),
                                const SizedBox(width: 8),
                                Text(member.phone ?? '-', style: TextStyle(color: Colors.white.withValues(alpha: 0.7))),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('账户余额', style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 14)),
                          Text('¥${member.balance ?? '0.00'}', style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(FluentIcons.starburst, size: 16, color: Colors.yellow),
                              const SizedBox(width: 4),
                              Text('${member.points ?? 0} 积分', style: TextStyle(color: Colors.white.withValues(alpha: 0.7))),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _tabController.index = 0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _tabController.index == 0 ? theme.accentColor.withValues(alpha: 0.1) : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: _tabController.index == 0 ? Border(bottom: BorderSide(color: theme.accentColor, width: 2)) : null,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(FluentIcons.history, size: 16, color: _tabController.index == 0 ? theme.accentColor : Colors.grey),
                                const SizedBox(width: 6),
                                Text('流水记录', style: TextStyle(color: _tabController.index == 0 ? theme.accentColor : Colors.grey, fontWeight: _tabController.index == 0 ? FontWeight.bold : FontWeight.normal)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _tabController.index = 1),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _tabController.index == 1 ? theme.accentColor.withValues(alpha: 0.1) : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: _tabController.index == 1 ? Border(bottom: BorderSide(color: theme.accentColor, width: 2)) : null,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(FluentIcons.money, size: 16, color: _tabController.index == 1 ? theme.accentColor : Colors.grey),
                                const SizedBox(width: 6),
                                Text('充值记录', style: TextStyle(color: _tabController.index == 1 ? theme.accentColor : Colors.grey, fontWeight: _tabController.index == 1 ? FontWeight.bold : FontWeight.normal)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: IndexedStack(
                    index: _tabController.index,
                    children: [
                      _WalletLogList(memberId: member.id, provider: provider),
                      _RechargeOrderList(memberId: member.id, provider: provider),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
class _WalletLogList extends StatelessWidget {
  final int memberId;
  final MemberDetailProvider provider;
  const _WalletLogList({required this.memberId, required this.provider});
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    if (provider.loading && provider.walletLogs.isEmpty) {
      return const Center(child: ProgressRing());
    }
    if (provider.walletLogs.isEmpty) {
      return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(FluentIcons.history, size: 48, color: theme.typography.caption?.color ?? Colors.grey),
        const SizedBox(height: 16),
        Text('暂无流水记录', style: TextStyle(color: theme.typography.caption?.color ?? Colors.grey)),
      ]));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: provider.walletLogs.length,
      itemBuilder: (context, index) {
        final log = provider.walletLogs[index];
        final changeType = ChangeTypeEnum.fromValue(log.changeType);
        final isAdd = [ChangeTypeEnum.recharge.value, ChangeTypeEnum.adjustAdd.value, ChangeTypeEnum.refund.value].contains(log.changeType);
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(color: (isAdd ? Colors.green : Colors.red).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(22)),
                  child: Icon(isAdd ? FluentIcons.up : FluentIcons.down, color: isAdd ? Colors.green : Colors.red, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(changeType?.label ?? '未知', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                      const SizedBox(height: 2),
                      Text('订单: ${log.relatedOrderNo ?? '-'}', style: TextStyle(color: Colors.grey[120], fontSize: 11)),
                      if (log.remark != null && log.remark!.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(log.remark!, style: TextStyle(color: Colors.grey[100], fontSize: 11)),
                      ],
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${isAdd ? '+' : '-'}¥${log.changeAmount ?? '0'}', style: TextStyle(fontWeight: FontWeight.bold, color: isAdd ? Colors.green : Colors.red, fontSize: 15)),
                    const SizedBox(height: 2),
                    Text('余额: ¥${log.balanceAfter ?? '0'}', style: TextStyle(color: Colors.grey[120], fontSize: 10)),
                    const SizedBox(height: 2),
                    Text(_formatTime(log.createTime), style: TextStyle(color: Colors.grey[130], fontSize: 10)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  String _formatTime(String? time) {
    if (time == null || time.isEmpty) return '-';
    try {
      final dt = DateTime.parse(time);
      return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return time;
    }
  }
}
class _RechargeOrderList extends StatelessWidget {
  final int memberId;
  final MemberDetailProvider provider;
  const _RechargeOrderList({required this.memberId, required this.provider});
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    if (provider.loading && provider.rechargeOrders.isEmpty) {
      return const Center(child: ProgressRing());
    }
    if (provider.rechargeOrders.isEmpty) {
      return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(FluentIcons.money, size: 48, color: theme.typography.caption?.color ?? Colors.grey),
        const SizedBox(height: 16),
        Text('暂无充值记录', style: TextStyle(color: theme.typography.caption?.color ?? Colors.grey)),
      ]));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: provider.rechargeOrders.length,
      itemBuilder: (context, index) {
        final order = provider.rechargeOrders[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(color: _getStatusColor(order.payStatus).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(22)),
                  child: Icon(_getStatusIcon(order.payStatus), color: _getStatusColor(order.payStatus), size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('订单号: ${order.orderNo ?? '-'}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: theme.accentColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
                            child: Text(order.payTypeName ?? '未知', style: TextStyle(color: theme.accentColor, fontSize: 10)),
                          ),
                          const SizedBox(width: 8),
                          Text('¥${order.totalAmount ?? order.payAmount ?? '0'}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        ],
                      ),
                      if (order.payTime != null) ...[
                        const SizedBox(height: 4),
                        Text(_formatTime(order.payTime), style: TextStyle(color: Colors.grey[120], fontSize: 11)),
                      ],
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: _getStatusColor(order.payStatus).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
                  child: Text(order.statusName ?? '未知', style: TextStyle(color: _getStatusColor(order.payStatus), fontWeight: FontWeight.w600, fontSize: 12)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  String _formatTime(String? time) {
    if (time == null || time.isEmpty) return '-';
    try {
      final dt = DateTime.parse(time);
      return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return time;
    }
  }
  Color _getStatusColor(int? status) {
    switch (status) {
      case 0: return Colors.orange;
      case 1: return Colors.green;
      case 2: return Colors.grey;
      case 3: return Colors.red;
      default: return Colors.grey;
    }
  }
  IconData _getStatusIcon(int? status) {
    switch (status) {
      case 0: return FluentIcons.clock;
      case 1: return FluentIcons.check_mark;
      case 2: return FluentIcons.cancel;
      case 3: return FluentIcons.undo;
      default: return FluentIcons.info;
    }
  }
}
class _RechargeDialog extends StatefulWidget {
  final Member member;
  final List<DictData> payTypes;
  const _RechargeDialog({required this.member, required this.payTypes});
  @override
  State<_RechargeDialog> createState() => _RechargeDialogState();
}
class _RechargeDialogState extends State<_RechargeDialog> {
  final _formKey = GlobalKey<FormState>();
  final _payAmountCtrl = TextEditingController();
  final _giftAmountCtrl = TextEditingController();
  final _remarkCtrl = TextEditingController();
  String? _payType;
  @override
  void initState() {
    super.initState();
    if (widget.payTypes.isNotEmpty) {
      _payType = widget.payTypes.first.value;
    }
  }
  @override
  void dispose() {
    _payAmountCtrl.dispose();
    _giftAmountCtrl.dispose();
    _remarkCtrl.dispose();
    super.dispose();
  }
  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_payType == null) return;
    Navigator.pop(context, {
      'payAmount': _payAmountCtrl.text.trim(),
      'giftAmount': _giftAmountCtrl.text.trim().isEmpty ? '0' : _giftAmountCtrl.text.trim(),
      'payType': _payType,
      'remark': _remarkCtrl.text.trim().isEmpty ? null : _remarkCtrl.text.trim(),
    });
  }
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return ContentDialog(
      title: Text('充值 - ${widget.member.name}'),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: theme.cardColor, borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('当前余额'),
                    Text('¥${widget.member.balance ?? '0'}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: theme.accentColor)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              InfoLabel(
                label: '实付金额',
                child: TextFormBox(
                  controller: _payAmountCtrl,
                  placeholder: '请输入实付金额',
                  validator: (v) {
                    if (v == null || v.isEmpty) return '请输入金额';
                    final amount = double.tryParse(v);
                    if (amount == null || amount <= 0) return '请输入有效金额';
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              InfoLabel(label: '赠送金额', child: TextFormBox(controller: _giftAmountCtrl, placeholder: '请输入赠送金额（可选）')),
              const SizedBox(height: 16),
              const Text('支付方式', style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              if (widget.payTypes.isEmpty)
                const Text('加载中...', style: TextStyle(color: Colors.grey))
              else
                Wrap(
                  spacing: 8,
                  children: widget.payTypes.map((type) => RadioButton(
                    checked: _payType == type.value,
                    onChanged: (_) => setState(() => _payType = type.value),
                    content: Text(type.label),
                  )).toList(),
                ),
            ],
          ),
        ),
      ),
      actions: [Button(onPressed: () => Navigator.pop(context), child: const Text('取消')), FilledButton(onPressed: _submit, child: const Text('确认充值'))],
    );
  }
}
class _AdjustBalanceDialog extends StatefulWidget {
  final Member member;
  const _AdjustBalanceDialog({required this.member});
  @override
  State<_AdjustBalanceDialog> createState() => _AdjustBalanceDialogState();
}
class _AdjustBalanceDialogState extends State<_AdjustBalanceDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountCtrl = TextEditingController();
  final _remarkCtrl = TextEditingController();
  int _type = ChangeTypeEnum.adjustAdd.value;
  @override
  void dispose() {
    _amountCtrl.dispose();
    _remarkCtrl.dispose();
    super.dispose();
  }
  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(context, {
      'amount': _amountCtrl.text.trim(),
      'type': _type,
      'remark': _remarkCtrl.text.trim().isEmpty ? null : _remarkCtrl.text.trim(),
      'version': widget.member.version,
    });
  }
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final isAdd = _type == ChangeTypeEnum.adjustAdd.value;
    return ContentDialog(
      title: Row(children: [
        Icon(isAdd ? FluentIcons.add : FluentIcons.remove, size: 20, color: isAdd ? Colors.green : Colors.red),
        const SizedBox(width: 8),
        Text('调整余额 - ${widget.member.name}'),
      ]),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: theme.cardColor, borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('当前余额'),
                    Text('¥${widget.member.balance ?? '0'}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: theme.accentColor)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(children: [
                RadioButton(checked: _type == ChangeTypeEnum.adjustAdd.value, onChanged: (_) => setState(() => _type = ChangeTypeEnum.adjustAdd.value), content: const Text('调增')),
                const SizedBox(width: 24),
                RadioButton(checked: _type == ChangeTypeEnum.adjustLess.value, onChanged: (_) => setState(() => _type = ChangeTypeEnum.adjustLess.value), content: const Text('调减')),
              ]),
              const SizedBox(height: 16),
              InfoLabel(
                label: '金额',
                child: TextFormBox(
                  controller: _amountCtrl,
                  placeholder: '请输入金额',
                  validator: (v) {
                    if (v == null || v.isEmpty) return '请输入金额';
                    final amount = double.tryParse(v);
                    if (amount == null || amount <= 0) return '请输入有效金额';
                    if (_type == ChangeTypeEnum.adjustLess.value) {
                      final current = double.tryParse(widget.member.balance ?? '0') ?? 0;
                      if (amount > current) return '调减金额不能大于当前余额';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              InfoLabel(label: '备注', child: TextFormBox(controller: _remarkCtrl, placeholder: '请输入调整原因', style: const TextStyle(fontSize: 14), validator: (v) => v == null || v.trim().isEmpty ? '请输入调整原因' : null)),
            ],
          ),
        ),
      ),
      actions: [Button(onPressed: () => Navigator.pop(context), child: const Text('取消')), FilledButton(onPressed: _submit, child: Text(isAdd ? '确认调增' : '确认调减'))],
    );
  }
}