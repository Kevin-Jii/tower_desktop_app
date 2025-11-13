# Tower Desktop App - AI Coding Guidelines

## Project Overview
Flutter desktop application for multi-store dish reporting and menu permission management system. Built with layered architecture using Provider for state management, Dio for HTTP, and Freezed for immutable models.

## Architecture Patterns

### Core Structure
- **Entry**: `main.dart` (minimal bootstrap)
- **App Root**: `app.dart` (Provider setup, routing, themes)
- **Core Layer**: `lib/core/` (network, widgets, constants, theme)
- **Features**: `lib/features/` (auth, menu, dish, store, user, etc.)

### State Management
Use Provider pattern with ChangeNotifier:
```dart
class FeatureProvider extends ChangeNotifier {
  // State fields
  List<Model> _items = [];
  
  // Getters
  List<Model> get items => _items;
  
  // Actions that notify
  Future<void> load() async {
    _items = await api.getItems();
    notifyListeners();
  }
}
```

### API Communication
**Standard Response Format**:
```json
{
  "code": 200,
  "message": "success", 
  "data": { /* payload */ },
  "meta": { /* pagination */ }
}
```

**ApiClient Usage**:
```dart
// Simple request
final user = await apiClient.get<User>(
  '/users/1',
  converter: (json) => User.fromJson(json),
);

// Paginated request  
final page = await apiClient.getPage<User>(
  '/users',
  itemParser: (json) => User.fromJson(json),
);
```

**Key Files**: `lib/core/network/api_client.dart`, `lib/core/network/api_response.dart`

### Authentication & Permissions
**Session Management**: Singleton `SessionManager` persists JWT tokens and user info to SharedPreferences.

**Permission System**: 
- Permissions loaded from menu API as strings like `"dish:add"`, `"store:list"`
- UI controlled via `PermissionGate` widget:
```dart
PermissionGate(
  required: 'dish:add',
  child: ElevatedButton(onPressed: addDish, child: Text('Add Dish')),
)
```

**Key Files**: `lib/features/auth/session_manager.dart`, `lib/features/auth/permission_gate.dart`

### Dynamic Menu System
**Menu Types**: 
- `1` = Directory (grouping only)
- `2` = Page (routable)  
- `3` = Button (permissions only)

**Component Mapping**: RouteManager maps `component` field to page widgets:
```dart
switch (component) {
  case 'system/user/index': return const UserManagementPage();
  case 'dish/list/index': return const DishManagementScope();
}
```

**Key Files**: `lib/core/routes/route_manager.dart`, `lib/features/menu/menu_provider.dart`

## Development Workflows

### Setup & Dependencies
```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Code Generation
**Freezed Models**: Run after modifying `*.dart` files with `@freezed` annotations:
```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Running & Building
**Development**:
```bash
flutter run -d windows
```

**Production Build**:
```bash
flutter build windows
# Output: build/windows/x64/runner/Release/
```

### API Configuration
Update backend URL in `lib/core/network/api_client.dart`:
```dart
static const String baseUrl = 'http://your-backend:port/api/v1';
```

## Code Conventions

### File Organization
- **APIs**: `{feature}_api.dart` - Dio calls with converters
- **Models**: `{feature}/models.dart` - Freezed classes with JsonSerializable
- **Providers**: `{feature}_provider.dart` - State management
- **Screens**: `{feature}_screen.dart` or `{feature}_management_page.dart`

### Naming Patterns
- **Permission Codes**: `feature:action` (e.g., `dish:add`, `system:user:edit`)
- **Component Paths**: `module/submodule/index` (e.g., `system/user/index`)
- **Route Names**: Defined in `lib/core/constants/app_constants.dart`

### Error Handling
- API errors throw `ApiException` 
- Use try/catch in async methods
- Display user-friendly messages from `response.message`

### UI Patterns
- Use `PermissionGate` for conditional rendering
- Follow TDesign component library
- Support multiple themes via `ThemeProvider`

## Key Reference Files
- `lib/app.dart` - App structure and provider setup
- `lib/core/network/api_client.dart` - HTTP client patterns
- `lib/features/auth/session_manager.dart` - Auth state management
- `lib/core/routes/route_manager.dart` - Menu-to-page routing
- `lib/features/menu/menu_provider.dart` - Dynamic menu loading
- `pubspec.yaml` - Dependencies and build config

## Common Patterns
- **Deferred Loading**: Use `_DeferredHome` pattern for post-auth initialization
- **Smart Requests**: Use `postSmart`/`putSmart` for automatic null filtering
- **Pagination**: Always use `getPage`/`postPage` for list endpoints
- **Icon Mapping**: Use `TdIconMapper.build()` for consistent iconography