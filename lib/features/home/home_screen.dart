import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../auth/login_screen.dart';
import '../auth/session_manager.dart';
import '../auth/models.dart';
import '../menu/menu_provider.dart';
import 'widgets/menu_content.dart';
import '../../core/widgets/custom_window_title_bar.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/fluent_theme_provider.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<NavigationPaneItem>? _cachedNavItems;
  List<dynamic>? _lastMenuTree; 
  List<NavigationPaneItem> _getNavigationItems(MenuProvider mp) {
    if (_cachedNavItems != null && identical(mp.tree, _lastMenuTree)) {
      return _cachedNavItems!;
    }
    _lastMenuTree = mp.tree;
    _cachedNavItems = _buildNavigationItems(mp);
    return _cachedNavItems!;
  }
  void _handleLogout() {
    SessionManager().clear(persist: true);
    Navigator.of(context).pushAndRemoveUntil(
        FluentPageRoute(builder: (_) => const LoginScreen()), (_) => false);
  }
  @override
  Widget build(BuildContext context) {
    final mp = context.watch<MenuProvider>();
    final user = SessionManager().userInfo;
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    const selectedBgColor = Color.fromRGBO(59, 130, 246, 0.15);
    const selectedBgColorDark = Color.fromRGBO(59, 130, 246, 0.25);
    const selectedTextColor = Color.fromRGBO(59, 130, 246, 1.0);
    final customPaneTheme = NavigationPaneThemeData(
      backgroundColor: isDark ? const Color(0xFF2D2D2D) : Colors.white,
      highlightColor: isDark ? selectedBgColorDark : selectedBgColor,
      tileColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return isDark ? selectedBgColorDark : selectedBgColor;
        }
        if (states.contains(WidgetState.hovered)) {
          return isDark 
              ? Colors.grey[150].withOpacity(0.1)
              : Colors.grey[30];
        }
        return Colors.transparent;
      }),
      selectedTextStyle: WidgetStateProperty.all(
        const TextStyle(
          color: Color.fromRGBO(59, 130, 246, 1.0),  
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
      unselectedTextStyle: WidgetStateProperty.all(
        TextStyle(
          color: isDark ? Colors.white : const Color(0xFF333333),
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
      ),
      selectedIconColor: WidgetStateProperty.all(
        const Color.fromRGBO(59, 130, 246, 1.0),  
      ),
      unselectedIconColor: WidgetStateProperty.all(
        isDark ? Colors.grey[100] : const Color(0xFF666666)
      ),
      labelPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      iconPadding: const EdgeInsets.only(left: 12, right: 8),
    );
    final customTheme = theme.copyWith(
      navigationPaneTheme: customPaneTheme,
      accentColor: AccentColor.swatch({
        'normal': const Color.fromRGBO(59, 130, 246, 1.0),
      }),
    );
    return FluentTheme(
      data: customTheme,
      child: NavigationView(
        appBar: NavigationAppBar(
          automaticallyImplyLeading: false,
          title: const CustomWindowTitleBar(),
          height: 32,
        ),
        paneBodyBuilder: (item, child) {
          return child ?? const SizedBox.shrink();
        },
        pane: NavigationPane(
          leading: _buildPaneHeader(theme, user),
          selected: _selectedIndex,
          onChanged: (index) {
            setState(() => _selectedIndex = index);
          },
          displayMode: PaneDisplayMode.auto,
          indicator: const StickyNavigationIndicator(
            color: Color.fromRGBO(59, 130, 246, 1.0),
          ),
          items: _getNavigationItems(mp),
          autoSuggestBoxReplacement: const Icon(FluentIcons.search),
          footerItems: [
            PaneItemSeparator(),
            PaneItem(
              icon: const Icon(FluentIcons.settings),
              title: const Text('设置'),
              body: ScaffoldPage(
                padding: EdgeInsets.zero,
                content: _buildSettingsPage(),
              ),
            ),
          ],
        ),
      ),
    );
  }
  List<NavigationPaneItem> _buildNavigationItems(MenuProvider mp) {
    final List<NavigationPaneItem> items = [];
    for (var topMenu in mp.tree) {
      if (topMenu.type == 1) {
        items.add(PaneItemHeader(
          header: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),  
            child: Text(
              topMenu.title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xFF666666),
              ),
            ),
          ),
        ));
        if (topMenu.children.isNotEmpty) {
          for (var child in topMenu.children) {
            if (child.type == 2) {
              items.add(PaneItem(
                icon: _getMenuIcon(child.icon),
                title: Text(child.title),
                body: ScaffoldPage(
                  padding: EdgeInsets.zero,
                  content: MenuContent(menuItem: child),
                ),
                onTap: () {
                  mp.select(child);
                },
              ));
            }
          }
        }
      } else if (topMenu.type == 2) {
        items.add(PaneItem(
          icon: _getMenuIcon(topMenu.icon),
          title: Text(topMenu.title),
          body: ScaffoldPage(
            padding: EdgeInsets.zero,
            content: MenuContent(menuItem: topMenu),
          ),
          onTap: () {
            mp.select(topMenu);
          },
        ));
      }
    }
    return items;
  }
  Icon _getMenuIcon(String? iconName) {
    switch (iconName) {
      case 'dashboard':
      case 'home':
        return const Icon(FluentIcons.home);
      case 'food':
      case 'restaurant':
        return const Icon(FluentIcons.breakfast);
      case 'file-paste':
      case 'clipboard':
        return const Icon(FluentIcons.clipboard_list);
      case 'chart':
      case 'chart-bar':
        return const Icon(FluentIcons.chart);
      case 'shop':
      case 'store':
        return const Icon(FluentIcons.shop);
      case 'user':
      case 'people':
        return const Icon(FluentIcons.people);
      case 'usergroup':
      case 'permissions':
        return const Icon(FluentIcons.permissions);
      case 'menu':
      case 'menu-fold':
        return const Icon(FluentIcons.list);
      case 'setting':
      case 'settings':
        return const Icon(FluentIcons.settings);
      case 'link':
      case 'robot':
        return const Icon(FluentIcons.robot);
      case 'view-list':
        return const Icon(FluentIcons.bulleted_list);
      default:
        return const Icon(FluentIcons.page);
    }
  }
  Widget _buildUserMenu(UserInfo? user) {
    final displayName = user?.nickname.isNotEmpty == true
        ? user!.nickname
        : (user?.username.isNotEmpty == true ? user!.username : '未知用户');
    return DropDownButton(
        leading: CircleAvatar(
          radius: 16,
          backgroundColor: const Color.fromRGBO(59, 130, 246, 1.0),
          child: Text(
            displayName.substring(0, 1),
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
        title: Text(displayName),
        items: [
          MenuFlyoutItem(
            leading: const Icon(FluentIcons.contact_info),
            text: const Text('个人信息'),
            onPressed: () {
            },
          ),
          MenuFlyoutItem(
            leading: const Icon(FluentIcons.settings),
            text: const Text('设置'),
            onPressed: () {
            },
          ),
          const MenuFlyoutSeparator(),
          MenuFlyoutItem(
            leading: const Icon(FluentIcons.sign_out),
            text: const Text('退出登录'),
            onPressed: _handleLogout,
          ),
        ],
    );
  }
  Widget _buildPaneHeader(FluentThemeData theme, UserInfo? user) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.accentColor.withOpacity(0.06),  
            Colors.transparent,
          ],
        ),
        border: Border(
          bottom: BorderSide(
            color: theme.resources.dividerStrokeColorDefault,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      theme.accentColor,
                      theme.accentColor.withOpacity(0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: theme.accentColor.withOpacity(0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  FluentIcons.app_icon_default,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  AppTexts.appName,
                  style: theme.typography.body?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildUserMenu(user),
        ],
      ),
    );
  }
  Widget _buildUserInfoCard(FluentThemeData theme, bool isDark, UserInfo? user) {
    final displayName = user?.nickname.isNotEmpty == true
        ? user!.nickname
        : (user?.username.isNotEmpty == true ? user!.username : '未知用户');
    final roleName = user?.role?.name ?? '未分配角色';
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [const Color(0xFF2D3748), const Color(0xFF1A202C)]
              : [Colors.white, const Color(0xFFF7FAFC)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.grey[100].withOpacity(0.2) : Colors.grey[40]!,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue, Colors.blue.lighter],
              ),
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                displayName.isNotEmpty ? displayName.substring(0, 1).toUpperCase() : '?',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      displayName,
                      style: theme.typography.subtitle?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.teal.withOpacity(0.2), Colors.teal.withOpacity(0.1)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.teal.withOpacity(0.3)),
                      ),
                      child: Text(
                        roleName,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.teal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 20,
                  runSpacing: 8,
                  children: [
                    if (user?.phone.isNotEmpty == true)
                      _buildInfoItem(FluentIcons.phone, user!.phone, isDark),
                    if (user?.email.isNotEmpty == true)
                      _buildInfoItem(FluentIcons.mail, user!.email, isDark),
                    if (user?.username.isNotEmpty == true && user?.username != displayName)
                      _buildInfoItem(FluentIcons.contact, user!.username, isDark),
                  ],
                ),
                if (user?.lastLoginAt.isNotEmpty == true) ...[
                  const SizedBox(height: 8),
                  Text(
                    '上次登录: ${user!.lastLoginAt}',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.grey[100] : Colors.grey[130],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildInfoItem(IconData icon, String text, bool isDark) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: isDark ? Colors.grey[100] : Colors.grey[130]),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: isDark ? Colors.grey[80] : Colors.grey[140],
          ),
        ),
      ],
    );
  }
  Widget _buildSettingsPage() {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final user = SessionManager().userInfo;
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.blue.lighter],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  FluentIcons.settings,
                  size: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '设置',
                    style: theme.typography.title?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '系统设置和个性化配置',
                    style: theme.typography.caption?.copyWith(
                      color: isDark ? Colors.grey[100] : Colors.grey[130],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildUserInfoCard(theme, isDark, user),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
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
                    Icon(FluentIcons.color, size: 20, color: Colors.blue),
                    const SizedBox(width: 12),
                    Text(
                      '主题模式',
                      style: FluentTheme.of(context).typography.subtitle?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Consumer<FluentThemeProvider>(
                  builder: (context, themeProvider, _) {
                    return Row(
                      children: [
                        Expanded(
                          child: RadioButton(
                            checked: themeProvider.mode == ThemeMode.light,
                            onChanged: (value) {
                              if (value == true) {
                                themeProvider.setThemeMode(ThemeMode.light);
                              }
                            },
                            content: Row(
                              children: [
                                Icon(FluentIcons.sunny, size: 16, color: Colors.orange),
                                const SizedBox(width: 8),
                                const Text('浅色模式 (Light)'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: RadioButton(
                            checked: themeProvider.mode == ThemeMode.dark,
                            onChanged: (value) {
                              if (value == true) {
                                themeProvider.setThemeMode(ThemeMode.dark);
                              }
                            },
                            content: Row(
                              children: [
                                Icon(FluentIcons.clear_night, size: 16, color: Colors.blue),
                                const SizedBox(width: 8),
                                const Text('深色模式 (Dark)'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
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
                    Icon(FluentIcons.sign_out, size: 20, color: Colors.red),
                    const SizedBox(width: 12),
                    Text(
                      '账户操作',
                      style: theme.typography.subtitle?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: _handleLogout,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.red),
                    padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(FluentIcons.sign_out, size: 16),
                      SizedBox(width: 8),
                      Text('退出登录'),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '退出后需要重新登录才能访问系统',
                  style: theme.typography.caption?.copyWith(
                    color: isDark ? Colors.grey[100] : Colors.grey[130],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}