import '../../core/utils/value_parsers.dart';
import '../dish/dish_category_api.dart';
import '../dish/models.dart';

// 注意: MenuReport 类保留用于向后兼容，现在主要使用 MenuReportOrder 和 MenuReportItem
@Deprecated('Use MenuReportOrder and MenuReportItem instead')
class MenuReport {
  final int id;
  final int dishId;
  final int quantity;
  final String? remark;
  final int? storeId;
  final int? userId;
  final String? createdAt;
  final String? updatedAt;
  final MenuReportDish? dish;
  final MenuReportStore? store;
  final MenuReportUser? user;

  const MenuReport({
    required this.id,
    required this.dishId,
    required this.quantity,
    this.remark,
    this.storeId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.dish,
    this.store,
    this.user,
  });

  factory MenuReport.fromJson(Map<String, dynamic> json) {
    return MenuReport(
      id: parseInt(json['id']),
      dishId: parseInt(json['dish_id']),
      quantity: parseInt(json['quantity']),
      remark: parseStringNullable(json['remark']),
      storeId: parseIntNullable(json['store_id']),
      userId: parseIntNullable(json['user_id']),
      createdAt: parseStringNullable(json['created_at']),
      updatedAt: parseStringNullable(json['updated_at']),
      dish: json['dish'] is Map<String, dynamic>
          ? MenuReportDish.fromJson(
              Map<String, dynamic>.from(json['dish'] as Map),
            )
          : null,
      store: json['store'] is Map<String, dynamic>
          ? MenuReportStore.fromJson(
              Map<String, dynamic>.from(json['store'] as Map),
            )
          : null,
      user: json['user'] is Map<String, dynamic>
          ? MenuReportUser.fromJson(
              Map<String, dynamic>.from(json['user'] as Map),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dish_id': dishId,
      'quantity': quantity,
      if (remark != null) 'remark': remark,
      if (storeId != null) 'store_id': storeId,
      if (userId != null) 'user_id': userId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (dish != null) 'dish': dish!.toJson(),
      if (store != null) 'store': store!.toJson(),
      if (user != null) 'user': user!.toJson(),
    };
  }

  MenuReport copyWith({
    int? id,
    int? dishId,
    int? quantity,
    String? remark,
    int? storeId,
    int? userId,
    String? createdAt,
    String? updatedAt,
    MenuReportDish? dish,
    MenuReportStore? store,
    MenuReportUser? user,
  }) {
    return MenuReport(
      id: id ?? this.id,
      dishId: dishId ?? this.dishId,
      quantity: quantity ?? this.quantity,
      remark: remark ?? this.remark,
      storeId: storeId ?? this.storeId,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      dish: dish ?? this.dish,
      store: store ?? this.store,
      user: user ?? this.user,
    );
  }
}

/// 报菜记录单 (MenuReportOrder) - 主表
class MenuReportOrder {
  final int id;
  final int storeId;
  final int userId;
  final String? remark;
  final String? createdAt;
  final String? updatedAt;
  final MenuReportStore? store;
  final MenuReportUser? user;
  final List<MenuReportItem>? items;

  const MenuReportOrder({
    required this.id,
    required this.storeId,
    required this.userId,
    this.remark,
    this.createdAt,
    this.updatedAt,
    this.store,
    this.user,
    this.items,
  });

  factory MenuReportOrder.fromJson(Map<String, dynamic> json) {
    return MenuReportOrder(
      id: parseInt(json['id']),
      storeId: parseInt(json['store_id']),
      userId: parseInt(json['user_id']),
      remark: parseStringNullable(json['remark']),
      createdAt: parseStringNullable(json['created_at']),
      updatedAt: parseStringNullable(json['updated_at']),
      store: json['store'] is Map<String, dynamic>
          ? MenuReportStore.fromJson(
              Map<String, dynamic>.from(json['store'] as Map),
            )
          : null,
      user: json['user'] is Map<String, dynamic>
          ? MenuReportUser.fromJson(
              Map<String, dynamic>.from(json['user'] as Map),
            )
          : null,
      items: json['items'] is List
          ? (json['items'] as List)
              .map((e) => MenuReportItem.fromJson(
                    Map<String, dynamic>.from(e as Map),
                  ))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'store_id': storeId,
      'user_id': userId,
      if (remark != null) 'remark': remark,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (store != null) 'store': store!.toJson(),
      if (user != null) 'user': user!.toJson(),
      if (items != null) 'items': items!.map((e) => e.toJson()).toList(),
    };
  }
}

/// 报菜详情 (MenuReportItem) - 从表
class MenuReportItem {
  final int id;
  final int reportOrderId;
  final int dishId;
  final int quantity;
  final String? remark;
  final String? createdAt;
  final String? updatedAt;
  final MenuReportDish? dish;

  const MenuReportItem({
    required this.id,
    required this.reportOrderId,
    required this.dishId,
    required this.quantity,
    this.remark,
    this.createdAt,
    this.updatedAt,
    this.dish,
  });

  factory MenuReportItem.fromJson(Map<String, dynamic> json) {
    return MenuReportItem(
      id: parseInt(json['id']),
      reportOrderId: parseInt(json['report_order_id']),
      dishId: parseInt(json['dish_id']),
      quantity: parseInt(json['quantity']),
      remark: parseStringNullable(json['remark']),
      createdAt: parseStringNullable(json['created_at']),
      updatedAt: parseStringNullable(json['updated_at']),
      dish: json['dish'] is Map<String, dynamic>
          ? MenuReportDish.fromJson(
              Map<String, dynamic>.from(json['dish'] as Map),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'report_order_id': reportOrderId,
      'dish_id': dishId,
      'quantity': quantity,
      if (remark != null) 'remark': remark,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (dish != null) 'dish': dish!.toJson(),
    };
  }
}

class MenuReportDish {
  final int id;
  final String name;
  final double? price;
  final int? status;
  final int? storeId;

