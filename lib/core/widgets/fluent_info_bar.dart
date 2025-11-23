import 'package:fluent_ui/fluent_ui.dart';

/// Fluent UI InfoBar 包装器，替代 TDToast 和 TDMessage
class FluentInfoBarHelper {
  /// 显示成功消息
  static Future<void> showSuccess(
    BuildContext context,
    String message, {
    String? title,
    Duration duration = const Duration(seconds: 3),
  }) async {
    await displayInfoBar(
      context,
      duration: duration,
      builder: (context, close) {
        return InfoBar(
          title: title != null ? Text(title) : const SizedBox.shrink(),
          content: Text(message),
          severity: InfoBarSeverity.success,
          onClose: close,
        );
      },
    );
  }

  /// 显示错误消息
  static Future<void> showError(
    BuildContext context,
    String message, {
    String? title,
    Duration duration = const Duration(seconds: 4),
  }) async {
    await displayInfoBar(
      context,
      duration: duration,
      builder: (context, close) {
        return InfoBar(
          title: title != null ? Text(title) : const SizedBox.shrink(),
          content: Text(message),
          severity: InfoBarSeverity.error,
          onClose: close,
        );
      },
    );
  }

  /// 显示警告消息
  static Future<void> showWarning(
    BuildContext context,
    String message, {
    String? title,
    Duration duration = const Duration(seconds: 3),
  }) async {
    await displayInfoBar(
      context,
      duration: duration,
      builder: (context, close) {
        return InfoBar(
          title: title != null ? Text(title) : const SizedBox.shrink(),
          content: Text(message),
          severity: InfoBarSeverity.warning,
          onClose: close,
        );
      },
    );
  }

  /// 显示信息消息
  static Future<void> showInfo(
    BuildContext context,
    String message, {
    String? title,
    Duration duration = const Duration(seconds: 3),
  }) async {
    await displayInfoBar(
      context,
      duration: duration,
      builder: (context, close) {
        return InfoBar(
          title: title != null ? Text(title) : const SizedBox.shrink(),
          content: Text(message),
          severity: InfoBarSeverity.info,
          onClose: close,
        );
      },
    );
  }
}
