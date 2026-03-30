import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/fluent_info_bar.dart';
import 'printer_provider.dart';
import 'models.dart';
import 'printer_form_dialog.dart';
class PrinterManagementPage extends StatefulWidget {
  final int storeId;
  final String storeName;
  const PrinterManagementPage({
    super.key,
    required this.storeId,
    required this.storeName,
  });
  @override
  State<PrinterManagementPage> createState() => _PrinterManagementPageState();
}
class _PrinterManagementPageState extends State<PrinterManagementPage> {
  final Set<int> _updatingPrinters = {};
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PrinterProvider>().loadPrinters(storeId: widget.storeId);
    });
  }
  void _handleBind() async {
    final result = await showDialog<BindPrinterReq>(
      context: context,
      builder: (ctx) => PrinterFormDialog(storeId: widget.storeId),
    );
    if (result != null && mounted) {
      final success = await context.read<PrinterProvider>().bindPrinter(result);
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '绑定成功');
      } else if (mounted) {
        final err = context.read<PrinterProvider>().error ?? '绑定失败';
        await FluentInfoBarHelper.showError(context, err);
      }
    }
  }
  void _handleEdit(Printer printer) async {
    final result = await showDialog<UpdatePrinterReq>(
      context: context,
      builder: (ctx) => PrinterFormDialog(
        storeId: widget.storeId,
        printer: printer,
      ),
    );
    if (result != null && mounted) {
      final success = await context.read<PrinterProvider>().updatePrinter(printer.id, result);
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '更新成功');
      } else if (mounted) {
        final err = context.read<PrinterProvider>().error ?? '更新失败';
        await FluentInfoBarHelper.showError(context, err);
      }
    }
  }
  void _handleDelete(Printer printer) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('确认解绑'),
        content: Text('确定要解绑打印机 "${printer.name}" 吗？'),
        actions: [
          Button(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.red)),
            child: const Text('解绑'),
          ),
        ],
      ),
    );
    if (result == true && mounted) {
      final success = await context.read<PrinterProvider>().deletePrinter(printer.id);
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '解绑成功');
      } else if (mounted) {
        final err = context.read<PrinterProvider>().error ?? '解绑失败';
        await FluentInfoBarHelper.showError(context, err);
      }
    }
  }
  void _handleSetDefault(Printer printer) async {
    setState(() => _updatingPrinters.add(printer.id));
    final success = await context.read<PrinterProvider>().setDefaultPrinter(printer.id);
    if (mounted) {
      setState(() => _updatingPrinters.remove(printer.id));
    }
    if (success && mounted) {
      await FluentInfoBarHelper.showSuccess(context, '已设为默认打印机');
    } else if (mounted) {
      final err = context.read<PrinterProvider>().error ?? '设置失败';
      await FluentInfoBarHelper.showError(context, err);
    }
  }
  void _handleRefreshStatus() async {
    await context.read<PrinterProvider>().refreshPrinterStatus();
    if (mounted) {
      await FluentInfoBarHelper.showSuccess(context, '状态已刷新');
    }
  }
  void _handleTestPrint(Printer printer) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('测试打印'),
        content: Text('确定要对打印机 "${printer.name}" 进行测试打印吗？'),
        actions: [
          Button(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('确认'),
          ),
        ],
      ),
    );
    if (result == true && mounted) {
      final success = await context.read<PrinterProvider>().testPrint(printer.id);
      if (success && mounted) {
        await FluentInfoBarHelper.showSuccess(context, '测试打印已发送');
      } else if (mounted) {
        final err = context.read<PrinterProvider>().error ?? '测试打印失败';
        await FluentInfoBarHelper.showError(context, err);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Column(
        children: [
          _buildHeader(),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }
  Widget _buildHeader() {
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
        border: Border(
          bottom: BorderSide(
            color: theme.resources.dividerStrokeColorDefault,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(FluentIcons.back, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.teal, Colors.teal.lighter],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(FluentIcons.print, size: 24, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.storeName} - 打印机管理',
                style: theme.typography.title?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Text(
                '管理门店打印机设备',
                style: theme.typography.caption?.copyWith(
                  color: isDark ? Colors.grey[100] : Colors.grey[130],
                ),
              ),
            ],
          ),
          const Spacer(),
          Button(
            onPressed: _handleRefreshStatus,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(FluentIcons.refresh, size: 16),
                SizedBox(width: 6),
                Text('刷新状态'),
              ],
            ),
          ),
          const SizedBox(width: 12),
          FilledButton(
            onPressed: _handleBind,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(FluentIcons.add, size: 18),
                SizedBox(width: 8),
                Text('绑定打印机'),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildContent() {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Consumer<PrinterProvider>(
      builder: (context, provider, _) {
        if (provider.loading) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ProgressRing(),
                const SizedBox(height: 20),
                Text(
                  '加载中...',
                  style: theme.typography.body?.copyWith(
                    color: isDark ? Colors.grey[100] : Colors.grey[130],
                  ),
                ),
              ],
            ),
          );
        }
        if (provider.error != null && provider.printers.isEmpty) {
          return _buildErrorState(provider);
        }
        if (provider.printers.isEmpty) {
          return _buildEmptyState();
        }
        return _buildPrinterList(provider.printers);
      },
    );
  }
  Widget _buildErrorState(PrinterProvider provider) {
    final theme = FluentTheme.of(context);
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
            Text(
              '加载失败',
              style: theme.typography.subtitle?.copyWith(
                color: Colors.red.dark,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              provider.error!,
              style: theme.typography.body?.copyWith(color: Colors.red.darker),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => provider.loadPrinters(storeId: widget.storeId),
              style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.red)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(FluentIcons.refresh, size: 16),
                  SizedBox(width: 8),
                  Text('重试'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildEmptyState() {
    final theme = FluentTheme.of(context);
    return Center(
      child: Container(
        padding: const EdgeInsets.all(48),
        margin: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.teal.withOpacity(0.05),
              Colors.blue.withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.teal.withOpacity(0.1), width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal.withOpacity(0.1), Colors.blue.withOpacity(0.1)],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(FluentIcons.print, size: 72, color: Colors.teal),
            ),
            const SizedBox(height: 24),
            Text(
              '暂无打印机',
              style: theme.typography.title?.copyWith(
                color: Colors.grey[160],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '点击右上角"绑定打印机"按钮添加第一台打印机',
              style: theme.typography.body?.copyWith(color: Colors.grey[130]),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _handleBind,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(FluentIcons.add, size: 18),
                  SizedBox(width: 8),
                  Text('绑定打印机'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildPrinterList(List<Printer> printers) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      color: isDark ? const Color(0xFF1F1F1F) : const Color(0xFFF5F7FA),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: printers.map((printer) => _buildPrinterCard(printer)).toList(),
        ),
      ),
    );
  }
  Widget _buildPrinterCard(Printer printer) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isDefault = printer.isDefault == 1;
    final isUpdating = _updatingPrinters.contains(printer.id);
    final printerType = PrinterTypeEnum.fromValue(printer.type);
    final printerStatus = PrinterStatusEnum.fromValue(printer.status);
    final onlineStatus = PrinterOnlineEnum.fromValue(printer.online) ?? PrinterOnlineEnum.offline;
    final primaryColor = onlineStatus == PrinterOnlineEnum.online
        ? Colors.teal
        : (onlineStatus == PrinterOnlineEnum.error ? Colors.red : Colors.grey);
    final statusColor = onlineStatus == PrinterOnlineEnum.online
        ? Colors.green
        : (onlineStatus == PrinterOnlineEnum.error ? Colors.red : Colors.orange);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark
            ? (onlineStatus == PrinterOnlineEnum.online
                ? const Color(0xFF2D2D2D)
                : (onlineStatus == PrinterOnlineEnum.error
                    ? const Color(0xFF2D2020)
                    : const Color(0xFF252525)))
            : (onlineStatus == PrinterOnlineEnum.online
                ? Colors.white
                : (onlineStatus == PrinterOnlineEnum.error
                    ? const Color(0xFFFFF5F5)
                    : const Color(0xFFF8F8F8))),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: onlineStatus == PrinterOnlineEnum.online
              ? (isDefault ? Colors.teal.withOpacity(0.6) : Colors.teal.withOpacity(0.2))
              : (onlineStatus == PrinterOnlineEnum.error
                  ? Colors.red.withOpacity(0.4)
                  : Colors.orange.withOpacity(0.4)),
          width: isDefault ? 2 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(isDark ? 0.2 : 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primaryColor.withOpacity(isDark ? 0.2 : 0.1),
                      Colors.transparent,
                    ],
                  ),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: onlineStatus == PrinterOnlineEnum.online
                              ? [Colors.teal, Colors.teal.lighter]
                              : (onlineStatus == PrinterOnlineEnum.error
                                  ? [Colors.red, Colors.red.lighter]
                                  : [const Color(0xFF757575), const Color(0xFF9E9E9E)]),
                        ),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        printerType == PrinterTypeEnum.label
                            ? FluentIcons.tag
                            : FluentIcons.print,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  printer.name ?? '未命名打印机',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: isDark ? Colors.white : Colors.grey[160],
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'SN: ${printer.sn ?? "-"}',
                            style: TextStyle(
                              fontSize: 13,
                              color: isDark ? Colors.grey[100] : Colors.grey[130],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Tooltip(
                  message: onlineStatus == PrinterOnlineEnum.online
                      ? '打印机已连接网络，可正常接收打印任务'
                      : (onlineStatus == PrinterOnlineEnum.error
                          ? '打印机连接异常，请检查网络或设备状态'
                          : '设备未连接网络，无法接收打印任务'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: statusColor.withOpacity(0.5),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: statusColor.withOpacity(0.2),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: statusColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: statusColor.withOpacity(0.6),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          onlineStatus.labelText,
                          style: TextStyle(
                            fontSize: 14,
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (isDefault)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.teal, Colors.teal.lighter],
                      ),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.withOpacity(0.4),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(FluentIcons.starburst, size: 12, color: Colors.white),
                        const SizedBox(width: 4),
                        Text(
                          '默认打印机',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          ),
          Container(
            height: 1,
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : Colors.grey.withOpacity(0.15),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildInfoChip(
                      icon: FluentIcons.tag,
                      label: '设备类型',
                      value: printerType?.labelText ?? '-',
                      color: Colors.blue,
                      isDark: isDark,
                    ),
                    const SizedBox(width: 12),
                    _buildInfoChip(
                      icon: FluentIcons.settings,
                      label: '设备状态',
                      value: printerStatus?.labelText ?? '-',
                      color: printer.status == 1 ? Colors.green : Colors.red,
                      isDark: isDark,
                    ),
                    if (printer.lastHeartbeat != null) ...[
                      const SizedBox(width: 12),
                      _buildInfoChip(
                        icon: FluentIcons.clock,
                        label: '最后在线',
                        value: _formatHeartbeatTime(printer.lastHeartbeat!),
                        color: statusColor,
                        isDark: isDark,
                      ),
                    ],
                  ],
                ),
                if (printer.remark != null && printer.remark!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _buildInfoChip(
                    icon: FluentIcons.edit_note,
                    label: '备注',
                    value: printer.remark!,
                    color: Colors.orange,
                    isDark: isDark,
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.03)
                  : Colors.grey.withOpacity(0.05),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15)),
            ),
            child: Row(
              children: [
                _buildActionBtn(
                  FluentIcons.print,
                  '测试打印',
                  Colors.blue,
                  () => _handleTestPrint(printer),
                ),
                const SizedBox(width: 10),
                if (!isDefault)
                  _buildActionBtn(
                    FluentIcons.starburst,
                    '设为默认',
                    Colors.orange,
                    () => _handleSetDefault(printer),
                    isUpdating: isUpdating,
                  ),
                if (!isDefault) const SizedBox(width: 10),
                _buildActionBtn(
                  FluentIcons.edit,
                  '编辑',
                  Colors.teal,
                  () => _handleEdit(printer),
                ),
                const SizedBox(width: 10),
                _buildActionBtn(
                  FluentIcons.delete,
                  '解绑',
                  Colors.red,
                  () => _handleDelete(printer),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.grey[100] : Colors.grey[120],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.grey[160],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildActionBtn(
    IconData icon,
    String label,
    Color color,
    VoidCallback? onTap, {
    bool isUpdating = false,
  }) {
    final isDisabled = onTap == null || isUpdating;
    return HoverButton(
      onPressed: isDisabled ? null : onTap,
      builder: (context, states) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: states.isHovered ? color.withOpacity(0.15) : color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withOpacity(states.isHovered ? 0.4 : 0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isUpdating)
                SizedBox(
                  width: 12,
                  height: 12,
                  child: ProgressRing(strokeWidth: 2),
                )
              else
                Icon(icon, size: 12, color: color),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  String _formatHeartbeatTime(String heartbeatStr) {
    try {
      DateTime? heartbeat;
      try {
        heartbeat = DateTime.parse(heartbeatStr);
      } catch (_) {
        return heartbeatStr;
      }
      final now = DateTime.now();
      final diff = now.difference(heartbeat);
      if (diff.isNegative) {
        return '刚刚';
      }
      if (diff.inSeconds < 60) {
        return '刚刚';
      } else if (diff.inMinutes < 60) {
        return '${diff.inMinutes}分钟前';
      } else if (diff.inHours < 24) {
        return '${diff.inHours}小时前';
      } else if (diff.inDays < 30) {
        return '${diff.inDays}天前';
      } else {
        return '${(diff.inDays / 30).floor()}个月前';
      }
    } catch (e) {
      return heartbeatStr;
    }
  }
}