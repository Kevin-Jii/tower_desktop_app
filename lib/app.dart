import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'core/di/service_locator.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/permission_provider.dart';
import 'features/auth/session_manager.dart';
import 'features/home/home_screen.dart' as home;
import 'features/dish/dish_management_page.dart';
import 'features/dingtalk/dingtalk_api.dart';
import 'features/dingtalk/dingtalk_management_page.dart';
import 'features/dingtalk/dingtalk_provider.dart';
import 'core/constants/app_constants.dart';
import 'features/menu/menu_api.dart';
import 'features/menu/menu_provider.dart';
import 'features/user/user_api.dart';
import 'features/user/user_provider.dart';
import 'features/store/store_api.dart';
import 'features/store/store_provider.dart';
import 'features/supplier/supplier_repository.dart';
import 'features/supplier/supplier_provider.dart';
import 'features/purchase_order/purchase_order_repository.dart';
import 'features/purchase_order/purchase_order_provider.dart';
import 'core/theme/fluent_theme_provider.dart';

class TowerApp extends StatelessWidget {
  const TowerApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Get services from ServiceLocator
    final storeApi = sl.get<StoreApi>();
    final userApi = sl.get<UserApi>();
    final menuApi = sl.get<MenuApi>();
    final dingTalkApi = sl.get<DingTalkApi>();
    final supplierRepository = sl.get<SupplierRepository>();
    final purchaseOrderRepository = sl.get<PurchaseOrderRepository>();

    return ChangeNotifierProvider(
      create: (_) => FluentThemeProvider(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PermissionProvider()),
          ChangeNotifierProvider(create: (_) => MenuProvider(menuApi)),
          ChangeNotifierProvider(
              create: (_) => UserProvider(userApi, storeApi)),
          ChangeNotifierProvider(create: (_) => StoreProvider(storeApi)),
          ChangeNotifierProvider(
              create: (_) => DingTalkProvider(dingTalkApi)),
          ChangeNotifierProvider(
              create: (_) => SupplierProvider(supplierRepository)),
          ChangeNotifierProvider(
              create: (_) => PurchaseOrderProvider(purchaseOrderRepository)),
        ],
        child: FutureBuilder(
          future: _bootstrap(context),
          builder: (context, snap) {
            if (snap.connectionState != ConnectionState.done) {
              return FluentApp(
                home: ScaffoldPage(
                  content: const Center(child: ProgressRing()),
                ),
              );
            }
            final themeProvider = Provider.of<FluentThemeProvider>(context);
            return FluentApp(
              title: 'Tower Desktop',
              theme: themeProvider.lightTheme,
              darkTheme: themeProvider.darkTheme,
              themeMode: themeProvider.mode,
              home: snap.data == true
                  ? const _DeferredHome()
                  : const LoginScreen(),
              routes: {
                RouteNames.login: (_) => const LoginScreen(),
                RouteNames.home: (_) => const _DeferredHome(),
                RouteNames.dishes: (_) => const DishManagementScope(),
                RouteNames.dingtalk: (_) => const DingTalkManagementPage(),
              },
            );
          },
        ),
      ),
    );
  }
}

/// 延迟加载 Home：需要 MenuProvider 先加载菜单
class _DeferredHome extends StatefulWidget {
  const _DeferredHome();
  @override
  State<_DeferredHome> createState() => _DeferredHomeState();
}

class _DeferredHomeState extends State<_DeferredHome> {
  bool _ready = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _prepare();
    });
  }

  Future<void> _prepare() async {
    final sm = SessionManager();
    if (!sm.isLoggedIn || sm.isExpired) {
      if (mounted) {
        Navigator.of(context).pushReplacement(
            FluentPageRoute(builder: (_) => const LoginScreen()));
      }
      return;
    }
    // 恢复权限到 provider
    final permProvider = context.read<PermissionProvider>();
    permProvider.setPermissions(sm.permissions);
    // 加载菜单
    final menuProvider = context.read<MenuProvider>();
    await menuProvider.load(permissionProvider: permProvider);
    if (mounted) {
      setState(() => _ready = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return ScaffoldPage(
        content: const Center(child: ProgressRing()),
      );
    }
    return const home.HomeScreen();
  }
}

Future<bool> _bootstrap(BuildContext context) async {
  final sm = SessionManager();
  if (sm.isLoggedIn && !sm.isExpired) {
    return true; // 走自动登录流程
  }
  return false;
}
