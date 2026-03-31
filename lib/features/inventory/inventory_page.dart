import 'dart:io';
import 'dart:typed_data';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:file_picker/file_picker.dart';
import 'inventory_provider.dart';
import 'models.dart';
import 'inventory_stock_page.dart';
class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});
  @override
  State<InventoryPage> createState() => _InventoryPageState();
}
class _InventoryPageState extends State<InventoryPage> {
  String _selectedPeriod = 'day';
  List<InventoryOrder>? _lastOrders;
  Map<String, double> _cachedStockIn = {};
  Map<String, double> _cachedStockOut = {};
  List<String> _cachedDisplayDates = [];
  double _cachedMaxValue = 0;
  void _recomputeChartData(List<InventoryOrder> orders) {
    if (identical(orders, _lastOrders)) return; 
    _lastOrders = orders;
    final stockIn = <String, double>{};
    final stockOut = <String, double>{};
    for (final order in orders) {
      final date = _extractDate(order.createdAt);
      if (order.type == InventoryRecordType.stockIn) {
        stockIn[date] = (stockIn[date] ?? 0) + (order.totalQuantity ?? 0);
      } else {
        stockOut[date] = (stockOut[date] ?? 0) + (order.totalQuantity ?? 0);
      }
    }
    final allDates = {...stockIn.keys, ...stockOut.keys}.toList()..sort();
    final displayDates = allDates.length > 7 ? allDates.sublist(allDates.length - 7) : allDates;
    final maxValue = [
      ...displayDates.map((d) => stockIn[d] ?? 0),
      ...displayDates.map((d) => stockOut[d] ?? 0),
    ].fold<double>(0, (max, v) => v > max ? v : max);
    _cachedStockIn = stockIn;
    _cachedStockOut = stockOut;
    _cachedDisplayDates = displayDates;
    _cachedMaxValue = maxValue;
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }
  void _loadData() {
    final provider = context.read<InventoryProvider>();
    provider.loadInventories();
    provider.loadOrders();
  }
  void _navigateToStockPage(int type) async {
    final result = await Navigator.of(context).push<bool>(
      FluentPageRoute(builder: (context) => InventoryStockPage(type: type)),
    );
    if (!mounted) return; 
    if (result == true) {
      _loadData();
    }
  }
  void _navigateToInventoryList() {
    Navigator.of(context).push(
      FluentPageRoute(builder: (context) => const _InventoryListSubPage()),
    );
  }
  void _navigateToRecordList() {
    Navigator.of(context).push(
      FluentPageRoute(builder: (context) => const _InventoryRecordSubPage()),
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.teal, Colors.teal.lighter]),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.teal.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 2)),
              ],
            ),
            child: const Icon(FluentIcons.product_catalog, size: 24, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('库存管理', style: theme.typography.title?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Text('查看库存统计和出入库数据', style: theme.typography.caption?.copyWith(color: isDark ? Colors.grey[100] : Colors.grey[130])),
            ],
          ),
          const Spacer(),
          Consumer<InventoryProvider>(
            builder: (context, provider, _) {
              return Row(
                children: [
                  _buildClickableStatCard(
                    '库存商品',
                    '${provider.inventoryTotal}',
                    FluentIcons.product_list,
                    Colors.blue,
                    isDark,
                    onTap: _navigateToInventoryList,
                  ),
                  const SizedBox(width: 12),
                  _buildClickableStatCard(
                    '出入库单',
                    '${provider.orderTotal}',
                    FluentIcons.history,
                    Colors.purple,
                    isDark,
                    onTap: _navigateToRecordList,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
  Widget _buildClickableStatCard(String label, String value, IconData icon, Color color, bool isDark, {VoidCallback? onTap}) {
    return HoverButton(
      onPressed: onTap,
      builder: (context, states) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: states.isHovered ? color.withOpacity(0.15) : color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: states.isHovered ? color : color.withOpacity(0.2)),
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
              const SizedBox(width: 8),
              Icon(FluentIcons.chevron_right, size: 12, color: states.isHovered ? color : Colors.grey[100]),
            ],
          ),
        );
      },
    );
  }
  Widget _buildContent() {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      color: isDark ? const Color(0xFF1F1F1F) : const Color(0xFFF5F7FA),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPeriodSelector(),
          const SizedBox(height: 24),
          _buildStatsCards(isDark),
          const SizedBox(height: 24),
          Expanded(child: _buildChartArea(isDark)),
        ],
      ),
    );
  }
  Widget _buildPeriodSelector() {
    final periods = [
      ('day', '今日'),
      ('month', '本月'),
      ('quarter', '本季'),
      ('year', '本年'),
    ];
    return Row(
      children: [
        const Icon(FluentIcons.calendar, size: 16),
        const SizedBox(width: 8),
        const Text('统计周期：'),
        const SizedBox(width: 12),
        ...periods.map((p) => Padding(
          padding: const EdgeInsets.only(right: 8),
          child: _buildPeriodChip(p.$1, p.$2),
        )),
      ],
    );
  }
  Widget _buildPeriodChip(String value, String label) {
    final isSelected = _selectedPeriod == value;
    final theme = FluentTheme.of(context);
    return HoverButton(
      onPressed: () => setState(() => _selectedPeriod = value),
      builder: (context, states) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? theme.accentColor : (states.isHovered ? Colors.grey.withOpacity(0.1) : Colors.transparent),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: isSelected ? theme.accentColor : Colors.grey[80]!),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : null,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        );
      },
    );
  }
  Widget _buildStatsCards(bool isDark) {
    return Consumer<InventoryProvider>(
      builder: (context, provider, _) {
        double stockInQty = 0, stockOutQty = 0, totalQty = 0;
        int stockInCount = 0, stockOutCount = 0;
        for (final o in provider.orders) {
          if (o.type == InventoryRecordType.stockIn) {
            stockInQty += o.totalQuantity ?? 0;
            stockInCount++;
          } else {
            stockOutQty += o.totalQuantity ?? 0;
            stockOutCount++;
          }
        }
        for (final i in provider.inventories) {
          totalQty += i.quantity;
        }
        return Row(
          children: [
            Expanded(child: _buildStatInfoCard('库存商品数', '${provider.inventoryTotal}', '种', FluentIcons.product_list, Colors.blue, isDark)),
            const SizedBox(width: 16),
            Expanded(child: _buildStatInfoCard('总库存量', totalQty.toStringAsFixed(1), '', FluentIcons.database, Colors.teal, isDark)),
            const SizedBox(width: 16),
            Expanded(child: _buildStatInfoCard('入库单', '$stockInCount', '单', FluentIcons.add, Colors.green, isDark, subtitle: '+${stockInQty.toStringAsFixed(1)}')),
            const SizedBox(width: 16),
            Expanded(child: _buildStatInfoCard('出库单', '$stockOutCount', '单', FluentIcons.remove, Colors.orange, isDark, subtitle: '-${stockOutQty.toStringAsFixed(1)}')),
          ],
        );
      },
    );
  }
  Widget _buildStatInfoCard(String title, String value, String unit, IconData icon, Color color, bool isDark, {String? subtitle}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(isDark ? 0.2 : 0.05), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 24, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 13, color: Colors.grey[120])),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color)),
                    if (unit.isNotEmpty) ...[
                      const SizedBox(width: 4),
                      Text(unit, style: TextStyle(fontSize: 14, color: Colors.grey[120])),
                    ],
                  ],
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(subtitle, style: TextStyle(fontSize: 12, color: color)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildChartArea(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(isDark ? 0.2 : 0.05), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(FluentIcons.chart, size: 20, color: Colors.blue),
              const SizedBox(width: 8),
              Text('出入库趋势', style: FluentTheme.of(context).typography.subtitle?.copyWith(fontWeight: FontWeight.bold)),
              const Spacer(),
              Row(
                children: [
                  _buildLegendItem('入库', Colors.green),
                  const SizedBox(width: 16),
                  _buildLegendItem('出库', Colors.orange),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(child: _buildSimpleChart(isDark)),
        ],
      ),
    );
  }
  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 6),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[120])),
      ],
    );
  }
  Widget _buildSimpleChart(bool isDark) {
    return Consumer<InventoryProvider>(
      builder: (context, provider, _) {
        if (provider.orders.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(FluentIcons.chart, size: 64, color: Colors.grey[80]),
                const SizedBox(height: 16),
                Text('暂无数据', style: TextStyle(color: Colors.grey[120])),
                const SizedBox(height: 8),
                Text('出入库后将显示趋势图表', style: TextStyle(fontSize: 12, color: Colors.grey[100])),
              ],
            ),
          );
        }
        return _buildBarChart(provider, isDark);
      },
    );
  }
  Widget _buildBarChart(InventoryProvider provider, bool isDark) {
    _recomputeChartData(provider.orders);
    final displayDates = _cachedDisplayDates;
    final stockInByDate = _cachedStockIn;
    final stockOutByDate = _cachedStockOut;
    final maxValue = _cachedMaxValue;
    if (displayDates.isEmpty) {
      return const Center(child: Text('暂无数据'));
    }
    const barLabelStyle = TextStyle(fontSize: 11, color: Color(0xFF9E9E9E));
    return LayoutBuilder(
      builder: (context, constraints) {
        final barWidth = (constraints.maxWidth - 40) / displayDates.length / 2.5;
        return Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: displayDates.map((date) {
                  final stockIn = stockInByDate[date] ?? 0;
                  final stockOut = stockOutByDate[date] ?? 0;
                  final maxHeight = constraints.maxHeight - 40;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Tooltip(
                            message: '入库: ${stockIn.toStringAsFixed(1)}',
                            child: Container(
                              width: barWidth,
                              height: maxValue > 0 ? (stockIn / maxValue * maxHeight).clamp(4, maxHeight) : 4,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Tooltip(
                            message: '出库: ${stockOut.toStringAsFixed(1)}',
                            child: Container(
                              width: barWidth,
                              height: maxValue > 0 ? (stockOut / maxValue * maxHeight).clamp(4, maxHeight) : 4,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(_formatDateLabel(date), style: barLabelStyle),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
  String _extractDate(String? dateStr) {
    if (dateStr == null) return '';
    try {
      final date = DateTime.parse(dateStr);
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    } on FormatException {
      return dateStr.split('T').first;
    } on Object {
      return dateStr.split('T').first;
    }
  }
  String _formatDateLabel(String date) {
    if (date.length >= 10) {
      return date.substring(5); 
    }
    return date;
  }
}
class _InventoryListSubPage extends StatefulWidget {
  const _InventoryListSubPage();
  @override
  State<_InventoryListSubPage> createState() => _InventoryListSubPageState();
}
class _InventoryListSubPageState extends State<_InventoryListSubPage> {
  String _searchText = '';
  List<Inventory>? _lastInventories;
  String? _lastSearchText;
  List<Inventory> _filteredList = [];
  List<Inventory> _getFilteredList(List<Inventory> inventories) {
    if (identical(inventories, _lastInventories) && _searchText == _lastSearchText) {
      return _filteredList;
    }
    _lastInventories = inventories;
    _lastSearchText = _searchText;
    _filteredList = _searchText.isEmpty
        ? inventories
        : inventories.where((item) => (item.productName ?? '').contains(_searchText)).toList();
    return _filteredList;
  }
  void _onSearchChanged(String value) {
    setState(() => _searchText = value);
  }
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgBase = isDark ? const Color(0xFF202020) : const Color(0xFFF5F7FA);
    final cardColor = isDark ? const Color(0xFF2B2B2B) : Colors.white;
    final borderColor = isDark ? Colors.grey[100].withOpacity(0.1) : const Color(0xFFE0E0E0);
    final dividerColor = isDark ? const Color(0xFF333333) : const Color(0xFFE5E5E5);
    return ScaffoldPage(
      padding: EdgeInsets.zero, 
      content: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
              border: Border(bottom: BorderSide(color: dividerColor)),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(FluentIcons.back, size: 14),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '库存列表', 
                      style: theme.typography.subtitle?.copyWith(fontWeight: FontWeight.bold)
                    ),
                    const SizedBox(height: 2),
                    Consumer<InventoryProvider>(
                      builder: (_, provider, __) => Text(
                        '共 ${provider.inventories.length} 种商品', 
                        style: theme.typography.caption?.copyWith(color: Colors.grey[100])
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: 240,
                  child: TextBox(
                    placeholder: '搜索商品名称...',
                    prefix: const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(FluentIcons.search, size: 14),
                    ),
                    onChanged: (value) => _onSearchChanged(value),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: bgBase, 
              child: Consumer<InventoryProvider>(
                builder: (context, provider, _) {
                  if (provider.inventoryLoading) {
                    return const Center(child: ProgressRing());
                  }
                  final filteredList = _getFilteredList(provider.inventories);
                  if (filteredList.isEmpty) {
                    return _buildEmptyState();
                  }
                  return GridView.builder(
                    padding: const EdgeInsets.all(24),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 260, 
                      mainAxisExtent: 88,      
                      crossAxisSpacing: 12,    
                      mainAxisSpacing: 12,     
                    ),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final inventory = filteredList[index];
                      return _buildCompactTile(inventory, isDark, theme, cardColor, borderColor);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(FluentIcons.search, size: 48, color: Colors.grey[80]),
          const SizedBox(height: 12),
          Text(
            '没有找到相关商品', 
            style: TextStyle(color: Colors.grey[120])
          ),
        ],
      ),
    );
  }
  Widget _buildCompactTile(
    Inventory inventory, 
    bool isDark, 
    FluentThemeData theme,
    Color cardColor,
    Color borderColor,
  ) {
    final quantity = inventory.quantity;
    Color statusColor;
    if (quantity <= 0) {
      statusColor = Colors.red;    
    } else if (quantity < 10) {
      statusColor = Colors.orange; 
    } else {
      statusColor = Colors.green;  
    }
    return HoverButton(
      onPressed: () {
      },
      builder: (context, states) {
        final isHovered = states.isHovered;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(6), 
            border: Border.all(
              color: isHovered ? theme.accentColor.withOpacity(0.5) : borderColor,
              width: 1,
            ),
            boxShadow: [
              if (isHovered)
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: double.infinity,
                  color: statusColor,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 10, 16, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                inventory.productName ?? '未知商品',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600, 
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey[20],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  inventory.storeName ?? '总部',
                                  style: TextStyle(
                                    fontSize: 10, 
                                    color: Colors.grey[120]
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              quantity.toStringAsFixed(quantity == quantity.truncate() ? 0 : 1),
                              style: TextStyle(
                                fontSize: 24, 
                                fontWeight: FontWeight.bold,
                                color: statusColor, 
                                height: 1.0,
                                fontFamily: 'Segoe UI', 
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              inventory.unit ?? '件',
                              style: TextStyle(
                                fontSize: 11, 
                                color: Colors.grey[100]
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
class _InventoryRecordSubPage extends StatefulWidget {
  const _InventoryRecordSubPage();
  @override
  State<_InventoryRecordSubPage> createState() => _InventoryRecordSubPageState();
}
class _InventoryRecordSubPageState extends State<_InventoryRecordSubPage> {
  String _selectedPeriod = 'day';
  int? _selectedType;
  List<InventoryOrder>? _lastOrdersForFilter;
  String? _lastPeriodFilter;
  int? _lastTypeFilter;
  List<InventoryOrder> _filteredOrdersCache = [];
  List<InventoryOrder> _getCachedFilteredOrders(List<InventoryOrder> orders) {
    if (identical(orders, _lastOrdersForFilter) &&
        _selectedPeriod == _lastPeriodFilter &&
        _selectedType == _lastTypeFilter) {
      return _filteredOrdersCache;
    }
    _lastOrdersForFilter = orders;
    _lastPeriodFilter = _selectedPeriod;
    _lastTypeFilter = _selectedType;
    _filteredOrdersCache = _filterOrders(orders);
    return _filteredOrdersCache;
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<InventoryProvider>().loadOrders();
    });
  }
  void _navigateToStockPage(int type) async {
    final result = await Navigator.of(context).push<bool>(
      FluentPageRoute(builder: (context) => InventoryStockPage(type: type)),
    );
    if (!mounted) return; 
    if (result == true) {
      context.read<InventoryProvider>().loadOrders();
    }
  }
  List<InventoryOrder> _filterOrders(List<InventoryOrder> orders) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return orders.where((order) {
      if (_selectedType != null && order.type != _selectedType) {
        return false;
      }
      if (order.createdAt == null) return false;
      try {
        final orderDate = DateTime.parse(order.createdAt!);
        switch (_selectedPeriod) {
          case 'day':
            return orderDate.isAfter(today) || orderDate.isAtSameMomentAs(today);
          case 'week':
            final weekStart = today.subtract(Duration(days: today.weekday - 1));
            return orderDate.isAfter(weekStart) || orderDate.isAtSameMomentAs(weekStart);
          case 'month':
            return orderDate.year == now.year && orderDate.month == now.month;
          case 'quarter':
            final quarterStart = DateTime(now.year, ((now.month - 1) ~/ 3) * 3 + 1, 1);
            return orderDate.isAfter(quarterStart) || orderDate.isAtSameMomentAs(quarterStart);
          default:
            return true;
        }
      } on Object {
        return false;
      }
    }).toList();
  }
  void _showOrderDetail(InventoryOrder order) {
    showDialog(
      context: context,
      builder: (context) => _OrderDetailDialog(order: order),
    );
  }
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Column(
        children: [
          _buildHeader(theme, isDark),
          _buildFilterBar(theme, isDark),
          Expanded(
            child: Consumer<InventoryProvider>(
              builder: (context, provider, _) {
                if (provider.orderLoading) {
                  return const Center(child: ProgressRing());
                }
                final filteredOrders = _getCachedFilteredOrders(provider.orders);
                if (filteredOrders.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(FluentIcons.history, size: 64, color: Colors.grey[80]),
                        const SizedBox(height: 16),
                        Text('暂无出入库单', style: TextStyle(fontSize: 16, color: Colors.grey[120])),
                        const SizedBox(height: 8),
                        Text('当前筛选条件下没有记录', style: TextStyle(fontSize: 12, color: Colors.grey[100])),
                      ],
                    ),
                  );
                }
                final stockInOrders = filteredOrders.where((o) => o.type == InventoryRecordType.stockIn).toList();
                final stockOutOrders = filteredOrders.where((o) => o.type == InventoryRecordType.stockOut).toList();
                final stockInQty = stockInOrders.fold<double>(0, (sum, o) => sum + (o.totalQuantity ?? 0));
                final stockOutQty = stockOutOrders.fold<double>(0, (sum, o) => sum + (o.totalQuantity ?? 0));
                return Column(
                  children: [
                    _buildStatsRow(stockInOrders.length, stockOutOrders.length, stockInQty, stockOutQty, isDark),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                        itemCount: filteredOrders.length,
                        itemBuilder: (context, index) {
                          final order = filteredOrders[index];
                          return _buildOrderCard(order, isDark, theme);
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildHeader(FluentThemeData theme, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.purple.withOpacity(0.08),
            isDark ? const Color(0xFF2D2D2D) : theme.micaBackgroundColor,
          ],
        ),
        border: Border(bottom: BorderSide(color: theme.resources.dividerStrokeColorDefault)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(FluentIcons.back, size: 18),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.purple, Colors.purple.lighter]),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.purple.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 2)),
              ],
            ),
            child: const Icon(FluentIcons.history, size: 20, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('出入库记录', style: theme.typography.subtitle?.copyWith(fontWeight: FontWeight.bold)),
              Text('查看和管理出入库操作记录', style: theme.typography.caption?.copyWith(color: Colors.grey[120])),
            ],
          ),
          const Spacer(),
          FilledButton(
            onPressed: () => _navigateToStockPage(InventoryRecordType.stockIn),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.green),
              padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(FluentIcons.add, size: 14),
                SizedBox(width: 6),
                Text('入库'),
              ],
            ),
          ),
          const SizedBox(width: 10),
          FilledButton(
            onPressed: () => _navigateToStockPage(InventoryRecordType.stockOut),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.orange),
              padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(FluentIcons.remove, size: 14),
                SizedBox(width: 6),
                Text('出库'),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildFilterBar(FluentThemeData theme, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252525) : const Color(0xFFFAFAFA),
      ),
      child: Row(
        children: [
          Icon(FluentIcons.calendar, size: 14, color: Colors.grey[120]),
          const SizedBox(width: 8),
          ...[
            ('day', '今日'),
            ('week', '本周'),
            ('month', '本月'),
            ('quarter', '本季'),
          ].map((p) => Padding(
            padding: const EdgeInsets.only(right: 6),
            child: _buildFilterChip(p.$1, p.$2, _selectedPeriod == p.$1, () {
              setState(() => _selectedPeriod = p.$1);
            }),
          )),
          const SizedBox(width: 20),
          Container(width: 1, height: 20, color: Colors.grey[60]),
          const SizedBox(width: 20),
          Icon(FluentIcons.filter, size: 14, color: Colors.grey[120]),
          const SizedBox(width: 8),
          _buildFilterChip('all', '全部', _selectedType == null, () {
            setState(() => _selectedType = null);
          }),
          const SizedBox(width: 6),
          _buildFilterChip('in', '入库', _selectedType == 1, () {
            setState(() => _selectedType = 1);
          }, color: Colors.green),
          const SizedBox(width: 6),
          _buildFilterChip('out', '出库', _selectedType == 2, () {
            setState(() => _selectedType = 2);
          }, color: Colors.orange),
        ],
      ),
    );
  }
  Widget _buildFilterChip(String value, String label, bool isSelected, VoidCallback onTap, {Color? color}) {
    final chipColor = color ?? FluentTheme.of(context).accentColor;
    return HoverButton(
      onPressed: onTap,
      builder: (context, states) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? chipColor : (states.isHovered ? chipColor.withOpacity(0.1) : Colors.transparent),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isSelected ? chipColor : Colors.grey[80]!),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.white : null,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        );
      },
    );
  }
  Widget _buildStatsRow(int stockInCount, int stockOutCount, double stockInQty, double stockOutQty, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            child: _buildMiniStatCard(
              '入库',
              '$stockInCount 次',
              '+${stockInQty.toStringAsFixed(1)}',
              FluentIcons.add,
              Colors.green,
              isDark,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildMiniStatCard(
              '出库',
              '$stockOutCount 次',
              '-${stockOutQty.toStringAsFixed(1)}',
              FluentIcons.remove,
              Colors.orange,
              isDark,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildMiniStatCard(
              '净入库',
              '${(stockInQty - stockOutQty).toStringAsFixed(1)}',
              '${stockInCount + stockOutCount} 条记录',
              FluentIcons.calculator,
              Colors.blue,
              isDark,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildMiniStatCard(String title, String value, String subtitle, IconData icon, Color color, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(0.1),
            color.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[120])),
                const SizedBox(height: 2),
                Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
                Text(subtitle, style: TextStyle(fontSize: 11, color: Colors.grey[100])),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildOrderCard(InventoryOrder order, bool isDark, FluentThemeData theme) {
    final isStockIn = order.type == InventoryRecordType.stockIn;
    final typeColor = isStockIn ? Colors.green : Colors.orange;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: HoverButton(
        onPressed: () => _showOrderDetail(order),
        builder: (context, states) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: states.isHovered ? typeColor.withOpacity(0.5) : (isDark ? Colors.grey[100].withOpacity(0.1) : Colors.grey[30]!),
                width: states.isHovered ? 1.5 : 1,
              ),
              boxShadow: states.isHovered ? [
                BoxShadow(color: typeColor.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 2)),
              ] : null,
            ),
            child: Row(
              children: [
                Container(
                  width: 48, height: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [typeColor, typeColor.withOpacity(0.7)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: typeColor.withOpacity(0.3), blurRadius: 6, offset: const Offset(0, 2)),
                    ],
                  ),
                  child: Icon(isStockIn ? FluentIcons.add : FluentIcons.remove, size: 22, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(order.orderNo ?? '-', style: theme.typography.bodyStrong?.copyWith(fontSize: 14)),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: typeColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              isStockIn ? '入库单' : '出库单',
                              style: TextStyle(fontSize: 11, color: typeColor, fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${order.itemCount ?? order.items.length} 项',
                              style: TextStyle(fontSize: 10, color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(FluentIcons.info, size: 12, color: Colors.grey[100]),
                          const SizedBox(width: 4),
                          Text(
                            order.reason ?? '-',
                            style: TextStyle(fontSize: 12, color: Colors.grey[120]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${isStockIn ? '+' : '-'}${(order.totalQuantity ?? 0).toStringAsFixed(1)}',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: typeColor),
                    ),
                    const SizedBox(height: 4),
                    Text(_formatDateTime(order.createdAt), style: TextStyle(fontSize: 11, color: Colors.grey[100])),
                  ],
                ),
                const SizedBox(width: 8),
                Icon(FluentIcons.chevron_right, size: 14, color: states.isHovered ? typeColor : Colors.grey[100]),
              ],
            ),
          );
        },
      ),
    );
  }
  String _formatDateTime(String? dateStr) {
    if (dateStr == null) return '-';
    try {
      final date = DateTime.parse(dateStr);
      return '${date.month}/${date.day} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } on FormatException {
      return dateStr;
    } on Object {
      return dateStr;
    }
  }
}
class _OrderDetailDialog extends StatefulWidget {
  final InventoryOrder order;
  const _OrderDetailDialog({required this.order});
  @override
  State<_OrderDetailDialog> createState() => _OrderDetailDialogState();
}
class _OrderDetailDialogState extends State<_OrderDetailDialog> {
  final ScreenshotController _screenshotController = ScreenshotController();
  bool _saving = false;
  InventoryOrder get order => widget.order;
  Future<void> _saveAsImage() async {
    if (_saving) return;
    setState(() => _saving = true);
    try {
      final itemCount = order.items.length;
      final estimatedHeight = 32.0 * 2 + 
          50.0 + 
          24.0 + 
          44.0 + 
          (itemCount * 44.0) + 
          24.0 + 
          30.0; 
      final Uint8List? imageBytes = await _screenshotController.captureFromWidget(
        _buildOrderImageWidget(),
        delay: const Duration(milliseconds: 100),
        pixelRatio: 2.0,
        targetSize: Size(700, estimatedHeight),
      );
      if (imageBytes == null) {
        if (mounted) {
          displayInfoBar(context, builder: (context, close) {
            return InfoBar(
              title: const Text('生成图片失败'),
              severity: InfoBarSeverity.error,
              action: IconButton(icon: const Icon(FluentIcons.clear), onPressed: close),
            );
          });
        }
        return;
      }
      final isStockIn = order.type == InventoryRecordType.stockIn;
      final String? outputPath = await FilePicker.platform.saveFile(
        dialogTitle: '保存${isStockIn ? '入库单' : '出库单'}图片',
        fileName: '${order.orderNo ?? 'order'}.png',
        type: FileType.image,
        allowedExtensions: ['png'],
      );
      if (outputPath != null) {
        final file = File(outputPath.endsWith('.png') ? outputPath : '$outputPath.png');
        await file.writeAsBytes(imageBytes);
        if (mounted) {
          displayInfoBar(context, builder: (context, close) {
            return InfoBar(
              title: const Text('图片保存成功'),
              severity: InfoBarSeverity.success,
              action: IconButton(icon: const Icon(FluentIcons.clear), onPressed: close),
            );
          });
        }
      }
    } catch (e) {
      if (mounted) {
        displayInfoBar(context, builder: (context, close) {
          return InfoBar(
            title: Text('保存失败: $e'),
            severity: InfoBarSeverity.error,
            action: IconButton(icon: const Icon(FluentIcons.clear), onPressed: close),
          );
        });
      }
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }
  Widget _buildOrderImageWidget() {
    final isStockIn = order.type == InventoryRecordType.stockIn;
    final titleColor = isStockIn ? const Color(0xFF22C55E) : const Color(0xFFF97316);
    return Container(
      width: 700,
      padding: const EdgeInsets.all(32),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '${order.storeName ?? ''}${isStockIn ? '入库' : '出库'}明细',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                ),
              ),
              Text(
                '操作人：${order.operatorName ?? '-'}',
                style: const TextStyle(fontSize: 14, color: Color(0xFF666666)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Table(
            border: const TableBorder(
              top: BorderSide(color: Color(0xFFE0E0E0)),
              bottom: BorderSide(color: Color(0xFFE0E0E0)),
              horizontalInside: BorderSide(color: Color(0xFFE0E0E0)),
            ),
            columnWidths: const {
              0: FlexColumnWidth(3),   
              1: FlexColumnWidth(1.2), 
              2: FlexColumnWidth(1),   
              3: FlexColumnWidth(2),   
            },
            children: [
              const TableRow(
                children: [
                  _ReportTableHeaderCell(text: '商品名称'),
                  _ReportTableHeaderCell(text: '商品规格'),
                  _ReportTableHeaderCell(text: '数量'),
                  _ReportTableHeaderCell(text: '备注'),
                ],
              ),
              ...order.items.map((item) => TableRow(
                children: [
                  _ReportTableDataCell(text: item.productName ?? item.product?.name ?? '-'),
                  _ReportTableDataCell(text: item.unit ?? '斤'),
                  _ReportTableDataCell(text: item.quantity.toStringAsFixed(item.quantity == item.quantity.truncate() ? 0 : 1)),
                  _ReportTableDataCell(text: item.remark ?? ''),
                ],
              )),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '负责人电话：${order.operatorPhone ?? '未设置'}',
                style: const TextStyle(fontSize: 12, color: Color(0xFF666666)),
              ),
              const Text(
                '门店地址：未设置',
                style: TextStyle(fontSize: 12, color: Color(0xFF666666)),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: isHeader ? FontWeight.w600 : FontWeight.normal,
          color: isHeader ? const Color(0xFF333333) : const Color(0xFF666666),
        ),
        textAlign: isHeader ? TextAlign.center : TextAlign.left,
      ),
    );
  }
  String _formatDateShort(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '-';
    try {
      final date = DateTime.parse(dateStr);
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    } on FormatException {
      if (dateStr.length >= 10) return dateStr.substring(0, 10);
      return dateStr;
    } on Object {
      if (dateStr.length >= 10) return dateStr.substring(0, 10);
      return dateStr;
    }
  }
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isStockIn = order.type == InventoryRecordType.stockIn;
    final typeColor = isStockIn ? Colors.green : Colors.orange;
    return ContentDialog(
      constraints: const BoxConstraints(maxWidth: 580),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: typeColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(isStockIn ? FluentIcons.add : FluentIcons.remove, size: 18, color: typeColor),
          ),
          const SizedBox(width: 12),
          Text(isStockIn ? '入库单详情' : '出库单详情'),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: typeColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              isStockIn ? '入库' : '出库',
              style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [typeColor.withOpacity(0.1), typeColor.withOpacity(0.05)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('单号', style: TextStyle(fontSize: 12, color: Colors.grey[120])),
                      const SizedBox(height: 4),
                      Text(order.orderNo ?? '-', style: theme.typography.bodyStrong),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(FluentIcons.info, size: 12, color: Colors.grey[100]),
                          const SizedBox(width: 4),
                          Text(order.reason ?? '-', style: TextStyle(fontSize: 12, color: Colors.grey[120])),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: typeColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${isStockIn ? '+' : '-'}${(order.totalQuantity ?? 0).toStringAsFixed(1)}',
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text('${order.itemCount ?? order.items.length} 项商品', style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.8))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildInfoItem('门店', order.storeName ?? order.store?.name ?? '-', FluentIcons.shop, isDark)),
              const SizedBox(width: 12),
              Expanded(child: _buildInfoItem('操作时间', _formatFullDateTime(order.createdAt), FluentIcons.clock, isDark)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildInfoItem('操作人员', order.operatorName ?? order.operator?.nickname ?? '-', FluentIcons.contact, isDark)),
              const SizedBox(width: 12),
              Expanded(child: _buildInfoItem('联系电话', order.operatorPhone ?? '-', FluentIcons.phone, isDark)),
            ],
          ),
          if (order.remark != null && order.remark!.isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildInfoItem('备注', order.remark!, FluentIcons.edit_note, isDark),
          ],
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(FluentIcons.product_list, size: 14, color: typeColor),
              const SizedBox(width: 8),
              Text('商品明细', style: theme.typography.bodyStrong),
              const Spacer(),
              Text('${order.items.length} 项', style: TextStyle(fontSize: 12, color: Colors.grey[120])),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            constraints: const BoxConstraints(maxHeight: 200),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF252525) : const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: isDark ? Colors.grey[100].withOpacity(0.1) : Colors.grey[30]!),
            ),
            child: order.items.isEmpty
                ? const Center(child: Padding(padding: EdgeInsets.all(20), child: Text('暂无商品明细')))
                : ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: order.items.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final item = order.items[index];
                      return _buildItemRow(item, isStockIn, typeColor, isDark);
                    },
                  ),
          ),
        ],
      ),
      actions: [
        Button(
          onPressed: _saving ? null : _saveAsImage,
          child: _saving
              ? const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 14, height: 14, child: ProgressRing(strokeWidth: 2)),
                    SizedBox(width: 8),
                    Text('保存中...'),
                  ],
                )
              : const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(FluentIcons.download, size: 14),
                    SizedBox(width: 6),
                    Text('下载图片'),
                  ],
                ),
        ),
        const SizedBox(width: 8),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('关闭'),
        ),
      ],
    );
  }
  Widget _buildInfoItem(String label, String value, IconData icon, bool isDark) {
    return Row(
      children: [
        Container(
          width: 28, height: 28,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF3D3D3D) : const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, size: 12, color: Colors.grey[120]),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 10, color: Colors.grey[120])),
              Text(value, style: TextStyle(fontSize: 12, color: isDark ? Colors.white : const Color(0xFF333333))),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildItemRow(InventoryOrderItem item, bool isStockIn, Color typeColor, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.productName ?? item.product?.name ?? '商品 #${item.productId}', style: const TextStyle(fontSize: 13)),
                if (item.productionDate != null || item.expiryDate != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Row(
                      children: [
                        if (item.productionDate != null) ...[
                          Icon(FluentIcons.calendar, size: 10, color: Colors.grey[100]),
                          const SizedBox(width: 2),
                          Text('生产: ${_formatDate(item.productionDate)}', style: TextStyle(fontSize: 10, color: Colors.grey[120])),
                          const SizedBox(width: 8),
                        ],
                        if (item.expiryDate != null) ...[
                          Icon(FluentIcons.event_date, size: 10, color: Colors.grey[100]),
                          const SizedBox(width: 2),
                          Text('保质期: ${_formatDate(item.expiryDate)}', style: TextStyle(fontSize: 10, color: Colors.grey[120])),
                        ],
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Text(
            '${isStockIn ? '+' : '-'}${item.quantity.toStringAsFixed(item.quantity == item.quantity.truncate() ? 0 : 1)}',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: typeColor),
          ),
          if (item.unit != null) ...[
            const SizedBox(width: 4),
            Text(item.unit!, style: TextStyle(fontSize: 11, color: Colors.grey[120])),
          ],
        ],
      ),
    );
  }
  String _formatFullDateTime(String? dateStr) {
    if (dateStr == null) return '-';
    try {
      final date = DateTime.parse(dateStr);
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} '
          '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } on FormatException {
      return dateStr;
    } on Object {
      return dateStr;
    }
  }
  String _formatDate(String? dateStr) {
    if (dateStr == null) return '-';
    try {
      final date = DateTime.parse(dateStr);
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    } on FormatException {
      if (dateStr.length == 10) return dateStr;
      return dateStr.split('T').first;
    } on Object {
      if (dateStr.length == 10) return dateStr;
      return dateStr.split('T').first;
    }
  }
}
class _ReportTableHeaderCell extends StatelessWidget {
  final String text;
  const _ReportTableHeaderCell({required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF666666),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
class _ReportTableDataCell extends StatelessWidget {
  final String text;
  const _ReportTableDataCell({required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, color: Color(0xFF333333)),
        textAlign: TextAlign.center,
      ),
    );
  }
}
class _EditInventoryDialog extends StatefulWidget {
  final Inventory inventory;
  const _EditInventoryDialog({required this.inventory});
  @override
  State<_EditInventoryDialog> createState() => _EditInventoryDialogState();
}
class _EditInventoryDialogState extends State<_EditInventoryDialog> {
  late TextEditingController _quantityController;
  late TextEditingController _remarkController;
  bool _saving = false;
  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController(
      text: widget.inventory.quantity.toStringAsFixed(
        widget.inventory.quantity == widget.inventory.quantity.truncate() ? 0 : 2,
      ),
    );
    _remarkController = TextEditingController();
  }
  @override
  void dispose() {
    _quantityController.dispose();
    _remarkController.dispose();
    super.dispose();
  }
  Future<void> _save() async {
    final quantity = double.tryParse(_quantityController.text);
    if (quantity == null || quantity < 0) {
      displayInfoBar(context, builder: (context, close) {
        return InfoBar(
          title: const Text('请输入有效的数量'),
          severity: InfoBarSeverity.warning,
          action: IconButton(icon: const Icon(FluentIcons.clear), onPressed: close),
        );
      });
      return;
    }
    setState(() => _saving = true);
    final provider = context.read<InventoryProvider>();
    final remark = _remarkController.text.trim();
    final success = await provider.updateInventory(
      widget.inventory.id,
      quantity,
      remark: remark.isEmpty ? null : remark,
    );
    if (mounted) {
      setState(() => _saving = false);
      if (success) {
        displayInfoBar(context, builder: (context, close) {
          return InfoBar(
            title: const Text('库存调整成功'),
            severity: InfoBarSeverity.success,
            action: IconButton(icon: const Icon(FluentIcons.clear), onPressed: close),
          );
        });
        Navigator.of(context).pop();
      } else {
        displayInfoBar(context, builder: (context, close) {
          return InfoBar(
            title: Text(provider.inventoryError ?? '调整失败'),
            severity: InfoBarSeverity.error,
            action: IconButton(icon: const Icon(FluentIcons.clear), onPressed: close),
          );
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final inventory = widget.inventory;
    return ContentDialog(
      constraints: const BoxConstraints(maxWidth: 400),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(FluentIcons.edit, size: 18, color: Colors.teal),
          ),
          const SizedBox(width: 12),
          const Text('调整库存'),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(FluentIcons.product, size: 20, color: Colors.teal),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        inventory.productName ?? '未知商品',
                        style: theme.typography.bodyStrong,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '当前库存: ${inventory.quantity.toStringAsFixed(inventory.quantity == inventory.quantity.truncate() ? 0 : 2)} ${inventory.unit ?? ''}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[120]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          InfoLabel(
            label: '调整后数量',
            child: TextBox(
              controller: _quantityController,
              placeholder: '请输入数量',
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              suffix: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(inventory.unit ?? '件', style: TextStyle(color: Colors.grey[100])),
              ),
            ),
          ),
          const SizedBox(height: 16),
          InfoLabel(
            label: '调整原因（选填）',
            child: TextBox(
              controller: _remarkController,
              placeholder: '如：盘点调整、损耗等',
              maxLines: 2,
            ),
          ),
        ],
      ),
      actions: [
        Button(
          onPressed: _saving ? null : () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: _saving
              ? const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 14, height: 14, child: ProgressRing(strokeWidth: 2)),
                    SizedBox(width: 8),
                    Text('保存中...'),
                  ],
                )
              : const Text('保存'),
        ),
      ],
    );
  }
}
