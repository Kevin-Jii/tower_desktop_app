import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show Icons;
import 'package:provider/provider.dart';
import 'package:tower_desktop_app/core/constants/ui_texts.dart';
import 'auth_api.dart';
import 'credential_storage.dart';
import 'models.dart';
import 'session_manager.dart';
import '../menu/menu_api.dart';
import '../menu/menu_provider.dart';
import 'permission_provider.dart';
import '../home/home_screen.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widgets/custom_window_title_bar.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _phoneCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();
  bool _loading = false;
  bool _obscurePassword = true;
  bool _remember = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
    CredentialStorage().read().then((value) {
      final (acc, pwd, remember) = value;
      if (!mounted) return;
      setState(() {
        if (acc != null) _phoneCtrl.text = acc;
        if (pwd != null) _pwdCtrl.text = pwd;
        _remember = remember;
      });
    });
  }
  @override
  void dispose() {
    _phoneCtrl.dispose();
    _pwdCtrl.dispose();
    _animationController.dispose();
    super.dispose();
  }
  Future<void> _doLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() => _loading = true);
    try {
      final authApi = AuthApi();
      final resp = await authApi.login(
          LoginRequest(phone: _phoneCtrl.text.trim(), password: _pwdCtrl.text));
      final menuApi = MenuApi();
      final perms = await menuApi.getUserPermissions();
      final permProvider = context.read<PermissionProvider>();
      permProvider.setPermissions(perms);
      SessionManager().updateSession(
          token: resp.token,
          userInfo: resp.userInfo,
          permissions: perms,
          expiresIn: resp.expiresIn == 0 ? null : resp.expiresIn);
      if (!mounted) return;
      final menuProvider = context.read<MenuProvider>();
      await menuProvider.load(permissionProvider: permProvider);
      if (!mounted) return;
      Navigator.of(context)
          .pushReplacement(FluentPageRoute(builder: (_) => const HomeScreen()));
      if (_remember) {
        await CredentialStorage()
            .save(account: _phoneCtrl.text.trim(), password: _pwdCtrl.text);
      } else {
        await CredentialStorage().clear();
      }
    } catch (e) {
      if (!mounted) return;
      await displayInfoBar(context, builder: (context, close) {
        return InfoBar(
          title: const Text('登录失败'),
          content: Text(e.toString()),
          severity: InfoBarSeverity.error,
          onClose: close,
        );
      });
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Column(
        children: [
          const CustomWindowTitleBar(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue.lightest,
                    Colors.purple.lightest,
                    Colors.magenta.lightest,
                  ],
                ),
              ),
              child: Center(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isMobile ? screenWidth * 0.9 : 1000,
                      maxHeight: isMobile ? double.infinity : 700,
                    ),
                    child: Card(
                      borderRadius: BorderRadius.circular(24),
                      child: isMobile
                          ? _buildMobileLayout()
                          : _buildDesktopLayout(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildBrandingSection(compact: true),
          const SizedBox(height: 32),
          _buildLoginForm(),
        ],
      ),
    );
  }
  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.blue.dark],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 48, 40, 40),
              child: _buildBrandingSection(),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 48),
            child: SingleChildScrollView(
              child: _buildLoginForm(),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildBrandingSection({bool compact = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: compact ? 46 : 54,
              height: compact ? 46 : 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.15),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: Icon(FluentIcons.shop,
                  size: compact ? 30 : 34, color: Colors.blue),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppTexts.appName,
                    style: TextStyle(
                      fontSize: compact ? 18 : 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppTexts.defaultStoreName,
                    style: TextStyle(
                      fontSize: compact ? 11 : 12,
                      color: Colors.white.withOpacity(.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 28),
        Text(
          '智能化餐饮管理平台',
          style: TextStyle(
            fontSize: compact ? 16 : 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '聚合门店 · 人员 · 菜品 · 库存 · 经营数据\n助力高效决策与增长',
          style: TextStyle(
            fontSize: compact ? 12 : 13.5,
            height: 1.5,
            color: Colors.white.withOpacity(.90),
          ),
        ),
        if (!compact) ...[
          const SizedBox(height: 36),
          _buildFeaturesList(),
        ],
        const Spacer(),
        if (!compact)
          Opacity(
            opacity: .85,
            child: Text(
              '© 2025 Tower Suite\nAll Rights Reserved',
              style: TextStyle(
                fontSize: 11,
                height: 1.4,
                color: Colors.white.withOpacity(.85),
              ),
            ),
          ),
      ],
    );
  }
  Widget _buildFeaturesList() {
    final features = [
      {'icon': FluentIcons.product_variant, 'text': '库存管理'},
      {'icon': FluentIcons.people, 'text': '员工管理'},
      {'icon': FluentIcons.chart_series, 'text': '数据分析'},
      {'icon': FluentIcons.shop, 'text': '多门店支持'},
    ];
    return Column(
      children: features.map((feature) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Icon(
                feature['icon'] as IconData,
                color: Colors.white,
                size: 24,
              ),
              const SizedBox(width: 16),
              Text(
                feature['text'] as String,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            UITexts.loginWelcome,
            style: FluentTheme.of(context).typography.title,
          ),
          const SizedBox(height: 8),
          Text(
            UITexts.loginSubtitle,
            style: FluentTheme.of(context).typography.body,
          ),
          const SizedBox(height: 40),
          InfoLabel(
            label: '手机号',
            child: TextBox(
              controller: _phoneCtrl,
              placeholder: '请输入11位手机号',
              prefix: const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(FluentIcons.phone),
              ),
            ),
          ),
          const SizedBox(height: 20),
          InfoLabel(
            label: '密码',
            child: Stack(
              children: [
                TextBox(
                  controller: _pwdCtrl,
                  placeholder: '请输入密码',
                  obscureText: _obscurePassword,
                  prefix: const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(FluentIcons.lock),
                  ),
                  suffix: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                        child: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Checkbox(
                checked: _remember,
                onChanged: (v) => setState(() => _remember = v ?? false),
                content: const Text(UITexts.loginRemember),
              ),
              const Spacer(),
              HyperlinkButton(
                onPressed: () {
                  displayInfoBar(context, builder: (context, close) {
                    return InfoBar(
                      title: const Text('提示'),
                      content: const Text(UITexts.loginForgotHint),
                      onClose: close,
                    );
                  });
                },
                child: const Text('忘记密码?'),
              ),
            ],
          ),
          const SizedBox(height: 28),
          FilledButton(
            onPressed: _loading ? null : _doLogin,
            child: _loading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: ProgressRing(strokeWidth: 2),
                  )
                : const Text(
                    UITexts.loginButton,
                    style: TextStyle(fontSize: 16),
                  ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(
              UITexts.loginVersion,
              style: FluentTheme.of(context).typography.caption,
            ),
          ),
        ],
      ),
    );
  }
}
