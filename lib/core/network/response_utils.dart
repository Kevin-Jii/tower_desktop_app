library response_utils;
import 'dart:convert';
class ResponseUtils {
  static dynamic extractData(dynamic raw) {
    if (raw is String) {
      final trimmed = raw.trim();
      if (trimmed.isNotEmpty &&
          (trimmed.startsWith('{') || trimmed.startsWith('['))) {
        try {
          raw = jsonDecode(trimmed);
        } on Object {
        }
      }
    }
    if (raw is Map) {
      if (raw.containsKey('data')) return raw['data'];
      if (raw.containsKey('code') && raw.containsKey('message')) {
        return null;
      }
    }
    return raw;
  }
  static List<Map<String, dynamic>> toMapList(dynamic raw, {String? listKey}) {
    raw = extractData(raw);
    dynamic data = raw;
    if (listKey != null && raw is Map) {
      final inner = raw[listKey];
      if (inner is List) {
        data = inner;
      } else {
        return const [];
      }
    }
    if (data is List) {
      return data
          .where((e) => e is Map)
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();
    }
    return const [];
  }
  static List<Map<String, dynamic>> payloadToList(dynamic raw,
      {String? listKey}) {
    return toMapList(raw, listKey: listKey);
  }
}
