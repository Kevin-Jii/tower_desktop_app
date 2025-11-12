import '../../core/constants/app_constants.dart';
import '../../core/network/api_client.dart';
import '../../core/network/api_response.dart';
import 'models.dart';

class MenuReportApi {
  final ApiClient _client;
  MenuReportApi(this._client);

  /// 获取报菜记录单列表 (新接口)
  Future<PageResponse<MenuReportOrder>> getReportOrders({
    int page = PaginationDefaults.firstPage,
    int pageSize = PaginationDefaults.pageSize,
    String? startDate,
    String? endDate,
  }) {
    return _client.getPage<MenuReportOrder>(
      ApiPaths.menuReportOrders,
      queryParameters: {
        'page': page,
        'page_size': pageSize,
        if (startDate != null && startDate.isNotEmpty) 'start_date': startDate,
        if (endDate != null && endDate.isNotEmpty) 'end_date': endDate,
      },
      itemParser: (json) => MenuReportOrder.fromJson(json),
    );
  }

  /// 创建报菜记录单 (新接口)
  Future<MenuReportOrder?> createReportOrder(CreateMenuReportOrderRequest request) {
    return _client.postSmart<MenuReportOrder>(
      path: ApiPaths.menuReportOrders,
      data: request.toJson(),
      fromJson: (json) => MenuReportOrder.fromJson(json),
      filterNulls: true,
    );
  }

  /// 获取单个报菜记录单 (新接口)
  Future<MenuReportOrder> getReportOrder(int id) {
    return _client.getSmart<MenuReportOrder>(
      path: '${ApiPaths.menuReportOrders}/$id',
      fromJson: (json) => MenuReportOrder.fromJson(json),
    );
  }

  /// 删除报菜记录单 (新接口)
  Future<void> deleteReportOrder(int id) {
    return _client.deleteSmart(path: '${ApiPaths.menuReportOrders}/$id');
  }

  /// 获取报菜详情列表 (新接口)
  Future<PageResponse<MenuReportItem>> getReportItems({
    int page = PaginationDefaults.firstPage,
    int pageSize = PaginationDefaults.pageSize,
    int? reportOrderId,
  }) {
    return _client.getPage<MenuReportItem>(
      ApiPaths.menuReportItems,
      queryParameters: {
        'page': page,
        'page_size': pageSize,
        if (reportOrderId != null && reportOrderId > 0)
          'report_order_id': reportOrderId,
      },
      itemParser: (json) => MenuReportItem.fromJson(json),
    );
  }

  /// 创建报菜详情 (新接口)
  Future<MenuReportItem?> createReportItem(CreateMenuReportItemRequest request) {
    return _client.postSmart<MenuReportItem>(
      path: ApiPaths.menuReportItems,
      data: request.toJson(),
      fromJson: (json) => MenuReportItem.fromJson(json),
      filterNulls: true,
    );
  }

  /// 更新报菜详情 (新接口)
  Future<MenuReportItem?> updateReportItem(int id, UpdateMenuReportItemRequest request) {
    return _client.putSmart<MenuReportItem>(
      path: '${ApiPaths.menuReportItems}/$id',
      data: request.toJson(),
      fromJson: (json) => MenuReportItem.fromJson(json),
      filterNulls: true,
    );
  }

  /// 删除报菜详情 (新接口)
  Future<void> deleteReportItem(int id) {
    return _client.deleteSmart(path: '${ApiPaths.menuReportItems}/$id');
  }

  /// 获取单个报菜详情 (新接口)
  Future<MenuReportItem> getReportItem(int id) {
    return _client.getSmart<MenuReportItem>(
      path: '${ApiPaths.menuReportItems}/$id',
      fromJson: (json) => MenuReportItem.fromJson(json),
    );
  }

  // 为了向后兼容，保留旧接口
  @Deprecated('Use getReportOrders instead')
  Future<PageResponse<MenuReport>> getReports({
    int page = PaginationDefaults.firstPage,
    int pageSize = PaginationDefaults.pageSize,
    String? startDate,
    String? endDate,
  }) {
    return _client.getPage<MenuReport>(
      ApiPaths.menuReports,
      queryParameters: {
        'page': page,
        'page_size': pageSize,
        if (startDate != null && startDate.isNotEmpty) 'start_date': startDate,
        if (endDate != null && endDate.isNotEmpty) 'end_date': endDate,
      },
      itemParser: (json) => MenuReport.fromJson(json),
    );
  }

  @Deprecated('Use createReportOrder instead')
  Future<MenuReport?> createReport(CreateMenuReportRequest request) {
    return _client.postSmart<MenuReport>(
      path: ApiPaths.menuReports,
      data: request.toJson(),
      fromJson: (json) => MenuReport.fromJson(json),
      filterNulls: true,
    );
  }

  @Deprecated('Use updateReportItem instead')
  Future<MenuReport?> updateReport(int id, UpdateMenuReportRequest request) {
    return _client.putSmart<MenuReport>(
      path: '${ApiPaths.menuReports}/$id',
      data: request.toJson(),
      fromJson: (json) => MenuReport.fromJson(json),
      filterNulls: true,
    );
  }

  @Deprecated('Use deleteReportItem instead')
  Future<void> deleteReport(int id) {
    return _client.deleteSmart(path: '${ApiPaths.menuReports}/$id');
  }

  @Deprecated('Use getReportItem instead')
  Future<MenuReport> getReport(int id) {
    return _client.getSmart<MenuReport>(
      path: '${ApiPaths.menuReports}/$id',
      fromJson: (json) => MenuReport.fromJson(json),
    );
  }

  @Deprecated('旧统计接口，后端已移除')
  Future<MenuReportStats> getStatistics({
    required String startDate,
    required String endDate,
  }) {
    throw UnsupportedError('旧统计接口已废弃，请使用新的统计功能');
  }
}
