import 'dart:async' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i7;
import 'package:tower_desktop_app/core/error/result.dart' as _i4;
import 'package:tower_desktop_app/core/network/api_response.dart' as _i5;
import 'package:tower_desktop_app/features/purchase_order/models.dart' as _i6;
import 'package:tower_desktop_app/features/purchase_order/purchase_order_repository.dart'
    as _i2;
class MockPurchaseOrderRepository extends _i1.Mock
    implements _i2.PurchaseOrderRepository {
  MockPurchaseOrderRepository() {
    _i1.throwOnMissingStub(this);
  }
  @override
  _i3.Future<
      _i4.Result<_i5.PageResponse<_i6.PurchaseOrder>>> getPurchaseOrders({
    int? page = 1,
    int? pageSize = 10,
    int? storeId,
    int? supplierId,
    int? status,
    String? date,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPurchaseOrders,
          [],
          {
            #page: page,
            #pageSize: pageSize,
            #storeId: storeId,
            #supplierId: supplierId,
            #status: status,
            #date: date,
          },
        ),
        returnValue:
            _i3.Future<_i4.Result<_i5.PageResponse<_i6.PurchaseOrder>>>.value(
                _i7.dummyValue<_i4.Result<_i5.PageResponse<_i6.PurchaseOrder>>>(
          this,
          Invocation.method(
            #getPurchaseOrders,
            [],
            {
              #page: page,
              #pageSize: pageSize,
              #storeId: storeId,
              #supplierId: supplierId,
              #status: status,
              #date: date,
            },
          ),
        )),
      ) as _i3.Future<_i4.Result<_i5.PageResponse<_i6.PurchaseOrder>>>);
  @override
  _i3.Future<_i4.Result<_i6.PurchaseOrder?>> getPurchaseOrder(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPurchaseOrder,
          [id],
        ),
        returnValue: _i3.Future<_i4.Result<_i6.PurchaseOrder?>>.value(
            _i7.dummyValue<_i4.Result<_i6.PurchaseOrder?>>(
          this,
          Invocation.method(
            #getPurchaseOrder,
            [id],
          ),
        )),
      ) as _i3.Future<_i4.Result<_i6.PurchaseOrder?>>);
  @override
  _i3.Future<_i4.Result<_i6.PurchaseOrder?>> createPurchaseOrder(
          _i6.CreatePurchaseOrderRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #createPurchaseOrder,
          [request],
        ),
        returnValue: _i3.Future<_i4.Result<_i6.PurchaseOrder?>>.value(
            _i7.dummyValue<_i4.Result<_i6.PurchaseOrder?>>(
          this,
          Invocation.method(
            #createPurchaseOrder,
            [request],
          ),
        )),
      ) as _i3.Future<_i4.Result<_i6.PurchaseOrder?>>);
  @override
  _i3.Future<_i4.Result<void>> confirmPurchaseOrder(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #confirmPurchaseOrder,
          [id],
        ),
        returnValue:
            _i3.Future<_i4.Result<void>>.value(_i7.dummyValue<_i4.Result<void>>(
          this,
          Invocation.method(
            #confirmPurchaseOrder,
            [id],
          ),
        )),
      ) as _i3.Future<_i4.Result<void>>);
  @override
  _i3.Future<_i4.Result<void>> cancelPurchaseOrder(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #cancelPurchaseOrder,
          [id],
        ),
        returnValue:
            _i3.Future<_i4.Result<void>>.value(_i7.dummyValue<_i4.Result<void>>(
          this,
          Invocation.method(
            #cancelPurchaseOrder,
            [id],
          ),
        )),
      ) as _i3.Future<_i4.Result<void>>);
  @override
  _i3.Future<_i4.Result<void>> deletePurchaseOrder(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #deletePurchaseOrder,
          [id],
        ),
        returnValue:
            _i3.Future<_i4.Result<void>>.value(_i7.dummyValue<_i4.Result<void>>(
          this,
          Invocation.method(
            #deletePurchaseOrder,
            [id],
          ),
        )),
      ) as _i3.Future<_i4.Result<void>>);
}
