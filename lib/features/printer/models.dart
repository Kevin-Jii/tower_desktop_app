import 'package:freezed_annotation/freezed_annotation.dart';
part 'models.freezed.dart';
part 'models.g.dart';
@freezed
class Printer with _$Printer {
  const factory Printer({
    required int id,
    @JsonKey(name: 'store_id') required int storeId,
    @JsonKey(name: 'sn') String? sn,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'type') int? type,
    @JsonKey(name: 'type_name') String? typeName,
    @JsonKey(name: 'status') int? status,
    @JsonKey(name: 'status_name') String? statusName,
    @JsonKey(name: 'is_default') int? isDefault,
    @JsonKey(name: 'online') int? online,
    @JsonKey(name: 'last_heartbeat') String? lastHeartbeat,
    @JsonKey(name: 'remark') String? remark,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _Printer;
  factory Printer.fromJson(Map<String, dynamic> json) => _$PrinterFromJson(json);
}
@freezed
class BindPrinterReq with _$BindPrinterReq {
  const factory BindPrinterReq({
    @JsonKey(name: 'store_id') required int storeId,
    @JsonKey(name: 'sn') required String sn,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'type') int? type,
    @JsonKey(name: 'is_default') int? isDefault,
    @JsonKey(name: 'remark') String? remark,
  }) = _BindPrinterReq;
  factory BindPrinterReq.fromJson(Map<String, dynamic> json) => _$BindPrinterReqFromJson(json);
}
@freezed
class UpdatePrinterReq with _$UpdatePrinterReq {
  const factory UpdatePrinterReq({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'type') int? type,
    @JsonKey(name: 'status') int? status,
    @JsonKey(name: 'is_default') int? isDefault,
    @JsonKey(name: 'remark') String? remark,
  }) = _UpdatePrinterReq;
  factory UpdatePrinterReq.fromJson(Map<String, dynamic> json) => _$UpdatePrinterReqFromJson(json);
}
@freezed
class PrinterListResp with _$PrinterListResp {
  const factory PrinterListResp({
    required List<Printer> list,
    @JsonKey(name: 'total') int? total,
    @JsonKey(name: 'page') int? page,
    @JsonKey(name: 'page_size') int? pageSize,
  }) = _PrinterListResp;
  factory PrinterListResp.fromJson(Map<String, dynamic> json) => _$PrinterListRespFromJson(json);
}
enum PrinterTypeEnum {
  receipt(1, '小票打印机'),
  label(2, '标签打印机');
  final int value;
  final String labelText;
  const PrinterTypeEnum(this.value, this.labelText);
  static PrinterTypeEnum? fromValue(int? value) {
    if (value == null) return null;
    return PrinterTypeEnum.values.where((e) => e.value == value).firstOrNull;
  }
}
enum PrinterStatusEnum {
  normal(1, '正常'),
  disabled(2, '停用');
  final int value;
  final String labelText;
  const PrinterStatusEnum(this.value, this.labelText);
  static PrinterStatusEnum? fromValue(int? value) {
    if (value == null) return null;
    return PrinterStatusEnum.values.where((e) => e.value == value).firstOrNull;
  }
}
enum PrinterOnlineEnum {
  offline(0, '离线'),
  online(1, '在线'),
  error(2, '异常');
  final int value;
  final String labelText;
  const PrinterOnlineEnum(this.value, this.labelText);
  static PrinterOnlineEnum? fromValue(int? value) {
    if (value == null) return null;
    return PrinterOnlineEnum.values.where((e) => e.value == value).firstOrNull;
  }
  bool get canPrint => this == PrinterOnlineEnum.online;
}