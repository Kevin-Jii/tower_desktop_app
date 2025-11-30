import 'package:fluent_ui/fluent_ui.dart';
import '../../theme/app_theme.dart';

/// 样式化页面头部组件
class StyledPageHeader extends StatelessWidget {
  /// 页面标题
  final String title;
  
  /// 副标题
  final String? subtitle;
  
  /// 图标
  final IconData? icon;
  
  /// 右侧操作区域
  final List<Widget>? actions;
  
  /// 图标渐变色
  final List<Color>? iconGradient;
  
  /// 是否显示底部边框
  final bool showBorder;

  const StyledPageHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.actions,
    this.iconGradient,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final gradient = iconGradient ?? AppTheme.gradientBlue;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
        border: showBorder
            ? Border(
                bottom: BorderSide(
                  color: theme.resources.dividerStrokeColorDefault,
                ),
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // 图标区域
          if (icon != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradient,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: gradient.first.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                icon,
                size: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16),
          ],
          
          // 标题区域
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: theme.typography.subtitle?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: theme.typography.caption?.copyWith(
                      color: isDark ? Colors.grey[100] : AppTheme.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          // 操作区域
          if (actions != null && actions!.isNotEmpty) ...[
            const SizedBox(width: 16),
            ...actions!.map((action) => Padding(
              padding: const EdgeInsets.only(left: 8),
              child: action,
            )),
          ],
        ],
      ),
    );
  }
}

/// 带渐变的添加按钮
class GradientAddButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final List<Color>? gradientColors;

  const GradientAddButton({
    super.key,
    required this.label,
    this.onPressed,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    final colors = gradientColors ?? AppTheme.gradientBlue;
    
    return MouseRegion(
      cursor: onPressed != null 
          ? SystemMouseCursors.click 
          : SystemMouseCursors.forbidden,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: onPressed != null 
                  ? colors 
                  : colors.map((c) => c.withOpacity(0.5)).toList(),
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: onPressed != null
                ? [
                    BoxShadow(
                      color: colors.first.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(FluentIcons.add, size: 16, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
