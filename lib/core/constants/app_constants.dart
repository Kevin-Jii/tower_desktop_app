class AppTexts {
  static const String appName = 'Tower供应数据管理中心';
  static const String selectMenuPlaceholder = '请选择左侧菜单';
  static const String defaultStoreName = '默认总部门店';
  static const String envProd = 'PROD';
}
class PermissionCodes {
  static const String userAdd = 'system:user:add';
  static const String userDelete = 'system:user:delete';
  static const String userEdit = 'system:user:edit';
  static const String userList = 'system:user:list';
  static const String roleList = 'system:role:list';
  static const String roleAdd = 'system:role:add';
  static const String roleEdit = 'system:role:edit';
  static const String roleDelete = 'system:role:delete';
  static const String roleMenu = 'system:role:menu'; 
  static const String menuList = 'system:menu:list';
  static const String menuAdd = 'system:menu:add';
  static const String menuEdit = 'system:menu:edit';
  static const String menuDelete = 'system:menu:delete';
  static const String storeList = 'store:list';
  static const String storeAdd = 'store:add';
  static const String storeEdit = 'store:edit';
  static const String storeDelete = 'store:delete';
  static const String storeMenu = 'store:menu'; 
  static const String dishList = 'dish:list';
  static const String dishAdd = 'dish:add';
  static const String dishEdit = 'dish:edit';
  static const String dishDelete = 'dish:delete';
  static const String dishStatus = 'dish:status'; 
  static const String reportList = 'report:list';
  static const String reportAdd = 'report:add';
  static const String reportEdit = 'report:edit';
  static const String reportDelete = 'report:delete';
  static const String reportStatistics = 'report:statistics';
  static const String dingtalkRobotList = 'dingtalk:robot:list';
  static const String dingtalkRobotAdd = 'dingtalk:robot:add';
  static const String dingtalkRobotEdit = 'dingtalk:robot:edit';
  static const String dingtalkRobotDelete = 'dingtalk:robot:delete';
  static const String dingtalkRobotTest = 'dingtalk:robot:test';
  static const String dingtalkRobotStatus = 'dingtalk:robot:status';
  static const String memberList = 'member:list';
  static const String memberAdd = 'member:add';
  static const String memberEdit = 'member:edit';
  static const String memberDelete = 'member:delete';
  static const String memberRecharge = 'member:recharge';
  static const String memberAdjustBalance = 'member:adjust';
}
class StatusValues {
  static const int enabled = 1;
  static const int disabled = 0;
}
class PaginationDefaults {
  static const int pageSize = 10;
  static const int firstPage = 1;
}
class EnvironmentTags {
  static const String prod = 'PROD';
  static const String dev = 'DEV';
  static const String test = 'TEST';
}
class RouteNames {
  static const String login = '/login';
  static const String home = '/home';
  static const String dishes = '/dishes';
  static const String dingtalk = '/dingtalk';
  static const String reports = '/reports';
}
class ApiPaths {
  static const String users = '/users';
  static const String stores = '/stores';
  static const String menus = '/menus';
  static const String dishes = '/dishes';
  static const String roles = '/roles';
  static const String menuReports = '/menu-reports';
  static const String menuReportOrders = '/menu-reports';
  static const String menuReportItems = '/menu-report-items';
  static const String suppliers = '/suppliers';
  static const String supplierCategories = '/supplier-categories';
  static const String supplierProducts = '/supplier-products';
  static const String storeSuppliers = '/store-suppliers';
  static const String purchaseOrders = '/purchase-orders';
  static const String members = '/members';
  static const String walletLogs = '/wallet-logs';
  static const String rechargeOrders = '/recharge-orders';
  static const String printers = '/printers';
}
