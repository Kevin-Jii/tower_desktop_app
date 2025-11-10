import 'package:flutter/foundation.dart';

/// 分页状态提供者基类
abstract class PaginationProviderBase<T> with ChangeNotifier {
  final List<T> _items = [];
  int _page = 1;
  bool _loading = false;
  bool _hasMore = true;
  String? _error;

  List<T> get items => List.unmodifiable(_items);
  bool get loading => _loading;
  bool get hasMore => _hasMore;
  String? get error => _error;
  bool get hasData => _items.isNotEmpty;

  /// 子类必须实现：从后端拉取一页数据
  Future<List<T>> fetchPage(int page);

  /// 刷新数据，加载第一页
  Future<void> refresh() async {
    _page = 1;
    _hasMore = true;
    _items.clear();
    await _loadPage(_page);
  }

  /// 加载更多
  Future<void> loadMore() async {
    if (_loading || !_hasMore) return;
    _page++;
    await _loadPage(_page);
  }

  Future<void> _loadPage(int page) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final data = await fetchPage(page);
      if (page == 1) {
        _items
          ..clear()
          ..addAll(data);
      } else {
        _items.addAll(data);
      }
      _hasMore = data.isNotEmpty;
    } catch (e, s) {
      debugPrint('分页加载失败: $e\n$s');
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
