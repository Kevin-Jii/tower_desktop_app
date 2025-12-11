import 'package:flutter/foundation.dart';
import 'gallery_api.dart';
import 'models.dart';
class GalleryProvider extends ChangeNotifier {
  final GalleryApi _api;
  GalleryProvider(this._api);
  List<GalleryImage> _images = [];
  List<GalleryImage> get images => _images;
  Set<int> _selectedIds = {};
  Set<int> get selectedIds => _selectedIds;
  bool _loading = false;
  bool get loading => _loading;
  String? _error;
  String? get error => _error;
  int _page = 1;
  int _total = 0;
  int get total => _total;
  final int _pageSize = 20;
  bool _hasMore = true;
  bool get hasMore => _hasMore;
  String? _category;
  String? get category => _category;
  String? _keyword;
  String? get keyword => _keyword;
  Future<void> loadImages({
    String? category,
    String? keyword,
    int? storeId,
    bool refresh = false,
  }) async {
    if (refresh) {
      _page = 1;
      _hasMore = true;
      _category = category;
      _keyword = keyword;
    }
    if (!_hasMore && !refresh) return;
    _loading = true;
    _error = null;
    notifyListeners();
    final result = await _api.list(
      page: _page,
      pageSize: _pageSize,
      category: _category,
      keyword: _keyword,
      storeId: storeId,
    );
    if (result.isSuccess && result.data != null) {
      final data = result.data!;
      if (refresh) {
        _images = data.list;
      } else {
        _images = [..._images, ...data.list];
      }
      _total = data.total;
      _hasMore = data.hasMore;
      _page++;
    } else {
      _error = result.error;
    }
    _loading = false;
    notifyListeners();
  }
  Future<bool> uploadImage(String filePath, {String? category, String? remark}) async {
    final result = await _api.upload(filePath, category: category, remark: remark);
    if (result.isSuccess && result.data != null) {
      _images = [result.data!, ..._images];
      _total++;
      notifyListeners();
      return true;
    }
    _error = result.error;
    notifyListeners();
    return false;
  }
  Future<bool> updateImage(int id, UpdateGalleryRequest request) async {
    final result = await _api.update(id, request);
    if (result.isSuccess) {
      final detailResult = await _api.get(id);
      if (detailResult.isSuccess && detailResult.data != null) {
        final index = _images.indexWhere((img) => img.id == id);
        if (index != -1) {
          _images[index] = detailResult.data!;
          notifyListeners();
        }
      }
      return true;
    }
    _error = result.error;
    notifyListeners();
    return false;
  }
  Future<bool> deleteImage(int id) async {
    final result = await _api.delete(id);
    if (result.isSuccess) {
      _images = _images.where((img) => img.id != id).toList();
      _selectedIds.remove(id);
      _total--;
      notifyListeners();
      return true;
    }
    _error = result.error;
    notifyListeners();
    return false;
  }
  Future<bool> batchDelete() async {
    if (_selectedIds.isEmpty) return false;
    final result = await _api.batchDelete(_selectedIds.toList());
    if (result.isSuccess) {
      final deleteCount = _selectedIds.length;
      _images = _images.where((img) => !_selectedIds.contains(img.id)).toList();
      _selectedIds.clear();
      _total -= deleteCount;
      notifyListeners();
      return true;
    }
    _error = result.error;
    notifyListeners();
    return false;
  }
  void toggleSelection(int id) {
    if (_selectedIds.contains(id)) {
      _selectedIds.remove(id);
    } else {
      _selectedIds.add(id);
    }
    notifyListeners();
  }
  void toggleSelectAll() {
    if (_selectedIds.length == _images.length) {
      _selectedIds.clear();
    } else {
      _selectedIds = _images.map((img) => img.id).toSet();
    }
    notifyListeners();
  }
  void clearSelection() {
    _selectedIds.clear();
    notifyListeners();
  }
  void setCategory(String? category) {
    loadImages(category: category, keyword: _keyword, refresh: true);
  }
  void search(String? keyword) {
    loadImages(category: _category, keyword: keyword, refresh: true);
  }
}
