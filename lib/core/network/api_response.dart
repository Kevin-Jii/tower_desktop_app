class ApiResponse<T> {
  final int code;
  final String message;
  final T? data;
  final Map<String, dynamic>? meta;
  ApiResponse({
    required this.code,
    required this.message,
    this.data,
    this.meta,
  });
  bool get success => code == 200;
  bool get hasMeta => meta != null && meta!.isNotEmpty;
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? dataParser,
  ) {
    final dynamic rawData = json['data'];
    final parsed = (dataParser != null && rawData != null)
        ? dataParser(rawData)
        : rawData as T?;
    return ApiResponse(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: parsed,
      meta: json['meta'] is Map<String, dynamic>
          ? (json['meta'] as Map<String, dynamic>)
          : null,
    );
  }
}
class PageResponse<T> {
  final List<T> list;
  final int total;
  final int page;
  final int pageSize;
  final int? pageCount;
  final bool? hasMore;
  PageResponse({
    required this.list,
    required this.total,
    required this.page,
    required this.pageSize,
    this.pageCount,
    this.hasMore,
  });
  int get totalPages => pageCount ?? (total / pageSize).ceil();
  bool get hasNextPage => hasMore ?? page < totalPages;
  bool get hasPrevPage => page > 1;
  factory PageResponse.fromEnvelope(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) itemParser,
  ) {
    final outerData = json['data'];
    if (outerData is! Map<String, dynamic>) {
      throw ArgumentError('分页响应缺少 data 或 data 不是对象');
    }
    final dataList = outerData['list'];
    final List actualList = dataList is List ? dataList : [];
    int requireInt(String key) {
      final v = outerData[key];
      if (v is int) return v;
      throw ArgumentError('分页信息 $key 缺失或类型错误(${v.runtimeType})');
    }
    int? optInt(String key) {
      if (!outerData.containsKey(key)) return null;
      final v = outerData[key];
      if (v == null) return null;
      if (v is int) return v;
      throw ArgumentError('分页信息 $key 类型错误(${v.runtimeType})');
    }
    bool? optBool(String key) {
      if (!outerData.containsKey(key)) return null;
      final v = outerData[key];
      if (v == null) return null;
      if (v is bool) return v;
      throw ArgumentError('分页信息 $key 类型错误(${v.runtimeType})');
    }
    return PageResponse(
      list:
          actualList.map((e) => itemParser(e as Map<String, dynamic>)).toList(),
      total: optInt('total') ?? 0,
      page: optInt('page') ?? 1,
      pageSize: optInt('page_size') ?? optInt('size') ?? 20,
      pageCount: optInt('page_count') ?? optInt('page_num'),
      hasMore: optBool('has_more'),
    );
  }
}
