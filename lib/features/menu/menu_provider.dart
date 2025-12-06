import 'package:flutter/foundation.dart';
import 'menu_api.dart';
import 'models.dart';
import '../../core/constants/menu_types.dart';
import '../auth/permission_provider.dart';
class MenuProvider extends ChangeNotifier {
  final MenuApi _api;
  MenuProvider(this._api);
  List<MenuItem> _tree = [];
  bool _loading = false;
  String? _error;
  MenuItem? _selected;
  List<MenuItem> get tree => _tree;
  bool get loading => _loading;
  String? get error => _error;
  MenuItem? get selected => _selected;
  Future<void> load({PermissionProvider? permissionProvider}) async {
    if (_loading) return;
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      final raw = await _api.getUserMenus();
        print('=== 后端返回菜单数量: ${raw.length} ===');
          for (var m in raw) {
      print('菜单: id=${m.id}, parentId=${m.parentId}, title=${m.title}, children=${m.children.length}');
    }
      final List<String> collectedPerms = [];
      List<MenuItem> filterTree(List<MenuItem> nodes) {
        final result = <MenuItem>[];
        for (final n in nodes) {
          if (n.type == MenuType.button) {
            if (n.permission != null && n.permission!.isNotEmpty) {
              collectedPerms.add(n.permission!);
            }
            continue; 
          }
          result.add(n.copyWith(children: filterTree(n.children)));
        }
        return result;
      }
      _tree = filterTree(raw.where((n) => n.parentId == 0).toList());
      permissionProvider?.setPermissions(collectedPerms);
      if (_tree.isNotEmpty) {
        MenuItem? firstMenu;
        void findFirst(List<MenuItem> list) {
          for (final m in list) {
            if (m.type == MenuType.page) {
              firstMenu = m;
              return;
            }
            if (m.children.isNotEmpty) findFirst(m.children);
            if (firstMenu != null) return;
          }
        }
        findFirst(_tree);
        _selected = firstMenu ?? _tree.first;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
  void select(MenuItem item) {
    _selected = item;
    notifyListeners();
  }
}
