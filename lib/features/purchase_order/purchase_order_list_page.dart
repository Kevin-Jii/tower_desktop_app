import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'purchase_order_provider.dart';
import 'models.dart';
import 'purchase_order_detail_page.dart';
import 'purchase_order_create_page.dart';

class PurchaseOrderListPage extends StatefulWidget {
  const PurchaseOrderListPage({super.key});

  @override
  State<PurchaseOrderListPage> createState() => _PurchaseOrderListPageState();
}

class _PurchaseOrderListPageState extends State<PurchaseOrderListPage> {
  int? _selectedStatus;
  DateTime? _startDate;
  DateTime? _endDate;

  final _statusOptions = [
    const ComboBoxItem<int?>(value: null, child: Text('全部状态')),
    const ComboBoxItem<int>(value: PurchaseOrderStatus.pending, child: Text('待确认')),
    const ComboBoxItem<int>(value: PurchaseOrderStatus.confirmed, child: Text('已确认')),
    const ComboBoxItem<int>(value: PurchaseOrderStatus.completed, child: Text('已完成')),
    const ComboBoxItem<int>(value: PurchaseOrderStatus.cancelled, child: Text('已取消')),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PurchaseOrderProvider>().loadOrders();
    });
  }

  Color _getStatusColor(int status) {
    switch (status) {
      case PurchaseOrderStatus.pending: return Colors.orange;
      case PurchaseOrderStatus.confirmed: return Colors.blue;
      case PurchaseOrderStatus.completed: return Colors.green;
      case PurchaseOrderStatus.cancelled: return Colors.red;
      default: return Colors.grey;
    }
  }

  void _handleSearch() {
    context.read<PurchaseOrderProvider>().loadOrders(
      page: 1,
      status: _selectedStatus,
      startDate: _startDate?.toIso8601String().split('T').first,
      endDate: _endDate?.toIso8601String().split('T').first,
    );
  }

  void _handleReset() {
    setState(() {
      _selectedStatus = null;
      _startDate = null;
      _endDate = null;
    });
    context.read<PurchaseOrderProvider>().clearFilters();
  }

  void _handleViewDetail(PurchaseOrder order) {
    Navigator.push(
      context,
      FluentPageRoute(builder: (context) => PurchaseOrderDetailPage(orderId: order.id)),
    );
  }

  void _handleCreate() {
    Navigator.push(
      context,
      FluentPageRoute(builder: (context) => const PurchaseOrderCreatePage()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Column(
        children: [
          _buildToolbar(),
          Expanded(child: _buildContent()),
          _buildPagination(),
        ],
      ),
    );
  }

  Widget _buildToolbar() {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.accentColor.withOpacity(0.05),
            isDark ? const Color(0xFF2D2D2D) : theme.micaBackgroundColor,
          ],
        ),
        border: Border(bottom: BorderSide(color: theme.resources.dividerStrokeColorDefault, width: 1)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.blue, Colors.blue.lighter]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(FluentIcons.shopping_cart, size: 24, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('采购订单', style: theme.typography.title?.copyWith(fontWeight: FontWeight.bold)),
                  Text('查看和管理采购订单', style: theme.typography.caption?.copyWith(color: isDark ? Colors.grey[100] : Colors.grey[130])),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                width: 140,
                child: ComboBox<int?>(
                  value: _selectedStatus,
                  items: _statusOptions,
                  onChanged: (v) => setState(() => _selectedStatus = v),
                  placeholder: const Text('状态'),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 140,
                child: DatePicker(
                  selected: _startDate,
                  onChanged: (d) => setState(() => _startDate = d),
                  header: '开始日期',
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 140,
                child: DatePicker(
                  selected: _endDate,
                  onChanged: (d) => setState(() => _endDate = d),
                  header: '结束日期',
                ),
              ),
              const SizedBox(width: 12),
              FilledButton(onPressed: _handleSearch, child: const Text('查询')),
              const SizedBox(width: 8),
              Button(onPressed: _handleReset, child: const Text('重置')),
              const Spacer(),
              FilledButton(
                onPressed: _handleCreate,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(FluentIcons.add, size: 14),
                    SizedBox(width: 6),
                    Text('新建采购单'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Consumer<PurchaseOrderProvider>(
      builder: (context, provider, _) {
        if (provider.loading) {
          return const Center(child: ProgressRing());
        }
        if (provider.error != null) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(FluentIcons.error_badge, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(provider.error!, style: TextStyle(color: Colors.red)),
                const SizedBox(height: 16),
                FilledButton(onPressed: () => provider.loadOrders(), child: const Text('重试')),
              ],
            ),
          );
        }
        if (provider.orders.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(FluentIcons.shopping_cart, size: 64, color: Colors.grey[100]),
                const SizedBox(height: 16),
                Text('暂无采购订单', style: TextStyle(color: Colors.grey[100], fontSize: 16)),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(24),
          itemCount: provider.orders.length,
          itemBuilder: (context, index) => _buildOrderCard(provider.orders[index], isDark),
        );
      },
    );
  }

  Widget _buildOrderCard(PurchaseOrder order, bool isDark) {
    final theme = FluentTheme.of(context);
    final statusColor = _getStatusColor(order.status);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      backgroundColor: isDark ? const Color(0xFF2D2D2D) : Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: HoverButton(
        onPressed: () => _handleViewDetail(order),
        builder: (context, states) {
          return Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.blue, Colors.blue.lighter]),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(child: Icon(FluentIcons.shopping_cart, size: 24, color: Colors.white)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(order.orderNo, style: theme.typography.bodyStrong),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(PurchaseOrderStatus.getLabel(order.status), style: TextStyle(fontSize: 11, color: statusColor)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (order.store != null) Text('门店: ${order.store!.name}', style: TextStyle(fontSize: 12, color: Colors.grey[130])),
                        const SizedBox(width: 16),
                        Text('日期: ${order.orderDate ?? '-'}', style: TextStyle(fontSize: 12, color: Colors.grey[130])),
                      ],
                    ),
                  ],
                ),
              ),
              Text('¥${order.totalAmount.toStringAsFixed(2)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange)),
              const SizedBox(width: 16),
              const Icon(FluentIcons.chevron_right, size: 16),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPagination() {
    return Consumer<PurchaseOrderProvider>(
      builder: (context, provider, _) {
        if (provider.orders.isEmpty) return const SizedBox.shrink();
        final totalPages = (provider.total / provider.pageSize).ceil();
        if (totalPages <= 1) return const SizedBox.shrink();

        final theme = FluentTheme.of(context);
        final isDark = theme.brightness == Brightness.dark;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
            border: Border(top: BorderSide(color: isDark ? Colors.grey[100].withOpacity(0.2) : Colors.grey[40]!, width: 1)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('共 ${provider.total} 条记录'),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(FluentIcons.chevron_left, size: 16),
                    onPressed: provider.page > 1 ? () => provider.loadOrders(page: provider.page - 1) : null,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.blue, Colors.blue.lighter]),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text('${provider.page} / $totalPages', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                  IconButton(
                    icon: const Icon(FluentIcons.chevron_right, size: 16),
                    onPressed: provider.page < totalPages ? () => provider.loadOrders(page: provider.page + 1) : null,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
