import 'package:fluent_ui/fluent_ui.dart';
import '../theme/app_theme.dart';

/// 页面头部组件
class PageHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final List<Color>? gradientColors;
  final List<Widget>? actions;
  final Widget? searchBar;

  const PageHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.gradientColors,
    this.actions,
    this.searchBar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingLarge),
      decoration: BoxDecoration(
        gradient: gradientColors != null
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColors!,
              )
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.headerBackground,
                  AppTheme.backgroundColor,
                ],
              ),
        border: Border(
          bottom: BorderSide(
            color: AppTheme.borderColor,
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradientColors ?? AppTheme.gradientBlue,
                    ),
                    borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                    boxShadow: AppTheme.buttonShadow,
                  ),
                  child: Icon(
                    icon,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: AppTheme.spacingMedium),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTheme.titleStyle.copyWith(
                        color: gradientColors != null
                            ? Colors.white
                            : AppTheme.textPrimary,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: AppTheme.bodyStyle.copyWith(
                          color: gradientColors != null
                              ? Colors.white.withOpacity(0.9)
                              : AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (actions != null) ...actions!,
            ],
          ),
          if (searchBar != null) ...[
            const SizedBox(height: AppTheme.spacingMedium),
            searchBar!,
          ],
        ],
      ),
    );
  }
}

/// 搜索栏组件
class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String? placeholder;
  final VoidCallback? onSearch;
  final VoidCallback? onClear;

  const SearchBar({
    super.key,
    required this.controller,
    this.placeholder,
    this.onSearch,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextBox(
              controller: controller,
              placeholder: placeholder ?? '🔍 搜索...',
              style: const TextStyle(fontSize: 14),
              onSubmitted: (_) => onSearch?.call(),
            ),
          ),
        ),
        const SizedBox(width: AppTheme.spacingSmall),
        FilledButton(
          onPressed: onSearch,
          style: ButtonStyle(
            padding: ButtonState.all(
              const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingLarge,
                vertical: 12,
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(FluentIcons.search, size: 16),
              SizedBox(width: 6),
              Text('搜索'),
            ],
          ),
        ),
        if (onClear != null) ...[
          const SizedBox(width: AppTheme.spacingSmall),
          Button(
            onPressed: onClear,
            style: ButtonStyle(
              padding: ButtonState.all(
                const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingMedium,
                  vertical: 12,
                ),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(FluentIcons.refresh, size: 16),
                SizedBox(width: 6),
                Text('重置'),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
