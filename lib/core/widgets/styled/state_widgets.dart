import 'package:fluent_ui/fluent_ui.dart';
import '../../theme/app_theme.dart';

/// 加载状态组件
class LoadingState extends StatelessWidget {
  final String? message;
  final double size;

  const LoadingState({
    super.key,
    this.message,
    this.size = 32,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProgressRing(
            strokeWidth: 3,
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.grey[100] : AppTheme.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// 空状态组件
class EmptyState extends StatelessWidget {
  final String message;
  final IconData? icon;
  final Widget? action;
  final String? subtitle;

  const EmptyState({
    super.key,
    required this.message,
    this.icon,
    this.action,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark 
                  ? Colors.grey[150].withOpacity(0.1)
                  : AppTheme.backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon ?? FluentIcons.inbox,
              size: 48,
              color: isDark ? Colors.grey[100] : AppTheme.textTertiary,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : AppTheme.textPrimary,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.grey[100] : AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          if (action != null) ...[
            const SizedBox(height: 20),
            action!,
          ],
        ],
      ),
    );
  }
}

/// 错误状态组件
class ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final String? details;

  const ErrorState({
    super.key,
    required this.message,
    this.onRetry,
    this.details,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.red.withOpacity(0.1),
                  Colors.red.withOpacity(0.05),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              FluentIcons.error_badge,
              size: 48,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : AppTheme.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          if (details != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                details!,
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.grey[100] : AppTheme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
          if (onRetry != null) ...[
            const SizedBox(height: 20),
            FilledButton(
              onPressed: onRetry,
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
        ],
      ),
    );
  }
}
