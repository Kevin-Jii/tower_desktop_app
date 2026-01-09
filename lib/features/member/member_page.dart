import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../../core/network/api_client.dart';
import 'member_provider.dart';
import 'models.dart';
import 'member_form_dialog.dart';
import 'recharge_order_dialog.dart';
class MemberPage extends StatefulWidget {
  const MemberPage({super.key});
  @override
  State<MemberPage> createState() => _MemberPageState();
}
class _MemberPageState extends State<MemberPage> {
  int _selectedIndex = 0;
  final _searchController = TextEditingController();
  final ApiClient _apiClient = ApiClient();
  @override
  void initState() {
    super.initState();
    _loadData();
  }
  void _loadData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<MemberProvider>();
      if (_selectedIndex == 0) {
        provider.loadMembers(refresh: true);
      } else if (_selectedIndex == 1) {
        provider.loadWalletLogs(refresh: true);
      } else {
        provider.loadRechargeOrders(refresh: true);
      }
    });
  }
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final tabs = ['会员列表', '流水记录', '充值订单'];
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      header: PageHeader(
        title: const Text('会员管理'),
        commandBar: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(FluentIcons.refresh),
              onPressed: () {
                final provider = context.read<MemberProvider>();
                if (_selectedIndex == 0) {
                  provider.loadMembers(refresh: true);
                } else if (_selectedIndex == 1) {
                  provider.loadWalletLogs(refresh: true);
                } else {
                  provider.loadRechargeOrders(refresh: true);
                }
              },
            ),
          ],
        ),
      ),
      content: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: theme.micaBackgroundColor,
            child: Row(
              children: [
                ...List.generate(tabs.length, (index) {
                  final isSelected = _selectedIndex == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: HoverButton(
                      onPressed: () {
                        if (_selectedIndex != index) {
                          setState(() {
                            _selectedIndex = index;
                          });
                          _loadData();
                        }
                      },
                      builder: (context, states) {
                        final isHovered = states.isHovered;
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? theme.accentColor
                                : isHovered
                                    ? Colors.grey[30]
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: isSelected
                                  ? theme.accentColor
                                  : Colors.grey[100]!,
                            ),
                          ),
                          child: Text(
                            tabs[index],
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : theme.resources.textFillColorPrimary,
                              fontWeight:
                                  isSelected ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
                if (_selectedIndex == 0) ...[
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 200,
                    child: TextBox(
                      controller: _searchController,
                      placeholder: '搜索姓名/手机号',
                      prefix: const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(FluentIcons.search, size: 14),
                      ),
                      onSubmitted: (value) {
                        context
                            .read<MemberProvider>()
                            .searchMembers(value);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: () {
                      context
                          .read<MemberProvider>()
                          .searchMembers(_searchController.text);
                    },
                    child: const Text('搜索'),
                  ),
                ],
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: _selectedIndex == 0
                ? _buildMemberList()
                : _selectedIndex == 1
                    ? _buildWalletLogs()
                    : _buildRechargeOrders(),
          ),
        ],
      ),
    );
  }
  Widget _buildMemberList() {
    return Consumer<MemberProvider>(
      builder: (context, provider, child) {
        if (provider.loading && provider.members.isEmpty) {
          return const Center(child: ProgressRing());
        }
        if (provider.members.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FluentIcons.contact, size: 48, color: Colors.grey[100]),
                const SizedBox(height: 16),
                const Text('暂无会员数据'),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => _showAddMemberDialog(),
                  child: const Text('添加会员'),
                ),
              ],
            ),
          );
        }
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Table(
                  columnWidths: const {
                    0: FixedColumnWidth(50),
                    1: FixedColumnWidth(100),
                    2: FixedColumnWidth(120),
                    3: FixedColumnWidth(80),
                    4: FixedColumnWidth(100),
                    5: FixedColumnWidth(100),
                    6: FixedColumnWidth(100),
                    7: FixedColumnWidth(80),
                    8: FlexColumnWidth(),
                  },
                  border: TableBorder.all(color: Colors.grey[30]),
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: Colors.grey[20]),
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('ID', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('姓名', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('手机号码', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('等级', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('余额', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('累计充值', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('累计消费', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('状态', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('操作', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    ...provider.members.map((member) => TableRow(
                          decoration: BoxDecoration(
                            color: member.status == 0 ? Colors.grey[20] : null,
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${member.id}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(member.name ?? '-'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(member.phone ?? '-'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(member.levelName ?? '普通会员'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '¥${(member.balance ?? 0.0).toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.successPrimaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Text('¥${(member.totalRecharge ?? 0.0).toStringAsFixed(2)}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Text('¥${(member.totalConsume ?? 0.0).toStringAsFixed(2)}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: member.status == 1
                                      ? Colors.successPrimaryColor
                                      : Colors.errorPrimaryColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  member.status == 1 ? '正常' : '禁用',
                                  style: const TextStyle(
                                      fontSize: 11, color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _MemberActionButtons(
                                member: member,
                                onRecharge: () => _showRechargeDialog(member),
                                onAdjustBalance: () => _showAdjustBalanceDialog(member),
                                onEdit: () => _showEditMemberDialog(member),
                                onDelete: () => _deleteMember(member),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  Widget _buildWalletLogs() {
    return Consumer<MemberProvider>(
      builder: (context, provider, child) {
        if (provider.walletLogsLoading && provider.walletLogs.isEmpty) {
          return const Center(child: ProgressRing());
        }
        if (provider.walletLogs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FluentIcons.history, size: 48, color: Colors.grey[100]),
                const SizedBox(height: 16),
                const Text('暂无流水记录'),
              ],
            ),
          );
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Table(
            columnWidths: const {
              0: FixedColumnWidth(60),
              1: FixedColumnWidth(100),
              2: FixedColumnWidth(120),
              3: FixedColumnWidth(100),
              4: FixedColumnWidth(100),
              5: FixedColumnWidth(100),
              6: FixedColumnWidth(150),
              7: FlexColumnWidth(),
            },
            border: TableBorder.all(color: Colors.grey[30]),
            children: [
              TableRow(
                decoration: BoxDecoration(color: Colors.grey[20]),
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('ID', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('会员', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('类型', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('金额', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('变更前', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('变更后', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('时间', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('备注', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              ...provider.walletLogs.map((log) => TableRow(
                    decoration: BoxDecoration(
                      color: log.type == 1 || log.type == 4
                          ? Colors.successPrimaryColor.withValues(alpha: 0.05)
                          : Colors.warningPrimaryColor.withValues(alpha: 0.05),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${log.id}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(log.memberName ?? ''),
                            Text(
                              log.memberPhone ?? '',
                              style: TextStyle(
                                  fontSize: 11, color: Colors.grey[80]),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getWalletLogTypeColor(log.type),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            log.typeName ?? '',
                            style: const TextStyle(fontSize: 11, color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${log.type == 1 || log.type == 4 ? '+' : '-'}${(log.amount ?? 0.0).toStringAsFixed(2)}',
                          style: TextStyle(
                            color: log.type == 1 || log.type == 4
                                ? Colors.successPrimaryColor
                                : Colors.warningPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text((log.balanceBefore ?? 0.0).toStringAsFixed(2)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text((log.balanceAfter ?? 0.0).toStringAsFixed(2)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          log.createdAt?.substring(0, 16) ?? '',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          log.remark ?? '-',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ],
                 )),
            ],
          ),
        );
      },
    );
  }
  Widget _buildRechargeOrders() {
    return Consumer<MemberProvider>(
      builder: (context, provider, child) {
        if (provider.rechargeOrdersLoading && provider.rechargeOrders.isEmpty) {
          return const Center(child: ProgressRing());
        }
        if (provider.rechargeOrders.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FluentIcons.money, size: 48, color: Colors.grey[100]),
                const SizedBox(height: 16),
                const Text('暂无充值订单'),
              ],
            ),
          );
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Table(
            columnWidths: const {
              0: FixedColumnWidth(60),
              1: FixedColumnWidth(180),
              2: FixedColumnWidth(100),
              3: FixedColumnWidth(120),
              4: FixedColumnWidth(100),
              5: FixedColumnWidth(100),
              6: FixedColumnWidth(100),
              7: FixedColumnWidth(80),
              8: FixedColumnWidth(150),
              9: FlexColumnWidth(),
            },
            border: TableBorder.all(color: Colors.grey[30]),
            children: [
              TableRow(
                decoration: BoxDecoration(color: Colors.grey[20]),
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('ID', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('订单号', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('会员', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('充值金额', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('实付金额', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('赠送金额', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('支付方式', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('状态', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('创建时间', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('操作', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              ...provider.rechargeOrders.map((order) => TableRow(
                    decoration: BoxDecoration(
                      color: order.status == 1
                          ? Colors.successPrimaryColor.withValues(alpha: 0.05)
                          : order.status == 0
                              ? Colors.warningPrimaryColor.withValues(alpha: 0.05)
                              : null,
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${order.id}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          order.orderNo ?? '',
                          style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(order.memberName ?? ''),
                            Text(
                              order.memberPhone ?? '',
                              style:
                                  TextStyle(fontSize: 11, color: Colors.grey[80]),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '¥${(order.amount ?? 0.0).toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.successPrimaryColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('¥${(order.payAmount ?? 0.0).toStringAsFixed(2)}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          (order.giftAmount ?? 0) > 0
                              ? '¥${(order.giftAmount ?? 0.0).toStringAsFixed(2)}'
                              : '-',
                          style: TextStyle(
                              color: (order.giftAmount ?? 0) > 0
                                  ? Colors.successPrimaryColor
                                  : null),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(order.payTypeName ?? '-'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getRechargeStatusColor(order.status ?? 0),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            order.statusName ?? '',
                            style: const TextStyle(fontSize: 11, color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          order.createdAt?.substring(0, 16) ?? '',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _RechargeOrderActionButtons(
                          order: order,
                          onPay: () => _showPayRechargeDialog(order),
                          onCancel: () => _cancelRechargeOrder(order),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        );
      },
    );
  }
  Color _getWalletLogTypeColor(int? type) {
    switch (type) {
      case 1:
        return Colors.successPrimaryColor;
      case 2:
        return Colors.warningPrimaryColor;
      case 3:
        return Colors.errorPrimaryColor;
      case 4:
        return Colors.blue;
      default:
        return Colors.grey[100]!;
    }
  }
  Color _getRechargeStatusColor(int status) {
    switch (status) {
      case 0:
        return Colors.warningPrimaryColor;
      case 1:
        return Colors.successPrimaryColor;
      case 2:
        return Colors.errorPrimaryColor;
      default:
        return Colors.grey[100]!;
    }
  }
  void _showAddMemberDialog() {
    showDialog(
      context: context,
      builder: (ctx) => MemberFormDialog(apiClient: _apiClient),
    ).then((success) {
      if (success == true) {
        context.read<MemberProvider>().loadMembers(refresh: true);
      }
    });
  }
  void _showEditMemberDialog(Member member) {
    showDialog(
      context: context,
      builder: (ctx) => MemberFormDialog(
        member: member,
        apiClient: _apiClient,
      ),
    ).then((success) {
      if (success == true) {
        context.read<MemberProvider>().loadMembers(refresh: true);
      }
    });
  }
  void _deleteMember(Member member) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => ContentDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除会员 "${member.name}" 吗？此操作不可撤销。'),
        actions: [
          Button(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.all(Colors.errorPrimaryColor),
            ),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (result == true && mounted) {
      if (!mounted) return;
      await context.read<MemberProvider>().deleteMember(member.id);
    }
  }
  void _showAdjustBalanceDialog(Member member) {
    showDialog(
      context: context,
      builder: (ctx) => AdjustBalanceDialog(
        member: member,
        apiClient: _apiClient,
      ),
    ).then((success) {
      if (success == true) {
        context.read<MemberProvider>().loadMembers(refresh: true);
      }
    });
  }
  void _showRechargeDialog(Member member) {
    showDialog<RechargeOrder>(
      context: context,
      builder: (ctx) => CreateRechargeDialog(
        member: member,
        apiClient: _apiClient,
      ),
    ).then((order) {
      if (order != null) {
        showDialog<bool>(
          context: context,
          builder: (_) => PayRechargeDialog(
            order: order,
            apiClient: _apiClient,
          ),
        ).then((success) {
          if (success == true) {
            context.read<MemberProvider>().loadMembers(refresh: true);
            context.read<MemberProvider>().loadRechargeOrders(refresh: true);
          }
        });
      }
    });
  }
  void _showPayRechargeDialog(RechargeOrder order) {
    showDialog<bool>(
      context: context,
      builder: (ctx) => PayRechargeDialog(
        order: order,
        apiClient: _apiClient,
      ),
    ).then((success) {
      if (success == true) {
        context.read<MemberProvider>().loadMembers(refresh: true);
        context.read<MemberProvider>().loadRechargeOrders(refresh: true);
      }
    });
  }
  void _cancelRechargeOrder(RechargeOrder order) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => ContentDialog(
        title: const Text('确认取消'),
        content: Text('确定要取消充值订单 "${order.orderNo}" 吗？'),
        actions: [
          Button(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('否'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.all(Colors.errorPrimaryColor),
            ),
            child: const Text('是'),
          ),
        ],
      ),
    );
    if (result == true && mounted) {
      await context
          .read<MemberProvider>()
          .cancelRechargeOrder(order.orderNo!);
    }
  }
}
class _MemberActionButtons extends StatelessWidget {
  final Member member;
  final VoidCallback onRecharge;
  final VoidCallback onAdjustBalance;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const _MemberActionButtons({
    required this.member,
    required this.onRecharge,
    required this.onAdjustBalance,
    required this.onEdit,
    required this.onDelete,
  });
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Tooltip(
          message: '充值',
          child: HoverButton(
            onPressed: onRecharge,
            builder: (context, states) {
              return Icon(
                FluentIcons.add,
                size: 14,
                color: states.isHovered
                    ? Colors.successPrimaryColor
                    : Colors.grey[80],
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        Tooltip(
          message: '调整余额',
          child: HoverButton(
            onPressed: onAdjustBalance,
            builder: (context, states) {
              return Icon(
                FluentIcons.edit,
                size: 14,
                color: states.isHovered
                    ? theme.accentColor
                    : Colors.grey[80],
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        Tooltip(
          message: '编辑',
          child: HoverButton(
            onPressed: onEdit,
            builder: (context, states) {
              return Icon(
                FluentIcons.edit,
                size: 14,
                color: states.isHovered
                    ? theme.accentColor
                    : Colors.grey[80],
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        Tooltip(
          message: '删除',
          child: HoverButton(
            onPressed: onDelete,
            builder: (context, states) {
              return Icon(
                FluentIcons.delete,
                size: 14,
                color: states.isHovered
                    ? Colors.errorPrimaryColor
                    : Colors.grey[80],
              );
            },
          ),
        ),
      ],
    );
  }
}
class _RechargeOrderActionButtons extends StatelessWidget {
  final RechargeOrder order;
  final VoidCallback onPay;
  final VoidCallback onCancel;
  const _RechargeOrderActionButtons({
    required this.order,
    required this.onPay,
    required this.onCancel,
  });
  @override
  Widget build(BuildContext context) {
    if (order.status != 0) return const SizedBox.shrink();
    return Row(
      children: [
        Tooltip(
          message: '支付',
          child: HoverButton(
            onPressed: onPay,
            builder: (context, states) {
              return Icon(
                FluentIcons.check_mark,
                size: 14,
                color: states.isHovered
                    ? Colors.successPrimaryColor
                    : Colors.grey[80],
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        Tooltip(
          message: '取消',
          child: HoverButton(
            onPressed: onCancel,
            builder: (context, states) {
              return Icon(
                FluentIcons.cancel,
                size: 14,
                color: states.isHovered
                    ? Colors.errorPrimaryColor
                    : Colors.grey[80],
              );
            },
          ),
        ),
      ],
    );
  }
}
