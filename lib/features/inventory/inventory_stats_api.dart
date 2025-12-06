import '../../core/network/api_client.dart';
class InventoryStatsApi {
  final ApiClient _client;
  InventoryStatsApi(this._client);
  Future<InventoryStatsData> getInventoryStats({String period = 'day'}) async {
    return await _client.getSmart<InventoryStatsData>(
      path: '/inventory-stats',
      queryParameters: {'period': period},
      fromJson: InventoryStatsData.fromJson,
    );
  }
  Future<List<InventoryTrendItem>> getInventoryTrend({String period = 'day'}) async {
    return await _client.getSimpleList<InventoryTrendItem>(
      path: '/inventory-stats/trend',
      queryParameters: {'period': period},
      fromJson: InventoryTrendItem.fromJson,
    );
  }
}
class InventoryStatsData {
  final int totalProducts;      
  final double totalQuantity;   
  final int stockInCount;       
  final double stockInQuantity; 
  final int stockOutCount;      
  final double stockOutQuantity;
  final int recordCount;        
  InventoryStatsData({
    required this.totalProducts,
    required this.totalQuantity,
    required this.stockInCount,
    required this.stockInQuantity,
    required this.stockOutCount,
    required this.stockOutQuantity,
    required this.recordCount,
  });
  factory InventoryStatsData.fromJson(Map<String, dynamic> json) {
    return InventoryStatsData(
      totalProducts: json['total_products'] ?? 0,
      totalQuantity: (json['total_quantity'] ?? 0).toDouble(),
      stockInCount: json['stock_in_count'] ?? 0,
      stockInQuantity: (json['stock_in_quantity'] ?? 0).toDouble(),
      stockOutCount: json['stock_out_count'] ?? 0,
      stockOutQuantity: (json['stock_out_quantity'] ?? 0).toDouble(),
      recordCount: json['record_count'] ?? 0,
    );
  }
  factory InventoryStatsData.mock() {
    return InventoryStatsData(
      totalProducts: 128,
      totalQuantity: 5680.5,
      stockInCount: 45,
      stockInQuantity: 1250.0,
      stockOutCount: 38,
      stockOutQuantity: 980.5,
      recordCount: 83,
    );
  }
}
class InventoryTrendItem {
  final String date;
  final double stockIn;
  final double stockOut;
  InventoryTrendItem({
    required this.date,
    required this.stockIn,
    required this.stockOut,
  });
  factory InventoryTrendItem.fromJson(Map<String, dynamic> json) {
    return InventoryTrendItem(
      date: json['date'] ?? '',
      stockIn: (json['stock_in'] ?? 0).toDouble(),
      stockOut: (json['stock_out'] ?? 0).toDouble(),
    );
  }
}
