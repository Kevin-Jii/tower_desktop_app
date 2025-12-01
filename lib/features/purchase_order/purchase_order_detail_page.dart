import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/fluent_info_bar.dart';
import 'purchase_order_provider.dart';
import 'models.dart';

class PurchaseOrderDetailPage extends StatefulWidget {
  final int orderId;

  const PurchaseOrderDetailPage({super.key, required this.orderId});

  @override
  State<PurchaseOrderDetailPage> createState() => _PurchaseOrderDetailPageState();
}

class _PurchaseOrderDetailPageState extends State<PurchaseOrderDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PurchaseOrderProvider>().loadOrderDetail(widget.orderId);
    });
  }

  @override
  void dispose() {
    context.read<PurchaseOrderProvider>().clearCurrentOrder();
    super.dispose();
  }

  String _getStatusLabel(int status) {
    switch (status) {
      case 0: return '待确认';
      case 1: return '已确认';
      case 2: return '已完成';
      case 3: return '已取消';
      default: return '未知';
    }
  }

  Color _getStatusColor(int status) {
    switch (status) {
      case 0: return Colors.orange;
      case 1: return Colors.blue;
      case 2: return Colors.green;
      case 3: return Colors.red;
      default: return Colors.grey;
    }
  }

  void _handleConfirm() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('确认订单'),
        content: const Text('确定要确认此采购订单吗？'),
        actions: [
          Button(onPressed: () => Navigator.pop(context, false), child: const Text('取消')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('确认')),
        ],
      ),
    );
    if (result == true && mounted) {
      final success = await context.read<PurchaseOrderProvider>().confirmOrder(widget.orderId);
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '订单已确认');
      } else if (mounted) {
        final err = context.read<PurchaseOrderProvider>().error ?? '确认失败';
        await FluentInfoBarHelper.showError(context, err);
      }
    }
  }

  void _handleCancel() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('取消订单'),
        content: const Text('确定要取消此采购订单吗？此操作不可撤销。'),
        actions: [
          Button(onPressed: () => Navigator.pop(context, false), child: const Text('返回')),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.red)),
            child: const Text('取消订单'),
          ),
        ],
      ),
    );
    if (result == true && mounted) {
      final success = await context.read<PurchaseOrderProvider>().cancelOrder(widget.orderId);
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '订单已取消');
      } else if (mounted) {
        final err = context.read<PurchaseOrderProvider>().error ?? '取消失败';
        await FluentInfoBarHelper.showError(context, err);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Consumer<PurchaseOrderProvider>(
        builder: (context, provider, _) {
          if (provider.detailLoading) {
            return const Center(child: ProgressRing());
          }
          if (provider.currentOrder == null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(FluentIcons.error_badge, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(provider.error ?? '订单不存在'),
                  const SizedBox(height: 16),
                  Button(onPressed: () => Navigator.pop(context), child: const Text('返回')),
                ],
              ),
            );
          }
          return Column(
            children: [
              _buildHeader(provider.currentOrder!),
              Expanded(child: _buildContent(provider.currentOrder!)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(PurchaseOrder order) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final statusColor = _getStatusColor(order.status);
    final isPending = order.status == 0;

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
      child: Row(
        children: [
          IconButton(icon: const Icon(FluentIcons.back, size: 20), onPressed: () => Navigator.pop(context)),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.blue, Colors.blue.lighter]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(FluentIcons.shopping_cart, size: 24, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(order.orderNo, style: theme.typography.title?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: statusColor.withOpacity(0.3)),
                      ),
                      child: Text(_getStatusLabel(order.status), style: TextStyle(fontSize: 12, color: statusColor, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text('${order.store?.name ?? '未知门店'} · ${order.reportDate}', style: theme.typography.caption?.copyWith(color: isDark ? Colors.grey[100] : Colors.grey[130])),
              ],
            ),
          ),
          if (isPending) ...[
            FilledButton(onPressed: _handleConfirm, child: const Text('确认订单')),
            const SizedBox(width: 8),
            Button(
              onPressed: _handleCancel,
              style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.red)),
              child: const Text('取消订单'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildContent(PurchaseOrder order) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Summary
          Card(
            padding: const EdgeInsets.all(20),
            backgroundColor: isDark ? const Color(0xFF2D2D2D) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            child: Row(
              children: [
                _buildSummaryItem('订单金额', '¥${order.totalAmount.toStringAsFixed(2)}', Colors.orange),
                const SizedBox(width: 48),
                _buildSummaryItem('商品数量', '${order.items?.length ?? 0} 项', Colors.blue),
                const SizedBox(width: 48),
                _buildSummaryItem('创建时间', order.createdAt?.split('T').first ?? '-', Colors.grey),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Order Items
          Text('订单明细', style: theme.typography.subtitle?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          if (order.items == null || order.items!.isEmpty)
            Card(
              padding: const EdgeInsets.all(32),
              backgroundColor: isDark ? const Color(0xFF2D2D2D) : Colors.white,
              child: Center(child: Text('暂无订单明细', style: TextStyle(color: Colors.grey[100]))),
            )
          else
            ...order.items!.map((item) => _buildItemCard(item, isDark)),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[130])),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }

  Widget _buildItemCard(PurchaseOrderItem item, bool isDark) {
    final theme = FluentTheme.of(context);
    final product = item.supplierProduct;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      backgroundColor: isDark ? const Color(0xFF2D2D2D) : Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: Text(product?.name.substring(0, 1) ?? '?', style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold))),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product?.name ?? '未知商品', style: theme.typography.bodyStrong),
                if (item.supplier != null) Text('供应商: ${item.supplier!.name}', style: TextStyle(fontSize: 11, color: Colors.grey[130])),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${item.quantity} × ¥${item.price.toStringAsFixed(2)}', style: TextStyle(fontSize: 12, color: Colors.grey[130])),
              Text('¥${item.amount.toStringAsFixed(2)}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange)),
            ],
          ),
        ],
      ),
    );
  }
}
