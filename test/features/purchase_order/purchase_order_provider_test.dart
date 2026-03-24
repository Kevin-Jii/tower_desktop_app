import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:tower_desktop_app/features/purchase_order/purchase_order_provider.dart';
import 'package:tower_desktop_app/features/purchase_order/purchase_order_repository.dart';
import 'package:tower_desktop_app/features/purchase_order/models.dart';
import 'package:tower_desktop_app/core/network/api_response.dart';
import 'package:tower_desktop_app/core/error/result.dart';
@GenerateMocks([PurchaseOrderRepository])
import 'purchase_order_provider_test.mocks.dart';
void main() {
  late PurchaseOrderProvider provider;
  late MockPurchaseOrderRepository mockRepository;
  setUp(() {
    mockRepository = MockPurchaseOrderRepository();
    provideDummy<Result<PageResponse<PurchaseOrder>>>(
        Result.success(PageResponse(list: [], total: 0, page: 1, pageSize: 10)));
    provideDummy<Result<PurchaseOrder?>>(Result.success(null));
    provideDummy<Result<void>>(Result.success(null));
    provider = PurchaseOrderProvider(mockRepository);
  });
  group('PurchaseOrderProvider', () {
    group('Property 16: Order status transitions are valid', () {
      test('confirming a pending order changes status to confirmed (2)', () async {
        const orderId = 1;
        const confirmedStatus = 2;
        when(mockRepository.confirmPurchaseOrder(orderId))
            .thenAnswer((_) async => Result.success(null));
        when(mockRepository.getPurchaseOrder(orderId))
            .thenAnswer((_) async => Result.success(
                  PurchaseOrder(
                    id: orderId,
                    orderNo: 'PO001',
                    storeId: 1,
                    totalAmount: 100.0,
                    status: confirmedStatus,
                    orderDate: '2024-01-01',
                  ),
                ));
        when(mockRepository.getPurchaseOrders(
          page: anyNamed('page'),
          pageSize: anyNamed('pageSize'),
          storeId: anyNamed('storeId'),
          supplierId: anyNamed('supplierId'),
          status: anyNamed('status'),
          date: anyNamed('date'),
        )).thenAnswer((_) async => Result.success(PageResponse(
              list: [],
              total: 0,
              page: 1,
              pageSize: 10,
            )));
        final result = await provider.confirmOrder(orderId);
        expect(result, isTrue);
        expect(provider.currentOrder?.status, equals(confirmedStatus),
            reason: 'Confirmed order should have status=2');
      });
      test('cancelling a pending order changes status to cancelled (4)', () async {
        const orderId = 2;
        const cancelledStatus = 4;
        when(mockRepository.cancelPurchaseOrder(orderId))
            .thenAnswer((_) async => Result.success(null));
        when(mockRepository.getPurchaseOrder(orderId))
            .thenAnswer((_) async => Result.success(
                  PurchaseOrder(
                    id: orderId,
                    orderNo: 'PO002',
                    storeId: 1,
                    totalAmount: 200.0,
                    status: cancelledStatus,
                    orderDate: '2024-01-02',
                  ),
                ));
        when(mockRepository.getPurchaseOrders(
          page: anyNamed('page'),
          pageSize: anyNamed('pageSize'),
          storeId: anyNamed('storeId'),
          supplierId: anyNamed('supplierId'),
          status: anyNamed('status'),
          date: anyNamed('date'),
        )).thenAnswer((_) async => Result.success(PageResponse(
              list: [],
              total: 0,
              page: 1,
              pageSize: 10,
            )));
        final result = await provider.cancelOrder(orderId);
        expect(result, isTrue);
        expect(provider.currentOrder?.status, equals(cancelledStatus),
            reason: 'Cancelled order should have status=4');
      });
    });
    group('Property 14: Order filter returns matching orders', () {
      test('filtering by status returns only orders with that status', () async {
        const filterStatus = 2; 
        final confirmedOrders = [
          const PurchaseOrder(id: 1, orderNo: 'PO001', storeId: 1, totalAmount: 100.0, status: 2, orderDate: '2024-01-01'),
          const PurchaseOrder(id: 2, orderNo: 'PO002', storeId: 2, totalAmount: 200.0, status: 2, orderDate: '2024-01-02'),
        ];
        when(mockRepository.getPurchaseOrders(
          page: 1,
          pageSize: 10,
          storeId: null,
          supplierId: null,
          status: filterStatus,
          date: null,
        )).thenAnswer((_) async => Result.success(PageResponse(
              list: confirmedOrders,
              total: 2,
              page: 1,
              pageSize: 10,
            )));
        await provider.loadOrders(page: 1, status: filterStatus);
        expect(provider.orders.length, 2);
        for (final order in provider.orders) {
          expect(order.status, equals(filterStatus),
              reason: 'All orders should have status=$filterStatus');
        }
      });
      test('filtering by store returns only orders for that store', () async {
        const filterStoreId = 1;
        final storeOrders = [
          const PurchaseOrder(id: 1, orderNo: 'PO001', storeId: filterStoreId, totalAmount: 100.0, status: 1, orderDate: '2024-01-01'),
        ];
        when(mockRepository.getPurchaseOrders(
          page: 1,
          pageSize: 10,
          storeId: filterStoreId,
          supplierId: null,
          status: null,
          date: null,
        )).thenAnswer((_) async => Result.success(PageResponse(
              list: storeOrders,
              total: 1,
              page: 1,
              pageSize: 10,
            )));
        await provider.loadOrders(page: 1, storeId: filterStoreId);
        expect(provider.orders.length, 1);
        for (final order in provider.orders) {
          expect(order.storeId, equals(filterStoreId),
              reason: 'All orders should belong to store $filterStoreId');
        }
      });
    });
  });
}