import 'package:fluent_ui/fluent_ui.dart';
import '../../theme/app_theme.dart';

/// 样式化头像组件
/// 支持渐变背景、阴影效果和可选角标
class StyledAvatar extends StatelessWidget {
  /// 显示的名称（取首字母）
  final String name;
  
  /// 头像大小
  final double size;
  
  /// 渐变颜色（默认使用蓝色渐变）
  final List<Color>? gradientColors;
  
  /// 是否显示角标
  final bool showBadge;
  
  /// 角标文本（如 👑）
  final String? badgeText;
  
  /// 角标背景渐变色
  final List<Color>? badgeGradient;

  const StyledAvatar({
    super.key,
    required this.name,
    this.size = 48,
    this.gradientColors,
    this.showBadge = false,
    this.badgeText,
    this.badgeGradient,
  });

  @override
  Widget build(BuildContext context) {
    final colors = gradientColors ?? AppTheme.gradientBlue;
    final initial = name.isNotEmpty ? name.substring(0, 1).toUpperCase() : '?';
    
    return SizedBox(
      width: size + (showBadge ? 8 : 0),
      height: size + (showBadge ? 8 : 0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 主头像
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: colors,
              ),
              boxShadow: [
                BoxShadow(
                  color: colors.first.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                initial,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size * 0.4,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          
          // 角标
          if (showBadge && badgeText != null)
            Positioned(
              right: -2,
              top: -2,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: badgeGradient ?? AppTheme.gradientOrange,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  badgeText!,
                  style: TextStyle(
                    fontSize: size * 0.25,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// 预设的头像样式
class AvatarPresets {
  static List<Color> get admin => AppTheme.gradientOrange;
  static List<Color> get user => AppTheme.gradientBlue;
  static List<Color> get manager => AppTheme.gradientPurple;
  static List<Color> get guest => [const Color(0xFF9CA3AF), const Color(0xFF6B7280)];
}
