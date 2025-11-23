import 'package:fluent_ui/fluent_ui.dart';

/// 主要按钮（替代 TDButton primary）
class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final IconData? icon;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return FilledButton(
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16),
            const SizedBox(width: 8),
            child,
          ],
        ),
      );
    }
    return FilledButton(
      onPressed: onPressed,
      child: child,
    );
  }
}

/// 次要按钮（替代 TDButton default）
class SecondaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final IconData? icon;

  const SecondaryButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return Button(
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16),
            const SizedBox(width: 8),
            child,
          ],
        ),
      );
    }
    return Button(
      onPressed: onPressed,
      child: child,
    );
  }
}

/// 危险按钮（用于删除等操作）
class DangerButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final IconData? icon;

  const DangerButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: ButtonState.all(Colors.red),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16),
            const SizedBox(width: 8),
            child,
          ],
        ),
      );
    }
    return FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: ButtonState.all(Colors.red),
      ),
      child: child,
    );
  }
}
