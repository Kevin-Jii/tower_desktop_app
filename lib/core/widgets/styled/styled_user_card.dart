import 'package:fluent_ui/fluent_ui.dart';
import '../../../features/user/models.dart';
import '../../theme/app_theme.dart';
import 'styled_avatar.dart';
import 'info_row.dart';
import 'action_button_group.dart';

/// 样式化用户卡片组件
class StyledUserCard extends StatefulWidget {
  /// 用户数据
  final User user;
  
  /// 是否受保护（超级管理员）
  final bool isProtected;
  
  /// 编辑回调
  final VoidCallback? onEdit;
  
  /// 删除回调
  final VoidCallback? onDelete;
  
  /// 状态变化回调
  final ValueChanged<bool>? onStatusChange;

  const StyledUserCard({
    super.key,
    required this.user,
    this.isProtected = false,
    this.onEdit,
    this.onDelete,
    this.onStatusChange,
  });

  @override
  State<StyledUserCard> createState() => _StyledUserCardState();
}

class _StyledUserCardState extends State<StyledUserCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isActive = widget.user.status == 1;
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? AppTheme.primaryColor.withOpacity(0.5)
                : (isDark ? Colors.grey[100].withOpacity(0.1) : AppTheme.borderColor),
            width: _isHovered ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? AppTheme.primaryColor.withOpacity(0.1)
                  : Colors.black.withOpacity(isDark ? 0.2 : 0.05),
              blurRadius: _isHovered ? 16 : 8,
              offset: Offset(0, _isHovered ? 6 : 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 头像区域
            _buildAvatar(),
            
            const SizedBox(width: 16),
            
            // 信息区域
            Expanded(
              child: _buildInfoSection(isDark),
            ),
            
            const SizedBox(width: 16),
            
            // 操作区域
            _buildActionSection(isDark, isActive),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return StyledAvatar(
      name: widget.user.username,
      size: 52,
      gradientColors: widget.isProtected 
          ? AvatarPresets.admin 
          : AvatarPresets.user,
      showBadge: widget.isProtected,
      badgeText: widget.isProtected ? '👑' : null,
    );
  }

  Widget _buildInfoSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 用户名和标签
        Row(
          children: [
            Text(
              widget.user.username,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : AppTheme.textPrimary,
              ),
            ),
            if (widget.isProtected) ...[
              const SizedBox(width: 8),
              _buildSuperAdminBadge(),
            ],
          ],
        ),
        
        const SizedBox(height: 8),
        
        // 用户信息
        InfoRowList(
          compact: true,
          items: [
            if (widget.user.nickname?.isNotEmpty == true)
              InfoRowData(
                icon: FluentIcons.contact,
                label: '昵称',
                value: widget.user.nickname,
              ),
            InfoRowData(
              icon: FluentIcons.phone,
              label: '手机',
              value: widget.user.phone,
            ),
            if (widget.user.email?.isNotEmpty == true)
              InfoRowData(
                icon: FluentIcons.mail,
                label: '邮箱',
                value: widget.user.email,
              ),
            if (widget.user.role != null)
              InfoRowData(
                icon: FluentIcons.permissions,
                label: '角色',
                value: widget.user.role!.name,
                iconColor: AppTheme.secondaryColor,
              ),
          ],
        ),
        
        // 保护提示
        if (widget.isProtected) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  FluentIcons.shield,
                  size: 12,
                  color: Colors.orange,
                ),
                const SizedBox(width: 4),
                Text(
                  '此账号受保护，不允许编辑或删除',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSuperAdminBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B35), Color(0xFFFF9F1C)],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF6B35).withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '👑',
            style: TextStyle(fontSize: 11),
          ),
          SizedBox(width: 4),
          Text(
            '超级管理员',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionSection(bool isDark, bool isActive) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark 
            ? Colors.grey[150].withOpacity(0.05)
            : AppTheme.backgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 状态开关
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isActive ? '启用' : '禁用',
                style: TextStyle(
                  fontSize: 12,
                  color: isActive ? Colors.green : Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              ToggleSwitch(
                checked: isActive,
                onChanged: widget.isProtected 
                    ? null 
                    : widget.onStatusChange,
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // 操作按钮
          ActionButtonGroup(
            disabled: widget.isProtected,
            direction: Axis.horizontal,
            spacing: 8,
            buttons: [
              ActionButtonData(
                label: '编辑',
                icon: FluentIcons.edit,
                onPressed: widget.onEdit,
                style: ActionButtonStyle.outlinePrimary,
              ),
              ActionButtonData(
                label: '删除',
                icon: FluentIcons.delete,
                onPressed: widget.onDelete,
                style: ActionButtonStyle.outlineDanger,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
