import '../../core/providers/list_provider.dart';
import '../../core/network/api_response.dart';
import 'role_api.dart';
import 'role_models.dart';
class RoleProvider extends ListProvider<RoleItem> {
  final RoleApi _api;
  RoleProvider(this._api);
  List<RoleItem> get list => items;
  int _page = 1;
  int _pageSize = 20; 
  int _total = 0; 
  String? _keyword; 
  int get page => _page;
  int get pageSize => _pageSize;
  int get total => _total;
  String? get keyword => _keyword;
  List<RoleItem> get currentPageItems {
    final start = (_page - 1) * _pageSize;
    if (start >= list.length) return const [];
    final end =
        (start + _pageSize) > list.length ? list.length : (start + _pageSize);
    return list.sublist(start, end);
  }
  void setPage(int newPage) {
    if (newPage < 1) return;
    final totalPages =
        _total == 0 ? 1 : ((_total + _pageSize - 1) / _pageSize).ceil();
    if (newPage > totalPages) return;
    _page = newPage;
    notifyListeners();
  }
  void setPageSize(int newSize) {
    if (newSize <= 0) return;
    _pageSize = newSize;
    _page = 1; 
    notifyListeners();
  }
  @override
  Future<ApiResponse<List<RoleItem>>> fetchList(Map<String, dynamic>? query) async {
    final keyword = query?['keyword'] as String?;
    try {
      final data = await _api.getRoles(keyword: keyword);
      return ApiResponse(code: 200, message: 'success', data: data);
    } catch (e) {
      return ApiResponse(code: 500, message: e.toString());
    }
  }
  Future<bool> create(CreateRoleRequest req) async {
    try {
      await _api.createRole(req);
      await reload();
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<bool> update(int id, UpdateRoleRequest req) async {
    try {
      await _api.updateRole(id, req);
      await reload();
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<bool> remove(int id) async {
    try {
      await _api.deleteRole(id);
      await reload();
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<void> loadRoles({String? keyword}) => super.load(query: {
        if (keyword != null && keyword.isNotEmpty) 'keyword': keyword,
      }).then((_) {
        _keyword = keyword?.trim().isEmpty == true ? null : keyword?.trim();
        _total = list.length; 
        _page = 1; 
        notifyListeners();
      });
}
