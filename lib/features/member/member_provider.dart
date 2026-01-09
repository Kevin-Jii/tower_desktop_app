import 'package:flutter/foundation.dart';
import 'member_api.dart';
import 'models.dart';
class MemberProvider extends ChangeNotifier {
  final MemberApi _api;
  MemberProvider(this._api);
  List<Member> _members = [];
  List<Member> get members => _members;
  bool _loading = false;
  bool get loading => _loading;
  String? _error;
  String? get error => _error;
  int _page = 1;
  int _pageSize = 20;
  int _total = 0;
  bool _hasMore = false;
  String _keyword = '';
  List<WalletLog> _walletLogs = [];
  List<WalletLog> get walletLogs => _walletLogs;
  bool _walletLogsLoading = false;
  bool get walletLogsLoading => _walletLogsLoading;
  String? _walletLogsError;
  String? get walletLogsError => _walletLogsError;
  int _walletLogsPage = 1;
  int _walletLogsTotal = 0;
  bool _walletLogsHasMore = false;
  List<RechargeOrder> _rechargeOrders = [];
  List<RechargeOrder> get rechargeOrders => _rechargeOrders;
  bool _rechargeOrdersLoading = false;
  bool get rechargeOrdersLoading => _rechargeOrdersLoading;
  String? _rechargeOrdersError;
  String? get rechargeOrdersError => _rechargeOrdersError;
  int _rechargeOrdersPage = 1;
  int _rechargeOrdersTotal = 0;
  bool _rechargeOrdersHasMore = false;
  Member? _selectedMember;
  Member? get selectedMember => _selectedMember;
  Future<void> loadMembers({bool refresh = false, String? keyword}) async {
    if (refresh) {
      _page = 1;
      _keyword = keyword ?? '';
    }
    if (!_hasMore && !refresh) return;
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      final response = await _api.getMembers(
        page: _page,
        pageSize: _pageSize,
        keyword: _keyword,
      );
      if (refresh) {
        _members = response.list;
      } else {
        _members.addAll(response.list);
      }
      _total = response.total;
      _hasMore = response.hasNextPage;
      _page++;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
  Future<void> searchMembers(String keyword) async {
    _keyword = keyword;
    await loadMembers(refresh: true);
  }
  Future<Member?> findByPhone(String phone) async {
    try {
      return await _api.getMemberByPhone(phone);
    } catch (e) {
      return null;
    }
  }
  Future<bool> createMember(CreateMemberRequest request) async {
    _loading = true;
    notifyListeners();
    try {
      final result = await _api.createMember(request);
      if (result != null) {
        _members.insert(0, result);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    } finally {
      _loading = false;
    }
  }
  Future<bool> updateMember(int id, UpdateMemberRequest request) async {
    _loading = true;
    notifyListeners();
    try {
      final result = await _api.updateMember(id, request);
      if (result != null) {
        final index = _members.indexWhere((m) => m.id == id);
        if (index != -1) {
          _members[index] = result;
          notifyListeners();
        }
        return true;
      }
      return false;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    } finally {
      _loading = false;
    }
  }
  Future<bool> deleteMember(int id) async {
    try {
      await _api.deleteMember(id);
      _members.removeWhere((m) => m.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
  Future<bool> adjustBalance(int memberId, AdjustBalanceRequest request) async {
    try {
      final result = await _api.adjustBalance(memberId, request);
      if (result != null) {
        final index = _members.indexWhere((m) => m.id == memberId);
        if (index != -1) {
          _members[index] = result;
          notifyListeners();
        }
        return true;
      }
      return false;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
  void selectMember(Member? member) {
    _selectedMember = member;
    notifyListeners();
  }
  Future<void> loadWalletLogs({
    bool refresh = false,
    int? memberId,
    int? type,
    String? startDate,
    String? endDate,
  }) async {
    if (refresh) {
      _walletLogsPage = 1;
    }
    if (!_walletLogsHasMore && !refresh) return;
    _walletLogsLoading = true;
    _walletLogsError = null;
    notifyListeners();
    try {
      final response = await _api.getWalletLogs(
        page: _walletLogsPage,
        pageSize: _pageSize,
        memberId: memberId,
        type: type,
        startDate: startDate,
        endDate: endDate,
      );
      if (refresh) {
        _walletLogs = response.list;
      } else {
        _walletLogs.addAll(response.list);
      }
      _walletLogsTotal = response.total;
      _walletLogsHasMore = response.hasNextPage;
      _walletLogsPage++;
    } catch (e) {
      _walletLogsError = e.toString();
    } finally {
      _walletLogsLoading = false;
      notifyListeners();
    }
  }
  Future<void> loadRechargeOrders({
    bool refresh = false,
    int? memberId,
    int? status,
    String? startDate,
    String? endDate,
  }) async {
    if (refresh) {
      _rechargeOrdersPage = 1;
    }
    if (!_rechargeOrdersHasMore && !refresh) return;
    _rechargeOrdersLoading = true;
    _rechargeOrdersError = null;
    notifyListeners();
    try {
      final response = await _api.getRechargeOrders(
        page: _rechargeOrdersPage,
        pageSize: _pageSize,
        memberId: memberId,
        status: status,
        startDate: startDate,
        endDate: endDate,
      );
      if (refresh) {
        _rechargeOrders = response.list;
      } else {
        _rechargeOrders.addAll(response.list);
      }
      _rechargeOrdersTotal = response.total;
      _rechargeOrdersHasMore = response.hasNextPage;
      _rechargeOrdersPage++;
    } catch (e) {
      _rechargeOrdersError = e.toString();
    } finally {
      _rechargeOrdersLoading = false;
      notifyListeners();
    }
  }
  Future<bool> createRechargeOrder(CreateRechargeOrderRequest request) async {
    try {
      final result = await _api.createRechargeOrder(request);
      if (result != null) {
        _rechargeOrders.insert(0, result);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
  Future<bool> payRechargeOrder(
      String orderNo, PayRechargeOrderRequest request) async {
    try {
      final result = await _api.payRechargeOrder(orderNo, request);
      if (result != null) {
        final index = _rechargeOrders.indexWhere((o) => o.orderNo == orderNo);
        if (index != -1) {
          _rechargeOrders[index] = result;
          notifyListeners();
        }
        return true;
      }
      return false;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
  Future<bool> cancelRechargeOrder(String orderNo) async {
    try {
      await _api.cancelRechargeOrder(orderNo);
      _rechargeOrders.removeWhere((o) => o.orderNo == orderNo);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
