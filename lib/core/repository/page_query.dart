/// Query parameters for paginated requests
///
/// Encapsulates pagination, search, and filter parameters.
class PageQuery {
  final int page;
  final int pageSize;
  final String? keyword;
  final Map<String, dynamic>? filters;

  const PageQuery({
    this.page = 1,
    this.pageSize = 10,
    this.keyword,
    this.filters,
  });

  /// Convert to query parameters map for API requests
  Map<String, dynamic> toQueryParameters() {
    final params = <String, dynamic>{
      'page': page,
      'page_size': pageSize,
    };

    if (keyword != null && keyword!.isNotEmpty) {
      params['keyword'] = keyword;
    }

    if (filters != null) {
      params.addAll(filters!);
    }

    return params;
  }

  /// Create a copy with modified values
  PageQuery copyWith({
    int? page,
    int? pageSize,
    String? keyword,
    Map<String, dynamic>? filters,
  }) {
    return PageQuery(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      keyword: keyword ?? this.keyword,
      filters: filters ?? this.filters,
    );
  }

  /// Create query for next page
  PageQuery nextPage() => copyWith(page: page + 1);

  /// Create query for previous page
  PageQuery previousPage() => copyWith(page: page > 1 ? page - 1 : 1);

  /// Create query for first page
  PageQuery firstPage() => copyWith(page: 1);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PageQuery &&
          runtimeType == other.runtimeType &&
          page == other.page &&
          pageSize == other.pageSize &&
          keyword == other.keyword;

  @override
  int get hashCode => Object.hash(page, pageSize, keyword);

  @override
  String toString() =>
      'PageQuery(page: $page, pageSize: $pageSize, keyword: $keyword, filters: $filters)';
}
