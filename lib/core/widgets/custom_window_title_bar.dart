import 'package:fluent_ui/fluent_ui.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/app_constants.dart';
class CustomWindowTitleBar extends StatelessWidget {
  const CustomWindowTitleBar({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return WindowTitleBarBox(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: SvgPicture.asset(
                    'lib/core/icons/logo.svg',
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  AppTexts.appName,
                  style: theme.typography.body?.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: MoveWindow()),
          const WindowButtons(),
        ],
      ),
    );
  }
}
class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final buttonColors = WindowButtonColors(
      iconNormal: theme.inactiveColor,
      iconMouseDown: theme.inactiveColor,
      iconMouseOver: theme.inactiveColor,
      mouseOver: theme.resources.subtleFillColorSecondary,
      mouseDown: theme.resources.subtleFillColorTertiary,
    );
    final closeButtonColors = WindowButtonColors(
      iconNormal: theme.inactiveColor,
      iconMouseDown: Colors.white,
      iconMouseOver: Colors.white,
      mouseOver: Colors.red,
      mouseDown: Colors.red.dark,
    );
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}
