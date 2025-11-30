import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:tower_desktop_app/core/di/service_locator.dart';

/// Property-based tests for ServiceLocator
/// Using random data generation to verify properties across many inputs
void main() {
  late ServiceLocatorImpl locator;

  setUp(() {
    locator = ServiceLocatorImpl.instance;
    locator.reset();
  });

  tearDown(() {
    locator.reset();
  });

  group('Property 1: Service Locator Registration and Retrieval', () {
    /// **Feature: code-architecture-optimization, Property 1: Service Locator Registration and Retrieval**
    /// *For any* service type T registered with the service locator,
    /// calling `get<T>()` SHALL return an instance of type T.
    /// **Validates: Requirements 1.2**

    test('singleton registration and retrieval returns same instance', () {
      // Property: For any singleton, get() returns the exact same instance
      for (var i = 0; i < 100; i++) {
        locator.reset();
        final service = _TestService(Random().nextInt(10000));
        locator.registerSingleton<_TestService>(service);

        final retrieved1 = locator.get<_TestService>();
        final retrieved2 = locator.get<_TestService>();

        expect(retrieved1, same(service));
        expect(retrieved2, same(service));
        expect(identical(retrieved1, retrieved2), isTrue);
      }
    });

    test('lazy singleton registration returns same instance on multiple gets',
        () {
      // Property: For any lazy singleton, all get() calls return same instance
      for (var i = 0; i < 100; i++) {
        locator.reset();
        var callCount = 0;
        final value = Random().nextInt(10000);

        locator.registerLazySingleton<_TestService>(() {
          callCount++;
          return _TestService(value);
        });

        final retrieved1 = locator.get<_TestService>();
        final retrieved2 = locator.get<_TestService>();
        final retrieved3 = locator.get<_TestService>();

        expect(callCount, equals(1)); // Factory called only once
        expect(identical(retrieved1, retrieved2), isTrue);
        expect(identical(retrieved2, retrieved3), isTrue);
      }
    });

    test('factory registration returns new instance each time', () {
      // Property: For any factory, each get() returns a new instance
      for (var i = 0; i < 100; i++) {
        locator.reset();
        var callCount = 0;

        locator.registerFactory<_TestService>(() {
          callCount++;
          return _TestService(callCount);
        });

        final retrieved1 = locator.get<_TestService>();
        final retrieved2 = locator.get<_TestService>();
        final retrieved3 = locator.get<_TestService>();

        expect(callCount, equals(3));
        expect(identical(retrieved1, retrieved2), isFalse);
        expect(identical(retrieved2, retrieved3), isFalse);
      }
    });
  });

  group('Property 2: Service Locator Dependency Resolution', () {
    /// **Feature: code-architecture-optimization, Property 2: Service Locator Dependency Resolution**
    /// *For any* service A that depends on service B, if B is registered before A,
    /// then registering and retrieving A SHALL succeed.
    /// **Validates: Requirements 1.3**

    test('dependent services resolve correctly when registered in order', () {
      // Property: For any dependency chain A->B->C, if registered C,B,A order, all resolve
      for (var i = 0; i < 100; i++) {
        locator.reset();
        final baseValue = Random().nextInt(10000);

        // Register base service first
        locator.registerSingleton<_BaseService>(_BaseService(baseValue));

        // Register dependent service that uses base service
        locator.registerLazySingleton<_DependentService>(() {
          final base = locator.get<_BaseService>();
          return _DependentService(base);
        });

        // Register top-level service that uses dependent service
        locator.registerLazySingleton<_TopLevelService>(() {
          final dependent = locator.get<_DependentService>();
          return _TopLevelService(dependent);
        });

        final topLevel = locator.get<_TopLevelService>();
        expect(topLevel.dependent.base.value, equals(baseValue));
      }
    });

    test('unregistered dependency throws ServiceNotRegisteredException', () {
      locator.reset();

      // Try to get unregistered service
      expect(
        () => locator.get<_TestService>(),
        throwsA(isA<ServiceNotRegisteredException>()),
      );
    });
  });

  group('Property 3: Service Locator Reset for Testing', () {
    /// **Feature: code-architecture-optimization, Property 3: Service Locator Reset for Testing**
    /// *For any* set of registered services, calling `reset()` followed by new registrations
    /// SHALL result in the new registrations taking effect.
    /// **Validates: Requirements 1.4**

    test('reset clears all registrations', () {
      // Property: For any set of registrations, reset() clears them all
      for (var i = 0; i < 100; i++) {
        locator.reset();

        // Register some services
        locator.registerSingleton<_TestService>(_TestService(i));
        locator.registerSingleton<_BaseService>(_BaseService(i));

        expect(locator.isRegistered<_TestService>(), isTrue);
        expect(locator.isRegistered<_BaseService>(), isTrue);

        // Reset
        locator.reset();

        expect(locator.isRegistered<_TestService>(), isFalse);
        expect(locator.isRegistered<_BaseService>(), isFalse);
      }
    });

    test('new registrations after reset take effect', () {
      // Property: For any value V1 and V2, after reset, new registration with V2 returns V2
      for (var i = 0; i < 100; i++) {
        locator.reset();
        final value1 = Random().nextInt(10000);
        final value2 = Random().nextInt(10000) + 10000; // Ensure different

        // First registration
        locator.registerSingleton<_TestService>(_TestService(value1));
        expect(locator.get<_TestService>().value, equals(value1));

        // Reset and re-register with different value
        locator.reset();
        locator.registerSingleton<_TestService>(_TestService(value2));
        expect(locator.get<_TestService>().value, equals(value2));
      }
    });
  });

  group('isRegistered', () {
    test('returns false for unregistered types', () {
      locator.reset();
      expect(locator.isRegistered<_TestService>(), isFalse);
    });

    test('returns true for registered types', () {
      locator.reset();
      locator.registerSingleton<_TestService>(_TestService(1));
      expect(locator.isRegistered<_TestService>(), isTrue);
    });
  });

  group('duplicate registration', () {
    test('throws ServiceAlreadyRegisteredException', () {
      locator.reset();
      locator.registerSingleton<_TestService>(_TestService(1));

      expect(
        () => locator.registerSingleton<_TestService>(_TestService(2)),
        throwsA(isA<ServiceAlreadyRegisteredException>()),
      );
    });
  });
}

// Test helper classes
class _TestService {
  final int value;
  _TestService(this.value);
}

class _BaseService {
  final int value;
  _BaseService(this.value);
}

class _DependentService {
  final _BaseService base;
  _DependentService(this.base);
}

class _TopLevelService {
  final _DependentService dependent;
  _TopLevelService(this.dependent);
}
