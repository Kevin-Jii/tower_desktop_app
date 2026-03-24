import 'package:flutter/foundation.dart';
import '../network/api_response.dart';
import '../network/base_provider.dart';
abstract class ListProvider<T> extends ChangeNotifier with ListProviderMixin<T> {
  Map<String, dynamic>? lastQuery;
  Future<ApiResponse<List<T>>> fetchList(Map<String, dynamic>? query);
  Future<void> load({Map<String, dynamic>? query}) async {
    if (loading) return;
    lastQuery = query;
    await loadData(() => fetchList(query));
  }
  Future<void> reload() => load(query: lastQuery);
  void replaceAll(List<T> data) {
    items.clear();
    items.addAll(data);
    notifyListeners();
  }
  void addItem(T item) {
    items.add(item);
    notifyListeners();
  }
  void updateItem(bool Function(T) test, T Function(T) mapper) {
    final updatedItems = items.map((e) => test(e) ? mapper(e) : e).toList();
    items.clear();
    items.addAll(updatedItems);
    notifyListeners();
  }
  void removeWhere(bool Function(T) test) {
    items.removeWhere(test);
    notifyListeners();
  }
}
