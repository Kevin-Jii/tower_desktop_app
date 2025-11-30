import 'package:fluent_ui/fluent_ui.dart';
import '../../theme/app_theme.dart';

/// 操作按钮样式
enum ActionButtonStyle {
  primary,    // 蓝色填充
  secondary,  // 灰色填充
  danger,     // 红色填充
  outline,    // 边框样式
  outlinePrimary,  // 蓝色边框
  outlineDanger,   // 红色边框
}

/// 操作按钮数据
class ActionButtonData {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final ActionButtonStyle style;
  final String? tooltip;

  const ActionButtonData({
    required this.label,
    this.icon,
    this.onPressed,
    this.style = ActionButtonStyle.outline,
    this.tooltip,
  });
}

/// 操作按钮组组件
class ActionButtonGroup extends StatelessWidget {
  final List<ActionButtonData> buttons;
  final bool disabled;
  final Axis direction;
  final double spacing;
  final MainAxisSize mainAxisSize;

  const ActionButtonGroup({
    super.key,
    required this.buttons,
    this.disabled = false,
    this.direction = Axis.horizontal,
    this.spacing = 8,
    this.mainAxisSize = MainAxisSize.min,
  });

  @override
  Widget build(BuildContext context) {
    final children = buttons.map((btn) => _buildButton(context, btn)).toList();
    
    if (direction == Axis.horizontal) {
      return Opacity(
        opacity: disabled ? 0.5 : 1.0,
        child: Row(
          mainAxisSize: mainAxisSize,
          children: _addSpacing(children),
        ),
      );
    } else {
      return Opacity(
        opacity: disabled ? 0.5 : 1.0,
        child: Column(
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _addSpacing(children),
        ),
      );
    }
  }

  List<Widget> _addSpacing(List<Widget> children) {
    final result = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      result.add(children[i]);
      if (i < children.length - 1) {
        result.add(SizedBox(
          width: direction == Axis.horizontal ? spacing : 0,
          height: direction == Axis.vertical ? spacing : 0,
        ));
      }
    }
    return result;
  }

  Widget _buildButton(BuildContext context, ActionButtonData data) {
    final onPressed = disabled ? null : data.onPressed;
    
    Widget button;
    switch (data.style) {
      case ActionButtonStyle.primary:
        button = FilledButton(
          onPressed: onPressed,
          child: _buildButtonContent(data),
        );
        break;
      case ActionButtonStyle.secondary:
        button = Button(
          onPressed: onPressed,
          child: _buildButtonContent(data),
        );
        break;
      case ActionButtonStyle.danger:
        button = FilledButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.red),
          ),
          child: _buildButtonContent(data),
        );
        break;
      case ActionButtonStyle.outline:
        button = Button(
          onPressed: onPressed,
          child: _buildButtonContent(data),
        );
        break;
      case ActionButtonStyle.outlinePrimary:
        button = _buildOutlineButton(
          onPressed: onPressed,
          color: AppTheme.primaryColor,
          child: _buildButtonContent(data, color: AppTheme.primaryColor),
        );
        break;
      case ActionButtonStyle.outlineDanger:
        button = _buildOutlineButton(
          onPressed: onPressed,
          color: Colors.red,
          child: _buildButtonContent(data, color: Colors.red),
        );
        break;
    }

    if (data.tooltip != null) {
      return Tooltip(
        message: data.tooltip!,
        child: button,
      );
    }
    return button;
  }

  Widget _buildButtonContent(ActionButtonData data, {Color? color}) {
    if (data.icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(data.icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(data.label, style: color != null ? TextStyle(color: color) : null),
        ],
      );
    }
    return Text(data.label, style: color != null ? TextStyle(color: color) : null);
  }

  Widget _buildOutlineButton({
    required VoidCallback? onPressed,
    required Color color,
    required Widget child,
  }) {
    return Button(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return color.withOpacity(0.1);
          }
          return Colors.transparent;
        }),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: BorderSide(color: color),
          ),
        ),
      ),
      child: child,
    );
  }
}

/// 单个样式化按钮
class StyledButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final ActionButtonStyle style;
  final bool disabled;

  const StyledButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.style = ActionButtonStyle.outline,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return ActionButtonGroup(
      buttons: [
        ActionButtonData(
          label: label,
          icon: icon,
          onPressed: onPressed,
          style: style,
        ),
      ],
      disabled: disabled,
    );
  }
}


