/// 统一后端响应格式封装
class ApiResponse<T> {
  final int code;
  final String message;
  final T? data;
  final Map<String, dynamic>? meta; // 兼容分页或附加信息

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

/// 分页响应封装
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

  /// 从 data.list 中解析列表数据，从 data 中解析分页信息
  /// 适配后端统一格式：{code, message, data: {list: [...], total: n, page: n, page_size: n}}
  factory PageResponse.fromEnvelope(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) itemParser,
  ) {
    // 获取外层 data（包含列表和分页信息的对象）
    final outerData = json['data'];
    if (outerData is! Map<String, dynamic>) {
      throw ArgumentError('分页响应缺少 data 或 data 不是对象');
    }

    // 获取列表数据（data.list）
    final dataList = outerData['list'];
    if (dataList is! List) {
      throw ArgumentError('期望 data.list 为 List, 实际为: ${dataList.runtimeType}');
    }

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
      list: dataList.map((e) => itemParser(e as Map<String, dynamic>)).toList(),
      total: requireInt('total'),
      page: requireInt('page'),
      pageSize: requireInt('page_size'),
      pageCount: optInt('page_count') ?? optInt('page_num'),
      hasMore: optBool('has_more'),
    );
  }
}
