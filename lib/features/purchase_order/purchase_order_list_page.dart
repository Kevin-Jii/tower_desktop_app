import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'purchase_order_provider.dart';
import 'models.dart';
import 'purchase_order_detail_page.dart';
import 'purchase_order_create_page.dart';
import '../dict/dict_provider.dart';
import '../dict/models.dart';
class PurchaseOrderListPage extends StatefulWidget {
  const PurchaseOrderListPage({super.key});
  @override
  State<PurchaseOrderListPage> createState() => _PurchaseOrderListPageState();
}
class _PurchaseOrderListPageState extends State<PurchaseOrderListPage> {
  String? _selectedStatus; 
  DateTime? _selectedDate; 
  List<DictData> _statusOptions = [];
  bool _dictLoading = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDictAndOrders();
    });
  }
  Future<void> _loadDictAndOrders() async {
    final dictProvider = context.read<DictProvider>();
    await dictProvider.loadAllDicts();
    if (mounted) {
      final options = dictProvider.getDictByCode('CGDDZT');
      setState(() {
        _statusOptions = options;
        _dictLoading = false;
      });
    }
    if (mounted) {
      context.read<PurchaseOrderProvider>().loadOrders();
    }
  }
  Color _getStatusColor(int status) {
    final dictItem = _statusOptions.where((d) => d.value == status.toString()).firstOrNull;
    if (dictItem != null && dictItem.listClass != null) {
      switch (dictItem.listClass) {
        case 'warning': return Colors.orange;
        case 'info': return Colors.blue;
        case 'success': return Colors.green;
        case 'danger': return Colors.red;
      }
    }
    switch (status) {
      case 1: return Colors.orange;  
      case 2: return Colors.blue;    
      case 3: return Colors.green;   
      case 4: return Colors.red;     
      default: return Colors.grey;
    }
  }
  String _getStatusLabel(int status) {
    final dictItem = _statusOptions.where((d) => d.value == status.toString()).firstOrNull;
    return dictItem?.label ?? '未知';
  }
  void _handleSearch() {
    final statusInt = _selectedStatus != null ? int.tryParse(_selectedStatus!) : null;
    final dateStr = _selectedDate?.toIso8601String().split('T').first;
    context.read<PurchaseOrderProvider>().loadOrders(
      page: 1,
      status: statusInt,
      date: dateStr,
    );
  }
  void _handleReset() {
    setState(() {
      _selectedStatus = null;
      _selectedDate = null;
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
  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '-';
    try {
      final date = DateTime.parse(dateStr);
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    } on FormatException {
      if (dateStr.contains('T')) {
        return dateStr.split('T').first;
      }
      return dateStr;
    } on Object {
      if (dateStr.contains('T')) {
        return dateStr.split('T').first;
      }
      return dateStr;
    }
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
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
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
                  boxShadow: [
                    BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 2)),
                  ],
                ),
                child: const Icon(FluentIcons.shopping_cart, size: 24, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('采购订单', style: theme.typography.title?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text('查看和管理采购订单', style: theme.typography.caption?.copyWith(color: isDark ? Colors.grey[100] : Colors.grey[130])),
                ],
              ),
              const Spacer(),
              Consumer<PurchaseOrderProvider>(
                builder: (context, provider, _) {
                  if (provider.orders.isEmpty) return const SizedBox.shrink();
                  return Row(
                    children: [
                      _buildStatCard('总订单', '${provider.total}', FluentIcons.document_set, Colors.blue, isDark),
                      const SizedBox(width: 12),
                    ],
                  );
                },
              ),
              FilledButton(
                onPressed: _handleCreate,
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(FluentIcons.add, size: 16),
                    SizedBox(width: 8),
                    Text('新建采购单', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              SizedBox(
                width: 160,
                child: _dictLoading
                    ? const Center(child: ProgressRing())
                    : ComboBox<String?>(
                        value: _selectedStatus,
                        items: [
                          const ComboBoxItem<String?>(value: null, child: Text('全部状态')),
                          ..._statusOptions.where((d) => d.value != '0').map((d) => ComboBoxItem<String>(
                            value: d.value,
                            child: Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  margin: const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    color: _getColorByListClass(d.listClass),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Text(d.label),
                              ],
                            ),
                          )),
                        ],
                        onChanged: (v) {
                          setState(() => _selectedStatus = v);
                          _handleSearch();
                        },
                        placeholder: const Text('订单状态'),
                        isExpanded: true,
                      ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 160,
                child: DatePicker(
                  selected: _selectedDate,
                  onChanged: (d) => setState(() => _selectedDate = d),
                  header: '采购日期',
                ),
              ),
              const SizedBox(width: 16),
              FilledButton(
                onPressed: _handleSearch,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(FluentIcons.search, size: 14), SizedBox(width: 6), Text('查询')],
                ),
              ),
              const SizedBox(width: 8),
              Button(
                onPressed: _handleReset,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(FluentIcons.refresh, size: 14), SizedBox(width: 6), Text('重置')],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Color _getColorByListClass(String? listClass) {
    switch (listClass) {
      case 'warning': return Colors.orange;
      case 'info': return Colors.blue;
      case 'success': return Colors.green;
      case 'danger': return Colors.red;
      default: return Colors.grey;
    }
  }
  Widget _buildStatCard(String label, String value, IconData icon, Color color, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[120])),
              Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
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
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ProgressRing(),
                const SizedBox(height: 16),
                Text('加载中...', style: TextStyle(color: Colors.grey[100])),
              ],
            ),
          );
        }
        if (provider.error != null) {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(32),
              margin: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.red.withOpacity(0.2)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(FluentIcons.error_badge, size: 48, color: Colors.red),
                  ),
                  const SizedBox(height: 20),
                  Text('加载失败', style: theme.typography.subtitle?.copyWith(color: Colors.red.dark, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(provider.error!, style: TextStyle(color: Colors.red.darker), textAlign: TextAlign.center),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () => provider.loadOrders(),
                    style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.red)),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [Icon(FluentIcons.refresh, size: 14), SizedBox(width: 6), Text('重试')],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (provider.orders.isEmpty) {
          return _buildEmptyState(theme, isDark);
        }
        return Container(
          color: isDark ? const Color(0xFF1F1F1F) : const Color(0xFFF5F7FA),
          child: ListView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: provider.orders.length,
            itemBuilder: (context, index) => _buildOrderCard(provider.orders[index], isDark),
          ),
        );
      },
    );
  }
  Widget _buildEmptyState(FluentThemeData theme, bool isDark) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(48),
        margin: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.withOpacity(0.05), Colors.purple.withOpacity(0.05)],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue.withOpacity(0.1), width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.blue.withOpacity(0.1), Colors.purple.withOpacity(0.1)]),
                shape: BoxShape.circle,
              ),
              child: Icon(FluentIcons.shopping_cart, size: 72, color: Colors.blue),
            ),
            const SizedBox(height: 24),
            Text('暂无采购订单', style: theme.typography.title?.copyWith(color: Colors.grey[160], fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text('点击右上角"新建采购单"按钮创建第一笔采购', style: theme.typography.body?.copyWith(color: Colors.grey[130])),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _handleCreate,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [Icon(FluentIcons.add, size: 16), SizedBox(width: 8), Text('立即新建')],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildOrderCard(PurchaseOrder order, bool isDark) {
    final theme = FluentTheme.of(context);
    final statusColor = _getStatusColor(order.status);
    final storeName = order.store?.name ?? '未知门店';
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: HoverButton(
        onPressed: () => _handleViewDetail(order),
        builder: (context, states) {
          final isHovered = states.isHovered;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            transform: Matrix4.identity()..translate(0.0, isHovered ? -2.0 : 0.0),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isHovered ? Colors.blue.withOpacity(0.5) : (isDark ? Colors.grey[100].withOpacity(0.1) : Colors.grey[30]!),
                width: isHovered ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: isHovered ? Colors.blue.withOpacity(0.12) : Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                  blurRadius: isHovered ? 12 : 6,
                  offset: Offset(0, isHovered ? 4 : 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blue, Colors.blue.lighter],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(child: Icon(FluentIcons.shopping_cart, size: 22, color: Colors.white)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(order.orderNo, style: theme.typography.bodyStrong?.copyWith(fontSize: 14)),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: statusColor.withOpacity(0.3)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(_getStatusLabel(order.status), style: TextStyle(fontSize: 11, color: statusColor, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(FluentIcons.home, size: 12, color: Colors.teal),
                          const SizedBox(width: 4),
                          Text(storeName, style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[100] : Colors.grey[130])),
                          const SizedBox(width: 16),
                          Icon(FluentIcons.calendar, size: 12, color: Colors.purple),
                          const SizedBox(width: 4),
                          Text(_formatDate(order.orderDate), style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[100] : Colors.grey[130])),
                          if (order.items != null && order.items!.isNotEmpty) ...[
                            const SizedBox(width: 16),
                            Icon(FluentIcons.product_list, size: 12, color: Colors.blue),
                            const SizedBox(width: 4),
                            Text('${order.items!.length} 项', style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[100] : Colors.grey[130])),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('合计金额', style: TextStyle(fontSize: 10, color: Colors.grey[120])),
                    const SizedBox(height: 2),
                    Text(
                      '¥${order.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Icon(FluentIcons.chevron_right, size: 14, color: isHovered ? Colors.blue : Colors.grey[100]),
              ],
            ),
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
