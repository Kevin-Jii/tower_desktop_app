import 'package:tower_desktop_app/core/di/service_locator.dart';
import 'package:tower_desktop_app/core/network/api_client.dart';
import 'package:tower_desktop_app/features/auth/auth_api.dart';
import 'package:tower_desktop_app/features/user/user_api.dart';
import 'package:tower_desktop_app/features/user/user_repository.dart';
import 'package:tower_desktop_app/features/store/store_api.dart';
import 'package:tower_desktop_app/features/store/store_repository.dart';
import 'package:tower_desktop_app/features/role/role_api.dart';
import 'package:tower_desktop_app/features/role/role_repository.dart';
import 'package:tower_desktop_app/features/menu/menu_api.dart';
import 'package:tower_desktop_app/features/dingtalk/dingtalk_api.dart';
import 'package:tower_desktop_app/features/supplier/supplier_api.dart';
import 'package:tower_desktop_app/features/supplier/supplier_repository.dart';
import 'package:tower_desktop_app/features/purchase_order/purchase_order_api.dart';
import 'package:tower_desktop_app/features/purchase_order/purchase_order_repository.dart';

/// Service configuration for dependency injection
///
/// Registers all services with the ServiceLocator.
/// Call [setupServices] at app startup before using any services.
class ServiceConfig {
  ServiceConfig._();

  /// Initialize all services
  /// Should be called once at app startup
  static void setupServices() {
    final locator = sl;

    // Core services
    _registerCoreServices(locator);

    // API services
    _registerApiServices(locator);
  }

  /// Register core infrastructure services
  static void _registerCoreServices(ServiceLocator locator) {
    // ApiClient is a singleton
    locator.registerSingleton<ApiClient>(ApiClient());
  }

  /// Register API layer services
  static void _registerApiServices(ServiceLocator locator) {
    // Auth API (creates its own ApiClient internally)
    locator.registerLazySingleton<AuthApi>(
      () => AuthApi(),
    );

    // User API (legacy)
    locator.registerLazySingleton<UserApi>(
      () => UserApi(sl.get<ApiClient>()),
    );

    // User Repository (new)
    locator.registerLazySingleton<UserRepository>(
      () => UserRepository(sl.get<ApiClient>()),
    );

    // Store API (legacy)
    locator.registerLazySingleton<StoreApi>(
      () => StoreApi(sl.get<ApiClient>()),
    );

    // Store Repository (new)
    locator.registerLazySingleton<StoreRepository>(
      () => StoreRepository(sl.get<ApiClient>()),
    );

    // Role API (legacy)
    locator.registerLazySingleton<RoleApi>(
      () => RoleApi(sl.get<ApiClient>()),
    );

    // Role Repository (new)
    locator.registerLazySingleton<RoleRepository>(
      () => RoleRepository(sl.get<ApiClient>()),
    );

    // Menu API (creates its own ApiClient internally)
    locator.registerLazySingleton<MenuApi>(
      () => MenuApi(),
    );

    // DingTalk API
    locator.registerLazySingleton<DingTalkApi>(
      () => DingTalkApi(sl.get<ApiClient>()),
    );

    // Supplier API
    locator.registerLazySingleton<SupplierApi>(
      () => SupplierApi(sl.get<ApiClient>()),
    );

    // Supplier Repository
    locator.registerLazySingleton<SupplierRepository>(
      () => SupplierRepository(sl.get<SupplierApi>()),
    );

    // Purchase Order API
    locator.registerLazySingleton<PurchaseOrderApi>(
      () => PurchaseOrderApi(sl.get<ApiClient>()),
    );

    // Purchase Order Repository
    locator.registerLazySingleton<PurchaseOrderRepository>(
      () => PurchaseOrderRepository(sl.get<PurchaseOrderApi>()),
    );
  }

  /// Reset all services (useful for testing)
  static void resetServices() {
    sl.reset();
  }
}
