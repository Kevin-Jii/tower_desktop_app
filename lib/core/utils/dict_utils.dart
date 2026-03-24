import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../../features/dict/dict_provider.dart';
import '../../features/dict/models.dart';
class DictUtils {
  DictUtils._();
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
      return label ?? value; 
    } on ProviderNotFoundException {
      return value;
    } on Object {
      return value;
    }
  }
  static String getLabelFromList(
    List<DictData> dictList,
    String? value, {
    String defaultValue = '-',
  }) {
    if (value == null || value.isEmpty) return defaultValue;
    try {
      final item = dictList.firstWhere((d) => d.value == value);
      return item.label;
    } on StateError {
      return value;
    } on Object {
      return value;
    }
  }
  static List<DictData> getDictList(BuildContext context, String typeCode) {
    try {
      final dictProvider = context.read<DictProvider>();
      return dictProvider.getDictByCode(typeCode);
    } on ProviderNotFoundException {
      return [];
    } on Object {
      return [];
    }
  }
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
        } on StateError {
          result[value] = value;
        } on Object {
          result[value] = value;
        }
      }
    } on ProviderNotFoundException {
      for (final value in values) {
        result[value] = value;
      }
    } on Object {
      for (final value in values) {
        result[value] = value;
      }
    }
    return result;
  }
}
extension DictTranslateExtension on String {
  String translateDict(BuildContext context, String typeCode) {
    return DictUtils.getLabel(context, typeCode, this);
  }
}
