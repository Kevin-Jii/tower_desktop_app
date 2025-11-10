import 'package:flutter/foundation.dart';
import '../network/api_response.dart';

/// 通用列表数据提供者 Mixin
mixin ListProviderMixin<T> on ChangeNotifier {
  List<T> _items = [];
  bool _loading = false;
  String? _error;

  List<T> get items => _items;
  bool get loading => _loading;
  String? get error => _error;
  bool get hasData => _items.isNotEmpty;

  /// 统一加载数据方法
  /// [fetcher] 为一个返回 Future<ApiResponse<List<T>>> 的异步函数
  Future<void> loadData(Future<ApiResponse<List<T>>> Function() fetcher) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await fetcher();

      if (response.success) {
        _items = response.data ?? [];
        _error = null;
      } else {
        _error = response.message.isNotEmpty
            ? response.message
            : '未知错误 (${response.code})';
        debugPrint('❌ 加载失败: $_error');
      }
    } catch (e, stack) {
      _error = '网络请求异常: $e';
      debugPrint('⚠️ 异常: $e\n$stack');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// 刷新数据（清空原有数据）
  Future<void> refreshData(Future<ApiResponse<List<T>>> Function() fetcher) async {
    _items.clear();
    await loadData(fetcher);
  }

  /// 手动清空数据
  void clear() {
    _items.clear();
    _error = null;
    _loading = false;
    notifyListeners();
  }
}
