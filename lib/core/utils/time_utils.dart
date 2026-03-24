library time_utils;
DateTime? parseFlexibleDateTime(dynamic input) {
  if (input == null) return null;
  if (input is DateTime) return input.toLocal();
  if (input is int) {
    return _fromIntTimestamp(input);
  }
  if (input is num) {
    return _fromIntTimestamp(input.toInt());
  }
  if (input is String) {
    final v = input.trim();
    if (v.isEmpty) return null;
    try {
      final dt = DateTime.parse(v.replaceAll(' ', 'T'));
      return dt.toLocal();
    } on Object {
      final n = int.tryParse(v);
      if (n != null) {
        return _fromIntTimestamp(n);
      }
    }
  }
  return null;
}
DateTime? _fromIntTimestamp(int ts) {
  if (ts > 1000000000000) {
    return DateTime.fromMillisecondsSinceEpoch(ts).toLocal();
  }
  if (ts < 1000000000000 && ts > 1000000000) {
    return DateTime.fromMillisecondsSinceEpoch(ts * 1000).toLocal();
  }
  return null;
}
String formatDateTime(DateTime dt, {bool withSeconds = true}) {
  final y = dt.year.toString().padLeft(4, '0');
  final m = dt.month.toString().padLeft(2, '0');
  final d = dt.day.toString().padLeft(2, '0');
  final hh = dt.hour.toString().padLeft(2, '0');
  final mm = dt.minute.toString().padLeft(2, '0');
  final ss = dt.second.toString().padLeft(2, '0');
  return withSeconds ? '$y-$m-$d $hh:$mm:$ss' : '$y-$m-$d $hh:$mm';
}
String formatDateTimeFlexible(dynamic raw, {bool withSeconds = true}) {
  final dt = parseFlexibleDateTime(raw);
  if (dt == null) return '-';
  return formatDateTime(dt, withSeconds: withSeconds);
}
