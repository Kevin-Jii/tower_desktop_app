import 'models.dart';
class StoreAccountRow {
  int? productId;
  String productName;
  String spec;
  double quantity;
  String unit;
  double price;
  double amount;
  DateTime accountDate;
  StoreAccountRow({
    this.productId,
    this.productName = '',
    this.spec = '',
    this.quantity = 1,
    this.unit = '',
    this.price = 0,
    this.amount = 0,
    DateTime? accountDate,
  }) : accountDate = accountDate ?? DateTime.now();
  factory StoreAccountRow.fromItem(StoreAccountItem item) {
    return StoreAccountRow(
      productId: item.productId,
      productName: item.productName ?? '',
      spec: item.spec ?? '',
      quantity: item.quantity,
      unit: item.unit ?? '',
      price: item.price,
      amount: item.amount,
    );
  }
  void calculateAmount() {
    amount = quantity * price;
  }
  CreateStoreAccountItem toCreateItem() {
    return CreateStoreAccountItem(
      productId: productId!,
      spec: spec.isEmpty ? null : spec,
      quantity: quantity,
      unit: unit.isEmpty ? null : unit,
      price: price,
      amount: amount,
    );
  }
}
