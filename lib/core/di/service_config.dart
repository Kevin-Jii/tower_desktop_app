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
import 'package:tower_desktop_app/features/dict/dict_api.dart';
import 'package:tower_desktop_app/features/dict/dict_repository.dart';
import 'package:tower_desktop_app/features/inventory/inventory_api.dart';
import 'package:tower_desktop_app/features/inventory/inventory_repository.dart';
import 'package:tower_desktop_app/features/store_account/store_account_api.dart';
import 'package:tower_desktop_app/features/store_account/store_account_repository.dart';
class ServiceConfig {
  ServiceConfig._();
  static void setupServices() {
    final locator = sl;
    _registerCoreServices(locator);
    _registerApiServices(locator);
  }
  static void _registerCoreServices(ServiceLocator locator) {
    locator.registerSingleton<ApiClient>(ApiClient());
  }
  static void _registerApiServices(ServiceLocator locator) {
    locator.registerLazySingleton<AuthApi>(
      () => AuthApi(),
    );
    locator.registerLazySingleton<UserApi>(
      () => UserApi(sl.get<ApiClient>()),
    );
    locator.registerLazySingleton<UserRepository>(
      () => UserRepository(sl.get<ApiClient>()),
    );
    locator.registerLazySingleton<StoreApi>(
      () => StoreApi(sl.get<ApiClient>()),
    );
    locator.registerLazySingleton<StoreRepository>(
      () => StoreRepository(sl.get<ApiClient>()),
    );
    locator.registerLazySingleton<RoleApi>(
      () => RoleApi(sl.get<ApiClient>()),
    );
    locator.registerLazySingleton<RoleRepository>(
      () => RoleRepository(sl.get<ApiClient>()),
    );
    locator.registerLazySingleton<MenuApi>(
      () => MenuApi(),
    );
    locator.registerLazySingleton<DingTalkApi>(
      () => DingTalkApi(sl.get<ApiClient>()),
    );
    locator.registerLazySingleton<SupplierApi>(
      () => SupplierApi(sl.get<ApiClient>()),
    );
    locator.registerLazySingleton<SupplierRepository>(
      () => SupplierRepository(sl.get<SupplierApi>()),
    );
    locator.registerLazySingleton<PurchaseOrderApi>(
      () => PurchaseOrderApi(sl.get<ApiClient>()),
    );
    locator.registerLazySingleton<PurchaseOrderRepository>(
      () => PurchaseOrderRepository(sl.get<PurchaseOrderApi>()),
    );
    locator.registerLazySingleton<DictApi>(
      () => DictApi(sl.get<ApiClient>()),
    );
    locator.registerLazySingleton<DictRepository>(
      () => DictRepository(sl.get<DictApi>()),
    );
    locator.registerLazySingleton<InventoryApi>(
      () => InventoryApi(sl.get<ApiClient>()),
    );
    locator.registerLazySingleton<InventoryRepository>(
      () => InventoryRepository(sl.get<InventoryApi>()),
    );
    locator.registerLazySingleton<StoreAccountApi>(
      () => StoreAccountApi(sl.get<ApiClient>()),
    );
    locator.registerLazySingleton<StoreAccountRepository>(
      () => StoreAccountRepository(sl.get<StoreAccountApi>()),
    );
  }
  static void resetServices() {
    sl.reset();
  }
}
