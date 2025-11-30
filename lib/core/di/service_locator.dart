/// Service Locator for dependency injection
///
/// Provides centralized service registration and retrieval.
/// Supports singleton, lazy singleton, and factory patterns.
library;

/// Abstract interface for service locator
abstract class ServiceLocator {
  /// Register a singleton instance
  void registerSingleton<T extends Object>(T instance);

  /// Register a lazy singleton (created on first access)
  void registerLazySingleton<T extends Object>(T Function() factory);

  /// Register a factory (new instance each time)
  void registerFactory<T extends Object>(T Function() factory);

  /// Get a registered service
  T get<T extends Object>();

  /// Check if a service is registered
  bool isRegistered<T extends Object>();

  /// Reset all registrations (useful for testing)
  void reset();
}

/// Registration types
enum _RegistrationType { singleton, lazySingleton, factory }

/// Registration entry
class _Registration<T> {
  final _RegistrationType type;
  final T? instance;
  final T Function()? factory;
  T? _lazyInstance;

  _Registration.singleton(T this.instance)
      : type = _RegistrationType.singleton,
        factory = null;

  _Registration.lazySingleton(T Function() this.factory)
      : type = _RegistrationType.lazySingleton,
        instance = null;

  _Registration.factory(T Function() this.factory)
      : type = _RegistrationType.factory,
        instance = null;

  T resolve() {
    switch (type) {
      case _RegistrationType.singleton:
        return instance as T;
      case _RegistrationType.lazySingleton:
        _lazyInstance ??= factory!();
        return _lazyInstance as T;
      case _RegistrationType.factory:
        return factory!();
    }
  }
}

/// Default implementation of ServiceLocator
class ServiceLocatorImpl implements ServiceLocator {
  ServiceLocatorImpl._();

  static final ServiceLocatorImpl _instance = ServiceLocatorImpl._();

  /// Get the singleton instance
  static ServiceLocatorImpl get instance => _instance;

  final Map<Type, _Registration> _registrations = {};

  @override
  void registerSingleton<T extends Object>(T instance) {
    _checkNotRegistered<T>();
    _registrations[T] = _Registration<T>.singleton(instance);
  }

  @override
  void registerLazySingleton<T extends Object>(T Function() factory) {
    _checkNotRegistered<T>();
    _registrations[T] = _Registration<T>.lazySingleton(factory);
  }

  @override
  void registerFactory<T extends Object>(T Function() factory) {
    _checkNotRegistered<T>();
    _registrations[T] = _Registration<T>.factory(factory);
  }

  @override
  T get<T extends Object>() {
    final registration = _registrations[T];
    if (registration == null) {
      throw ServiceNotRegisteredException(T);
    }
    return registration.resolve() as T;
  }

  @override
  bool isRegistered<T extends Object>() {
    return _registrations.containsKey(T);
  }

  @override
  void reset() {
    _registrations.clear();
  }

  void _checkNotRegistered<T>() {
    if (_registrations.containsKey(T)) {
      throw ServiceAlreadyRegisteredException(T);
    }
  }
}

/// Exception thrown when a service is not registered
class ServiceNotRegisteredException implements Exception {
  final Type type;

  ServiceNotRegisteredException(this.type);

  @override
  String toString() => 'ServiceNotRegisteredException: $type is not registered';
}

/// Exception thrown when trying to register an already registered service
class ServiceAlreadyRegisteredException implements Exception {
  final Type type;

  ServiceAlreadyRegisteredException(this.type);

  @override
  String toString() =>
      'ServiceAlreadyRegisteredException: $type is already registered';
}

/// Global service locator instance for convenience
final sl = ServiceLocatorImpl.instance;
