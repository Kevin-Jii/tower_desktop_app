import 'package:fluent_ui/fluent_ui.dart';
import '../../theme/app_theme.dart';

/// 信息行组件
/// 用于显示 图标 + 标签 + 值 的布局
class InfoRow extends StatelessWidget {
  /// 图标
  final IconData icon;
  
  /// 标签文本
  final String label;
  
  /// 值文本（可选）
  final String? value;
  
  /// 图标颜色
  final Color? iconColor;
  
  /// 是否紧凑模式
  final bool compact;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    this.value,
    this.iconColor,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Padding(
      padding: EdgeInsets.symmetric(vertical: compact ? 2 : 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: compact ? 14 : 16,
            color: iconColor ?? (isDark ? Colors.grey[100] : AppTheme.textTertiary),
          ),
          SizedBox(width: compact ? 6 : 8),
          if (value != null) ...[
            Text(
              '$label: ',
              style: TextStyle(
                fontSize: compact ? 12 : 13,
                color: isDark ? Colors.grey[100] : AppTheme.textTertiary,
              ),
            ),
            Flexible(
              child: Text(
                value!,
                style: TextStyle(
                  fontSize: compact ? 12 : 13,
                  color: isDark ? Colors.white : AppTheme.textSecondary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ] else
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: compact ? 12 : 13,
                  color: isDark ? Colors.white : AppTheme.textSecondary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }
}

/// 信息行列表组件
/// 用于垂直排列多个 InfoRow
class InfoRowList extends StatelessWidget {
  final List<InfoRowData> items;
  final bool compact;

  const InfoRowList({
    super.key,
    required this.items,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: items
          .where((item) => item.value != null && item.value!.isNotEmpty)
          .map((item) => InfoRow(
                icon: item.icon,
                label: item.label,
                value: item.value,
                iconColor: item.iconColor,
                compact: compact,
              ))
          .toList(),
    );
  }
}

/// InfoRow 数据模型
class InfoRowData {
  final IconData icon;
  final String label;
  final String? value;
  final Color? iconColor;

  const InfoRowData({
    required this.icon,
    required this.label,
    this.value,
    this.iconColor,
  });
}
