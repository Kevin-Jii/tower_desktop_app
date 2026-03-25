import 'package:flutter/foundation.dart';
import 'member_api.dart';
import 'models.dart';
class MemberProvider extends ChangeNotifier {
  final MemberApi _api;
  MemberProvider(this._api);
  List<Member> _list = [];
  int _page = 1;
  int _pageSize = 20;
  int _total = 0;
  bool _loading = false;
  String? _error;
  String? _keyword;
  List<Member> get list => _list;
  int get page => _page;
  int get pageSize => _pageSize;
  int get total => _total;
  bool get loading => _loading;
  String? get error => _error;
  String? get keyword => _keyword;
  Future<void> loadMembers({String? keyword, int? page}) async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      final resp = await _api.getMembers(
        keyword: keyword,
        page: page ?? _page,
        pageSize: _pageSize,
      );
      _list = resp.list;
      _total = resp.total ?? 0;
      _keyword = keyword;
      if (page != null) _page = page;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
  Future<void> refresh() => loadMembers(keyword: _keyword, page: 1);
  void setPage(int newPage) {
    if (newPage < 1) return;
    loadMembers(keyword: _keyword, page: newPage);
  }
  Future<Member?> createMember(CreateMemberReq req) async {
    try {
      final member = await _api.createMember(req);
      await refresh();
      return member;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }
  Future<Member?> updateMember(int id, UpdateMemberReq req) async {
    try {
      final member = await _api.updateMember(id, req);
      await refresh();
      return member;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }
  Future<bool> deleteMember(int id) async {
    try {
      await _api.deleteMember(id);
      await refresh();
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
class MemberDetailProvider extends ChangeNotifier {
  final MemberApi _api;
  MemberDetailProvider(this._api);
  Member? _member;
  List<WalletLog> _walletLogs = [];
  List<RechargeOrder> _rechargeOrders = [];
  bool _loading = false;
  String? _error;
  int _logPage = 1;
  int _logPageSize = 20;
  int _logTotal = 0;
  int _orderPage = 1;
  int _orderPageSize = 20;
  int _orderTotal = 0;
  Member? get member => _member;
  List<WalletLog> get walletLogs => _walletLogs;
  List<RechargeOrder> get rechargeOrders => _rechargeOrders;
  bool get loading => _loading;
  String? get error => _error;
  int get logPage => _logPage;
  int get logTotal => _logTotal;
  int get orderPage => _orderPage;
  int get orderTotal => _orderTotal;
  Future<void> loadMember(int id) async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _member = await _api.getMemberById(id);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
  Future<void> loadWalletLogs(int memberId, {int? page}) async {
    try {
      final resp = await _api.getWalletLogs(
        memberId: memberId,
        page: page ?? _logPage,
        pageSize: _logPageSize,
      );
      _walletLogs = resp.list;
      _logTotal = resp.total ?? 0;
      if (page != null) _logPage = page;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
  Future<void> loadRechargeOrders(int memberId, {int? page}) async {
    try {
      final resp = await _api.getRechargeOrders(
        memberId: memberId,
        page: page ?? _orderPage,
        pageSize: _orderPageSize,
      );
      _rechargeOrders = resp.list;
      _orderTotal = resp.total ?? 0;
      if (page != null) _orderPage = page;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
  Future<bool> recharge({
    required int memberId,
    required String payAmount,
    String? giftAmount,
    required int payType,
    String? remark,
  }) async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      await _api.createRechargeOrder(CreateRechargeOrderReq(
        memberId: memberId,
        payAmount: payAmount,
        giftAmount: giftAmount,
        payType: payType,
        remark: remark,
      ));
      await loadMember(memberId);
      return true;
    } catch (e) {
      _error = e.toString();
      _loading = false;
      notifyListeners();
      return false;
    }
  }
  Future<bool> adjustBalance({
    required int memberId,
    required String amount,
    required int type,
    String? remark,
    int? version,
  }) async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      await _api.adjustBalance(memberId, AdjustBalanceReq(
        amount: amount,
        type: type,
        remark: remark,
        version: version,
      ));
      await loadMember(memberId);
      return true;
    } catch (e) {
      _error = e.toString();
      _loading = false;
      notifyListeners();
      return false;
    }
  }
  void clearError() {
    _error = null;
    notifyListeners();
  }
}