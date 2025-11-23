import 'package:fluent_ui/fluent_ui.dart';

/// 应用主题配置
class AppTheme {
  // 主色调
  static const primaryColor = Color(0xFF0078D4); // 微软蓝
  static const secondaryColor = Color(0xFF6B69D6); // 紫色
  static const accentColor = Color(0xFF00B7C3); // 青色
  
  // 渐变色
  static const gradientBlue = [Color(0xFF0078D4), Color(0xFF00B7C3)];
  static const gradientPurple = [Color(0xFF6B69D6), Color(0xFF9B51E0)];
  static const gradientOrange = [Color(0xFFFF6B35), Color(0xFFFF9F1C)];
  static const gradientGreen = [Color(0xFF00C9A7), Color(0xFF00E676)];
  static const gradientRed = [Color(0xFFE63946), Color(0xFFFF6B6B)];
  
  // 背景色
  static const backgroundColor = Color(0xFFF5F7FA);
  static const cardBackground = Colors.white;
  static const headerBackground = Color(0xFFFAFBFC);
  
  // 文字颜色
  static const textPrimary = Color(0xFF1A1A1A);
  static const textSecondary = Color(0xFF666666);
  static const textTertiary = Color(0xFF999999);
  
  // 边框颜色
  static const borderColor = Color(0xFFE5E7EB);
  static const dividerColor = Color(0xFFF0F0F0);
  
  // 阴影
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];
  
  static List<BoxShadow> hoverShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.12),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];
  
  static List<BoxShadow> buttonShadow = [
    BoxShadow(
      color: primaryColor.withOpacity(0.3),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];
  
  // 圆角
  static const radiusSmall = 8.0;
  static const radiusMedium = 12.0;
  static const radiusLarge = 16.0;
  static const radiusXLarge = 20.0;
  
  // 间距
  static const spacingXSmall = 4.0;
  static const spacingSmall = 8.0;
  static const spacingMedium = 16.0;
  static const spacingLarge = 24.0;
  static const spacingXLarge = 32.0;
  
  // 渐变背景
  static LinearGradient primaryGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: gradientBlue,
  );
  
  static LinearGradient secondaryGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: gradientPurple,
  );
  
  static LinearGradient accentGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: gradientOrange,
  );
  
  static LinearGradient successGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: gradientGreen,
  );
  
  static LinearGradient dangerGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: gradientRed,
  );
  
  // 卡片装饰
  static BoxDecoration cardDecoration = BoxDecoration(
    color: cardBackground,
    borderRadius: BorderRadius.circular(radiusMedium),
    boxShadow: cardShadow,
    border: Border.all(color: borderColor, width: 1),
  );
  
  static BoxDecoration gradientCardDecoration(List<Color> colors) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: colors,
      ),
      borderRadius: BorderRadius.circular(radiusMedium),
      boxShadow: cardShadow,
    );
  }
  
  // 标题样式
  static const titleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textPrimary,
    height: 1.2,
  );
  
  static const subtitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    height: 1.3,
  );
  
  static const bodyStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: textSecondary,
    height: 1.5,
  );
  
  static const captionStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: textTertiary,
    height: 1.4,
  );
}
