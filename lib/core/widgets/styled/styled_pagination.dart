import 'package:fluent_ui/fluent_ui.dart';
import '../../theme/app_theme.dart';

/// 样式化分页组件
class StyledPagination extends StatelessWidget {
  /// 当前页码（从1开始）
  final int currentPage;
  
  /// 总页数
  final int totalPages;
  
  /// 总记录数
  final int totalRecords;
  
  /// 页码变化回调
  final ValueChanged<int> onPageChanged;
  
  /// 显示的页码数量
  final int visiblePages;

  const StyledPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.totalRecords,
    required this.onPageChanged,
    this.visiblePages = 5,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
        border: Border(
          top: BorderSide(
            color: theme.resources.dividerStrokeColorDefault,
          ),
        ),
      ),
      child: Row(
        children: [
          // 总记录数
          _buildRecordsBadge(isDark),
          
          const Spacer(),
          
          // 分页控件
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 上一页
              _buildNavButton(
                icon: FluentIcons.chevron_left,
                enabled: currentPage > 1,
                onPressed: () => onPageChanged(currentPage - 1),
                isDark: isDark,
              ),
              
              const SizedBox(width: 8),
              
              // 页码按钮
              ..._buildPageButtons(isDark),
              
              const SizedBox(width: 8),
              
              // 下一页
              _buildNavButton(
                icon: FluentIcons.chevron_right,
                enabled: currentPage < totalPages,
                onPressed: () => onPageChanged(currentPage + 1),
                isDark: isDark,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecordsBadge(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isDark 
            ? Colors.grey[150].withOpacity(0.1)
            : AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        '共 $totalRecords 条记录',
        style: TextStyle(
          fontSize: 13,
          color: isDark ? Colors.grey[100] : AppTheme.textSecondary,
        ),
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required bool enabled,
    required VoidCallback onPressed,
    required bool isDark,
  }) {
    return MouseRegion(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.forbidden,
      child: GestureDetector(
        onTap: enabled ? onPressed : null,
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: enabled
                ? (isDark ? Colors.grey[150].withOpacity(0.1) : AppTheme.backgroundColor)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: enabled
                  ? (isDark ? Colors.grey[100].withOpacity(0.2) : AppTheme.borderColor)
                  : Colors.transparent,
            ),
          ),
          child: Icon(
            icon,
            size: 14,
            color: enabled
                ? (isDark ? Colors.white : AppTheme.textPrimary)
                : (isDark ? Colors.grey[100].withOpacity(0.3) : AppTheme.textTertiary),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPageButtons(bool isDark) {
    final buttons = <Widget>[];
    final pages = _calculateVisiblePages();
    
    for (int i = 0; i < pages.length; i++) {
      final page = pages[i];
      
      if (page == -1) {
        // 省略号
        buttons.add(
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            child: Text(
              '...',
              style: TextStyle(
                color: isDark ? Colors.grey[100] : AppTheme.textTertiary,
              ),
            ),
          ),
        );
      } else {
        buttons.add(_buildPageButton(page, isDark));
      }
      
      if (i < pages.length - 1) {
        buttons.add(const SizedBox(width: 4));
      }
    }
    
    return buttons;
  }

  Widget _buildPageButton(int page, bool isDark) {
    final isActive = page == currentPage;
    
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: isActive ? null : () => onPageChanged(page),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            gradient: isActive
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: AppTheme.gradientBlue,
                  )
                : null,
            color: isActive 
                ? null 
                : (isDark ? Colors.grey[150].withOpacity(0.05) : Colors.transparent),
            borderRadius: BorderRadius.circular(6),
            border: isActive
                ? null
                : Border.all(
                    color: isDark 
                        ? Colors.grey[100].withOpacity(0.1) 
                        : AppTheme.borderColor.withOpacity(0.5),
                  ),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              '$page',
              style: TextStyle(
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isActive 
                    ? Colors.white 
                    : (isDark ? Colors.white : AppTheme.textPrimary),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<int> _calculateVisiblePages() {
    if (totalPages <= visiblePages) {
      return List.generate(totalPages, (i) => i + 1);
    }
    
    final pages = <int>[];
    final half = visiblePages ~/ 2;
    
    int start = currentPage - half;
    int end = currentPage + half;
    
    if (start < 1) {
      start = 1;
      end = visiblePages;
    }
    
    if (end > totalPages) {
      end = totalPages;
      start = totalPages - visiblePages + 1;
    }
    
    // 添加第一页
    if (start > 1) {
      pages.add(1);
      if (start > 2) {
        pages.add(-1); // 省略号
      }
    }
    
    // 添加中间页码
    for (int i = start; i <= end; i++) {
      if (!pages.contains(i)) {
        pages.add(i);
      }
    }
    
    // 添加最后一页
    if (end < totalPages) {
      if (end < totalPages - 1) {
        pages.add(-1); // 省略号
      }
      pages.add(totalPages);
    }
    
    return pages;
  }
}
