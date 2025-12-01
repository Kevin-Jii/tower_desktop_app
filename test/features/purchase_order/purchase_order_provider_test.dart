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
    provider = PurchaseOrderProvider(mockRepository);
  });

  group('PurchaseOrderProvider', () {
    /// **Feature: supplier-purchase-order-ui, Property 16: Order status transitions are valid**
    /// *For any* pending order, confirming should change status to confirmed (1),
    /// and cancelling should change status to cancelled (3). Non-pending orders
    /// should not allow status changes.
    /// **Validates: Requirements 5.1, 5.2, 5.3**
    group('Property 16: Order status transitions are valid', () {
      test('confirming a pending order changes status to confirmed (1)', () async {
        const orderId = 1;
        const pendingStatus = 0;
        const confirmedStatus = 1;

        when(mockRepository.confirmPurchaseOrder(orderId))
            .thenAnswer((_) async => Result.success(
                  PurchaseOrder(
                    id: orderId,
                    orderNo: 'PO001',
                    storeId: 1,
                    totalAmount: 100.0,
                    status: confirmedStatus,
                    reportDate: '2024-01-01',
                  ),
                ));

        when(mockRepository.getPurchaseOrders(
          page: anyNamed('page'),
          pageSize: anyNamed('pageSize'),
          storeId: anyNamed('storeId'),
          supplierId: anyNamed('supplierId'),
          status: anyNamed('status'),
          startDate: anyNamed('startDate'),
          endDate: anyNamed('endDate'),
        )).thenAnswer((_) async => Result.success(PageResponse(
              list: [],
              total: 0,
              page: 1,
              pageSize: 10,
            )));

        final result = await provider.confirmOrder(orderId);

        expect(result, isTrue);
        expect(provider.currentOrder?.status, equals(confirmedStatus),
            reason: 'Confirmed order should have status=1');
      });

      test('cancelling a pending order changes status to cancelled (3)', () async {
        const orderId = 2;
        const cancelledStatus = 3;

        when(mockRepository.cancelPurchaseOrder(orderId))
            .thenAnswer((_) async => Result.success(
                  PurchaseOrder(
                    id: orderId,
                    orderNo: 'PO002',
                    storeId: 1,
                    totalAmount: 200.0,
                    status: cancelledStatus,
                    reportDate: '2024-01-02',
                  ),
                ));

        when(mockRepository.getPurchaseOrders(
          page: anyNamed('page'),
          pageSize: anyNamed('pageSize'),
          storeId: anyNamed('storeId'),
          supplierId: anyNamed('supplierId'),
          status: anyNamed('status'),
          startDate: anyNamed('startDate'),
          endDate: anyNamed('endDate'),
        )).thenAnswer((_) async => Result.success(PageResponse(
              list: [],
              total: 0,
              page: 1,
              pageSize: 10,
            )));

        final result = await provider.cancelOrder(orderId);

        expect(result, isTrue);
        expect(provider.currentOrder?.status, equals(cancelledStatus),
            reason: 'Cancelled order should have status=3');
      });
    });

    /// **Feature: supplier-purchase-order-ui, Property 14: Order filter returns matching orders**
    /// *For any* filter criteria (date range, status, store), all returned orders
    /// should satisfy all applied filter conditions.
    /// **Validates: Requirements 4.2**
    group('Property 14: Order filter returns matching orders', () {
      test('filtering by status returns only orders with that status', () async {
        const filterStatus = 1; // confirmed
        final confirmedOrders = [
          const PurchaseOrder(id: 1, orderNo: 'PO001', storeId: 1, totalAmount: 100.0, status: 1, reportDate: '2024-01-01'),
          const PurchaseOrder(id: 2, orderNo: 'PO002', storeId: 2, totalAmount: 200.0, status: 1, reportDate: '2024-01-02'),
        ];

        when(mockRepository.getPurchaseOrders(
          page: 1,
          pageSize: 10,
          storeId: null,
          supplierId: null,
          status: filterStatus,
          startDate: null,
          endDate: null,
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
          const PurchaseOrder(id: 1, orderNo: 'PO001', storeId: filterStoreId, totalAmount: 100.0, status: 0, reportDate: '2024-01-01'),
        ];

        when(mockRepository.getPurchaseOrders(
          page: 1,
          pageSize: 10,
          storeId: filterStoreId,
          supplierId: null,
          status: null,
          startDate: null,
          endDate: null,
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
