import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../../features/dict/dict_provider.dart';
import '../../features/dict/models.dart';

/// 字典翻译工具类
class DictUtils {
  DictUtils._();

  /// 根据字典编码和值获取标签
  /// [context] BuildContext
  /// [typeCode] 字典类型编码，如 'GYSGL_SPDW'
  /// [value] 字典值
  /// [defaultValue] 默认值，当找不到时返回
  static String getLabel(
    BuildContext context,
    String typeCode,
    String? value, {
    String defaultValue = '-',
  }) {
    if (value == null || value.isEmpty) return defaultValue;
    try {
      final dictProvider = context.read<DictProvider>();
      final label = dictProvider.getLabelByValue(typeCode, value);
      return label ?? value; // 找不到则返回原值
    } catch (_) {
      return value;
    }
  }

  /// 根据字典编码和值获取标签（静态方法，需要传入字典列表）
  static String getLabelFromList(
    List<DictData> dictList,
    String? value, {
    String defaultValue = '-',
  }) {
    if (value == null || value.isEmpty) return defaultValue;
    try {
      final item = dictList.firstWhere((d) => d.value == value);
      return item.label;
    } catch (_) {
      return value;
    }
  }

  /// 获取字典列表
  static List<DictData> getDictList(BuildContext context, String typeCode) {
    try {
      final dictProvider = context.read<DictProvider>();
      return dictProvider.getDictByCode(typeCode);
    } catch (_) {
      return [];
    }
  }

  /// 批量翻译（用于列表场景，避免多次查找）
  static Map<String, String> batchTranslate(
    BuildContext context,
    String typeCode,
    List<String> values,
  ) {
    final result = <String, String>{};
    try {
      final dictProvider = context.read<DictProvider>();
      final dictList = dictProvider.getDictByCode(typeCode);
      for (final value in values) {
        try {
          final item = dictList.firstWhere((d) => d.value == value);
          result[value] = item.label;
        } catch (_) {
          result[value] = value;
        }
      }
    } catch (_) {
      for (final value in values) {
        result[value] = value;
      }
    }
    return result;
  }
}

/// 字典翻译扩展方法
extension DictTranslateExtension on String {
  /// 翻译字典值为标签
  /// 用法: '1'.translateDict(context, 'CGDDZT')
  String translateDict(BuildContext context, String typeCode) {
    return DictUtils.getLabel(context, typeCode, this);
  }
}
