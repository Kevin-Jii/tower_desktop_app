import 'package:flutter/foundation.dart';
import 'printer_api.dart';
import 'models.dart';
class PrinterProvider with ChangeNotifier {
  final PrinterApi _api;
  PrinterProvider(this._api);
  List<Printer> _printers = [];
  List<Printer> get printers => _printers;
  bool _loading = false;
  bool get loading => _loading;
  String? _error;
  String? get error => _error;
  int? _currentStoreId;
  int? get currentStoreId => _currentStoreId;
  Future<void> loadPrinters({required int storeId}) async {
    _currentStoreId = storeId;
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _printers = await _api.getPrinters(storeId: storeId);
      _error = null;
    } catch (e) {
      _error = e.toString();
      _printers = [];
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
  Future<bool> bindPrinter(BindPrinterReq request) async {
    try {
      await _api.bindPrinter(request);
      if (_currentStoreId != null) {
        await loadPrinters(storeId: _currentStoreId!);
      }
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
  Future<bool> updatePrinter(int id, UpdatePrinterReq request) async {
    try {
      await _api.updatePrinter(id, request);
      if (_currentStoreId != null) {
        await loadPrinters(storeId: _currentStoreId!);
      }
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
  Future<bool> deletePrinter(int id) async {
    try {
      await _api.deletePrinter(id);
      if (_currentStoreId != null) {
        await loadPrinters(storeId: _currentStoreId!);
      }
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
  Future<void> refreshPrinterStatus() async {
    if (_currentStoreId == null) return;
    await loadPrinters(storeId: _currentStoreId!);
  }
  Future<bool> setDefaultPrinter(int id) async {
    return await updatePrinter(id, const UpdatePrinterReq(isDefault: 1));
  }
  Future<bool> testPrint(int printerId) async {
    try {
      return await _api.testPrint(printerId: printerId);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
}