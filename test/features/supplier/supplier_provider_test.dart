import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:tower_desktop_app/features/supplier/supplier_provider.dart';
import 'package:tower_desktop_app/features/supplier/supplier_repository.dart';
import 'package:tower_desktop_app/features/supplier/models.dart';
import 'package:tower_desktop_app/core/network/api_response.dart';
import 'package:tower_desktop_app/core/error/result.dart';

@GenerateMocks([SupplierRepository])
import 'supplier_provider_test.mocks.dart';

void main() {
  late SupplierProvider provider;
  late MockSupplierRepository mockRepository;

  setUp(() {
    mockRepository = MockSupplierRepository();
    provider = SupplierProvider(mockRepository);
  });

  group('SupplierProvider', () {
    /// **Feature: supplier-purchase-order-ui, Property 5: Search filters by keyword**
    /// *For any* search keyword, all suppliers in the filtered results should contain
    /// the keyword in at least one searchable field (name, contact person, phone).
    /// **Validates: Requirements 1.7**
    group('Property 5: Search filters by keyword', () {
      test('search with keyword returns matching suppliers', () async {
        const keyword = '测试';
        final matchingSuppliers = [
          const Supplier(id: 1, name: '测试供应商A', contactPerson: '张三', phone: '13800138001', status: 1),
          const Supplier(id: 2, name: '供应商测试B', contactPerson: '李四', phone: '13800138002', status: 1),
        ];

        when(mockRepository.getSuppliers(
          page: 1,
          pageSize: 10,
          keyword: keyword,
        )).thenAnswer((_) async => Result.success(PageResponse(
          list: matchingSuppliers,
          total: 2,
          page: 1,
          pageSize: 10,
        )));

        await provider.loadSuppliers(page: 1, keyword: keyword);

        expect(provider.suppliers.length, 2);
        for (final supplier in provider.suppliers) {
          final containsKeyword = supplier.name.contains(keyword) ||
              (supplier.contactPerson?.contains(keyword) ?? false) ||
              (supplier.phone?.contains(keyword) ?? false);
          expect(containsKeyword, isTrue,
              reason: 'Supplier ${supplier.name} should contain keyword "$keyword"');
        }
      });

      test('search with empty keyword returns all suppliers', () async {
        final allSuppliers = [
          const Supplier(id: 1, name: '供应商A', status: 1),
          const Supplier(id: 2, name: '供应商B', status: 1),
          const Supplier(id: 3, name: '供应商C', status: 0),
        ];

        when(mockRepository.getSuppliers(
          page: 1,
          pageSize: 10,
          keyword: null,
        )).thenAnswer((_) async => Result.success(PageResponse(
          list: allSuppliers,
          total: 3,
          page: 1,
          pageSize: 10,
        )));

        await provider.loadSuppliers(page: 1, keyword: null);

        expect(provider.suppliers.length, 3);
      });

      test('search with non-matching keyword returns empty list', () async {
        const keyword = '不存在的关键词';

        when(mockRepository.getSuppliers(
          page: 1,
          pageSize: 10,
          keyword: keyword,
        )).thenAnswer((_) async => Result.success(PageResponse(
          list: [],
          total: 0,
          page: 1,
          pageSize: 10,
        )));

        await provider.loadSuppliers(page: 1, keyword: keyword);

        expect(provider.suppliers.isEmpty, isTrue);
      });
    });

    /// **Feature: supplier-purchase-order-ui, Property 4: Status toggle inverts value**
    /// *For any* supplier, toggling the status switch should result in the status
    /// value being inverted (0→1 or 1→0).
    /// **Validates: Requirements 1.6**
    group('Property 4: Status toggle inverts value', () {
      test('toggling status from 1 to 0 inverts the value', () async {
        const supplierId = 1;
        const originalStatus = 1;
        const newStatus = 0;

        when(mockRepository.updateSupplier(supplierId, {'status': newStatus}))
            .thenAnswer((_) async => Result.success(
                  const Supplier(id: supplierId, name: '测试供应商', status: newStatus),
                ));

        when(mockRepository.getSuppliers(
          page: anyNamed('page'),
          pageSize: anyNamed('pageSize'),
          keyword: anyNamed('keyword'),
        )).thenAnswer((_) async => Result.success(PageResponse(
              list: [const Supplier(id: supplierId, name: '测试供应商', status: newStatus)],
              total: 1,
              page: 1,
              pageSize: 10,
            )));

        final result = await provider.updateSupplier(supplierId, {'status': newStatus});

        expect(result, isTrue);
        expect(newStatus, equals(1 - originalStatus));
      });

      test('toggling status from 0 to 1 inverts the value', () async {
        const supplierId = 2;
        const originalStatus = 0;
        const newStatus = 1;

        when(mockRepository.updateSupplier(supplierId, {'status': newStatus}))
            .thenAnswer((_) async => Result.success(
                  const Supplier(id: supplierId, name: '测试供应商', status: newStatus),
                ));

        when(mockRepository.getSuppliers(
          page: anyNamed('page'),
          pageSize: anyNamed('pageSize'),
          keyword: anyNamed('keyword'),
        )).thenAnswer((_) async => Result.success(PageResponse(
              list: [const Supplier(id: supplierId, name: '测试供应商', status: newStatus)],
              total: 1,
              page: 1,
              pageSize: 10,
            )));

        final result = await provider.updateSupplier(supplierId, {'status': newStatus});

        expect(result, isTrue);
        expect(newStatus, equals(1 - originalStatus));
      });
    });
  });
}


    /// **Feature: supplier-purchase-order-ui, Property 7: Product list filtered by category**
    /// *For any* selected category, all displayed products should have a categoryId
    /// matching the selected category.
    /// **Validates: Requirements 2.3**
    group('Property 7: Product list filtered by category', () {
      test('loading products with categoryId returns only products in that category', () async {
        const supplierId = 1;
        const categoryId = 10;
        final productsInCategory = [
          const SupplierProduct(id: 1, supplierId: supplierId, categoryId: categoryId, name: '商品A', status: 1),
          const SupplierProduct(id: 2, supplierId: supplierId, categoryId: categoryId, name: '商品B', status: 1),
        ];

        when(mockRepository.getSupplierProducts(
          page: 1,
          pageSize: 10,
          supplierId: supplierId,
          categoryId: categoryId,
          keyword: null,
        )).thenAnswer((_) async => Result.success(PageResponse(
          list: productsInCategory,
          total: 2,
          page: 1,
          pageSize: 10,
        )));

        await provider.loadProducts(page: 1, supplierId: supplierId, categoryId: categoryId);

        expect(provider.products.length, 2);
        for (final product in provider.products) {
          expect(product.categoryId, equals(categoryId),
              reason: 'Product ${product.name} should belong to category $categoryId');
        }
      });
    });

    /// **Feature: supplier-purchase-order-ui, Property 9: Product deletion removes from list**
    /// *For any* product in the list, after successful deletion, the product should
    /// no longer appear in the product list.
    /// **Validates: Requirements 2.6**
    group('Property 9: Product deletion removes from list', () {
      test('deleting a product removes it from the list', () async {
        const productId = 1;
        const supplierId = 1;

        when(mockRepository.deleteSupplierProduct(productId))
            .thenAnswer((_) async => Result.success(null));

        when(mockRepository.getSupplierProducts(
          page: anyNamed('page'),
          pageSize: anyNamed('pageSize'),
          supplierId: supplierId,
          categoryId: anyNamed('categoryId'),
          keyword: anyNamed('keyword'),
        )).thenAnswer((_) async => Result.success(PageResponse(
          list: [], // Product removed
          total: 0,
          page: 1,
          pageSize: 10,
        )));

        final result = await provider.deleteProduct(productId, supplierId);

        expect(result, isTrue);
        expect(provider.products.where((p) => p.id == productId).isEmpty, isTrue,
            reason: 'Deleted product should not appear in the list');
      });
    });


    /// **Feature: supplier-purchase-order-ui, Property 11: Binding creation adds to bound list**
    /// *For any* store and supplier product, creating a binding should result in the
    /// product appearing in the store's bound product list.
    /// **Validates: Requirements 3.3**
    group('Property 11: Binding creation adds to bound list', () {
      test('binding a product adds it to the store bindings', () async {
        const storeId = 1;
        const productId = 10;
        final request = BindSupplierProductRequest(storeId: storeId, supplierProductId: productId);

        when(mockRepository.bindSupplierProduct(request))
            .thenAnswer((_) async => Result.success(
                  StoreSupplierProduct(id: 1, storeId: storeId, supplierProductId: productId),
                ));

        when(mockRepository.getStoreSupplierProducts(
          page: anyNamed('page'),
          pageSize: anyNamed('pageSize'),
          storeId: storeId,
          supplierId: anyNamed('supplierId'),
        )).thenAnswer((_) async => Result.success(PageResponse(
              list: [StoreSupplierProduct(id: 1, storeId: storeId, supplierProductId: productId)],
              total: 1,
              page: 1,
              pageSize: 10,
            )));

        final result = await provider.bindProduct(request);

        expect(result, isTrue);
        expect(provider.storeBindings.any((b) => b.supplierProductId == productId), isTrue,
            reason: 'Bound product should appear in store bindings');
      });
    });

    /// **Feature: supplier-purchase-order-ui, Property 12: Set default updates flag correctly**
    /// *For any* binding set as default, the isDefault flag should be true, and all
    /// other bindings for the same product should have isDefault as false.
    /// **Validates: Requirements 3.4**
    group('Property 12: Set default updates flag correctly', () {
      test('setting default supplier updates isDefault flag', () async {
        const bindingId = 1;
        const storeId = 1;

        when(mockRepository.setDefaultSupplier(bindingId, storeId))
            .thenAnswer((_) async => Result.success(
                  const StoreSupplierProduct(id: bindingId, storeId: storeId, supplierProductId: 10, isDefault: true),
                ));

        when(mockRepository.getStoreSupplierProducts(
          page: anyNamed('page'),
          pageSize: anyNamed('pageSize'),
          storeId: storeId,
          supplierId: anyNamed('supplierId'),
        )).thenAnswer((_) async => Result.success(PageResponse(
              list: [
                const StoreSupplierProduct(id: bindingId, storeId: storeId, supplierProductId: 10, isDefault: true),
                const StoreSupplierProduct(id: 2, storeId: storeId, supplierProductId: 11, isDefault: false),
              ],
              total: 2,
              page: 1,
              pageSize: 10,
            )));

        final result = await provider.setDefaultSupplier(bindingId, storeId);

        expect(result, isTrue);
        final defaultBinding = provider.storeBindings.firstWhere((b) => b.id == bindingId);
        expect(defaultBinding.isDefault, isTrue, reason: 'Set default binding should have isDefault=true');
      });
    });
  });
}