  const MenuReportDish({
    required this.id,
    required this.name,
    this.price,
    this.status,
    this.storeId,
  });

  factory MenuReportDish.fromJson(Map<String, dynamic> json) {
    return MenuReportDish(
      id: parseInt(json['id']),
      name: parseStringNullable(json['name']) ?? '-',
      price: parseDoubleNullable(json['price']),
      status: parseIntNullable(json['status']),
      storeId: parseIntNullable(json['store_id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      if (price != null) 'price': price,
      if (status != null) 'status': status,
      if (storeId != null) 'store_id': storeId,
    };
  }
}

class MenuReportStore {
  final int id;
  final String name;

  const MenuReportStore({
    required this.id,
    required this.name,
  });

  factory MenuReportStore.fromJson(Map<String, dynamic> json) {
    return MenuReportStore(
      id: parseInt(json['id']),
      name: parseStringNullable(json['name']) ?? '-',
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class MenuReportUser {
  final int id;
  final String username;
  final String? nickname;
  final String? phone;

  const MenuReportUser({
    required this.id,
    required this.username,
    this.nickname,
    this.phone,
  });

  factory MenuReportUser.fromJson(Map<String, dynamic> json) {
    return MenuReportUser(
      id: parseInt(json['id']),
      username: parseStringNullable(json['username']) ?? '-',
      nickname: parseStringNullable(json['nickname']),
      phone: parseStringNullable(json['phone']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      if (nickname != null) 'nickname': nickname,
      if (phone != null) 'phone': phone,
    };
  }
}

class MenuReportStats {
  final int? dishId;
  final String? dishName;
  final String? category;
  final int? totalQty;
  final int? totalDays;
  final double? avgQty;

  const MenuReportStats({
    this.dishId,
    this.dishName,
    this.category,
    this.totalQty,
    this.totalDays,
    this.avgQty,
  });

  factory MenuReportStats.fromJson(Map<String, dynamic> json) {
    return MenuReportStats(
      dishId: parseIntNullable(json['dish_id']),
      dishName: parseStringNullable(json['dish_name']),
      category: parseStringNullable(json['category']),
      totalQty: parseIntNullable(json['total_qty']),
      totalDays: parseIntNullable(json['total_days']),
      avgQty: parseDoubleNullable(json['avg_qty']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (dishId != null) 'dish_id': dishId,
      if (dishName != null) 'dish_name': dishName,
      if (category != null) 'category': category,
      if (totalQty != null) 'total_qty': totalQty,
      if (totalDays != null) 'total_days': totalDays,
      if (avgQty != null) 'avg_qty': avgQty,
    };
  }
}

class MenuReportOptionCategory {
  final DishCategory category;
  final List<Dish> dishes;

  const MenuReportOptionCategory({
    required this.category,
    required this.dishes,
  });
}

// 创建报菜记录单请求
class CreateMenuReportOrderRequest {
  final int storeId;
  final int userId;
  final String? remark;
  final List<CreateMenuReportItemRequest> items;

  const CreateMenuReportOrderRequest({
    required this.storeId,
    required this.userId,
    this.remark,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'store_id': storeId,
      'user_id': userId,
      if (remark != null && remark!.trim().isNotEmpty) 'remark': remark!.trim(),
      'items': items.map((e) => e.toJson()).toList(),
    };
  }
}

// 创建报菜详情请求
class CreateMenuReportItemRequest {
  final int dishId;
  final int quantity;
  final String? remark;

  const CreateMenuReportItemRequest({
    required this.dishId,
    required this.quantity,
    this.remark,
  });

  Map<String, dynamic> toJson() {
    return {
      'dish_id': dishId,
      'quantity': quantity,
      if (remark != null && remark!.trim().isNotEmpty) 'remark': remark!.trim(),
    };
  }
}

// 为了向后兼容，保留旧类 (已废弃)
@Deprecated('Use CreateMenuReportOrderRequest and CreateMenuReportItemRequest instead')
class CreateMenuReportRequest {
  final int dishId;
  final int quantity;
  final String? remark;

  const CreateMenuReportRequest({
    required this.dishId,
    required this.quantity,
    this.remark,
  });

  Map<String, dynamic> toJson() {
    return {
      'dish_id': dishId,
      'quantity': quantity,
      if (remark != null && remark!.trim().isNotEmpty) 'remark': remark!.trim(),
    };
  }
}

// 更新报菜详情请求
class UpdateMenuReportItemRequest {
  final int? quantity;
  final String? remark;

  const UpdateMenuReportItemRequest({
    this.quantity,
    this.remark,
  });

  Map<String, dynamic> toJson() {
    return {
      if (quantity != null) 'quantity': quantity,
      if (remark != null && remark!.trim().isNotEmpty) 'remark': remark!.trim(),
    };
  }
}

// 为了向后兼容，保留旧类 (已废弃)
@Deprecated('Use UpdateMenuReportItemRequest instead')
class UpdateMenuReportRequest {
  final int? quantity;
  final String? remark;

  const UpdateMenuReportRequest({
    this.quantity,
    this.remark,
  });

  Map<String, dynamic> toJson() {
    return {
      if (quantity != null) 'quantity': quantity,
      if (remark != null && remark!.trim().isNotEmpty) 'remark': remark!.trim(),
    };
  }
}
