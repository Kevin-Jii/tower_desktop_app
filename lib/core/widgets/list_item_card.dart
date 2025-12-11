import 'package:fluent_ui/fluent_ui.dart';
class ListItemCard extends StatelessWidget {
  final IconData icon;
  final AccentColor iconColor;
  final String title;
  final String? subtitle;
  final String? description;
  final bool isEnabled;
  final ValueChanged<bool>? onStatusChanged;
  final List<ListItemAction> actions;
  final Widget? trailing;
  final bool showStatusTag;
  final String enabledText;
  final String disabledText;
  ListItemCard({
    super.key,
    required this.icon,
    AccentColor? iconColor,
    required this.title,
    this.subtitle,
    this.description,
    this.isEnabled = true,
    this.onStatusChanged,
    this.actions = const [],
    this.trailing,
    this.showStatusTag = true,
    this.enabledText = '已启用',
    this.disabledText = '已禁用',
  }) : iconColor = iconColor ?? Colors.blue;
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return HoverButton(
      onPressed: () {}, 
      cursor: SystemMouseCursors.basic,
      builder: (context, states) {
        final backgroundColor = isDark
            ? (states.isHovered ? const Color(0xFF383838) : const Color(0xFF2D2D2D))
            : (states.isHovered ? Colors.white : Colors.white); 
        final List<BoxShadow> shadows = isDark || !isEnabled
            ? [] 
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(states.isHovered ? 0.08 : 0.04), 
                  offset: const Offset(0, 4),
                  blurRadius: 12,
                  spreadRadius: 0,
                ),
              ];
        return Container(
          margin: const EdgeInsets.only(bottom: 16), 
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12), 
            boxShadow: shadows,
            border: Border.all(
              color: isDark ? Colors.grey[160] : Colors.grey[20], 
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(20), 
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: [
              _buildGradientIcon(isDark),
              const SizedBox(width: 20),
              Expanded(child: _buildContent(context, isDark)),
              const SizedBox(width: 24),
              _buildRightArea(context, isDark),
            ],
          ),
        );
      },
    );
  }
  Widget _buildGradientIcon(bool isDark) {
    final startColor = isEnabled ? iconColor.lighter : Colors.grey[100];
    final endColor = isEnabled ? iconColor.dark : Colors.grey[120];
    return Container(
      width: 56, 
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [startColor, endColor],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: isEnabled ? [
          BoxShadow(
            color: iconColor.withOpacity(0.3), 
            offset: const Offset(0, 4),
            blurRadius: 10,
          )
        ] : [],
      ),
      child: Center(
        child: Icon(
          icon, 
          color: Colors.white, 
          size: 28,
        ),
      ),
    );
  }
  Widget _buildContent(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
              ),
            ),
            if (showStatusTag) ...[
              const SizedBox(width: 12),
              _buildPillTag(), 
            ],
          ],
        ),
        if (subtitle != null && subtitle!.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.grey[80] : Colors.grey[120],
            ),
          ),
        ],
        if (description != null && description!.isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(
            description!,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.grey[100] : Colors.grey[100], 
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
  Widget _buildPillTag() {
    final color = isEnabled ? Colors.green : Colors.grey;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1), 
        borderRadius: BorderRadius.circular(20), 
        border: Border.all(color: color.withOpacity(0.2)), 
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6, 
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            isEnabled ? enabledText : disabledText,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildRightArea(BuildContext context, bool isDark) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (actions.isNotEmpty) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[160] : Colors.grey[20], 
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions.asMap().entries.map((entry) {
                final index = entry.key;
                final action = entry.value;
                return Row(
                  children: [
                    if (index > 0) 
                      Container(width: 1, height: 14, color: Colors.grey[40], margin: const EdgeInsets.symmetric(horizontal: 4)),
                    Tooltip(
                      message: action.tooltip ?? action.label,
                      child: IconButton(
                        icon: Icon(
                          action.icon, 
                          size: 16, 
                          color: action.color ?? (isDark ? Colors.white : Colors.grey[140])
                        ),
                        onPressed: action.onPressed,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
        if (trailing != null) ...[
          const SizedBox(width: 16),
          trailing!,
        ],
        if (onStatusChanged != null) ...[
          const SizedBox(width: 20),
          ToggleSwitch(
            checked: isEnabled,
            onChanged: onStatusChanged,
          ),
        ],
      ],
    );
  }
}
class ListItemAction {
  final IconData icon;
  final String label;
  final String? tooltip;
  final Color? color;
  final VoidCallback? onPressed;
  const ListItemAction({
    required this.icon,
    required this.label,
    this.tooltip,
    this.color,
    this.onPressed,
  });
}