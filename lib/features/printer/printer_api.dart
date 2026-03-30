import '../../core/network/api_client.dart';
import '../../core/constants/app_constants.dart';
import 'models.dart';
class PrinterApi {
  final ApiClient _client;
  PrinterApi(this._client);
  Future<List<Printer>> getPrinters({required int storeId}) async {
    return await _client.getSimpleList<Printer>(
      path: ApiPaths.printers,
      fromJson: Printer.fromJson,
      queryParameters: {'store_id': storeId},
    );
  }
  Future<Printer?> bindPrinter(BindPrinterReq request) async {
    return await _client.postSmart<Printer>(
      path: '${ApiPaths.printers}/bind',
      data: request.toJson(),
      fromJson: Printer.fromJson,
    );
  }
  Future<Printer?> updatePrinter(int id, UpdatePrinterReq request) async {
    return await _client.putSmart<Printer>(
      path: '${ApiPaths.printers}/$id',
      data: request.toJson(),
      fromJson: Printer.fromJson,
    );
  }
  Future<void> deletePrinter(int id) async {
    await _client.deleteSmart(path: '${ApiPaths.printers}/$id');
  }
  Future<Printer?> getDefaultPrinter({required int storeId}) async {
    try {
      return await _client.getSmart<Printer>(
        path: '${ApiPaths.printers}/default',
        fromJson: Printer.fromJson,
        queryParameters: {'store_id': storeId},
      );
    } catch (e) {
      return null;
    }
  }
  Future<Map<String, dynamic>?> getPrinterStatus({required String sn}) async {
    try {
      return await _client.get<Map<String, dynamic>>(
        '${ApiPaths.printers}/status',
        queryParameters: {'sn': sn},
      );
    } catch (e) {
      return null;
    }
  }
  Future<List<Map<String, dynamic>>?> batchGetPrinterStatus(
      {required int storeId}) async {
    try {
      final list = await _client.get<List<dynamic>>(
        '${ApiPaths.printers}/status/batch',
        queryParameters: {'store_id': storeId},
      );
      return list?.map((e) => e as Map<String, dynamic>).toList();
    } catch (e) {
      return null;
    }
  }
  Future<bool> testPrint({required int printerId}) async {
    try {
      await _client.post(
        '${ApiPaths.printers}/$printerId/test',
        data: {},
      );
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<bool> printPurchaseOrder(
      {required int printerId, required int orderId}) async {
    try {
      await _client.post(
        '${ApiPaths.printers}/$printerId/print/purchase-order',
        data: {'order_id': orderId},
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
