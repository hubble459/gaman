import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jiffy/jiffy.dart';

class NullableJiffyConverter implements JsonConverter<Jiffy?, int?> {
  const NullableJiffyConverter();

  @override
  Jiffy? fromJson(int? timestamp) => timestamp != null ? Jiffy.parseFromMillisecondsSinceEpoch(timestamp) : null;

  @override
  int? toJson(Jiffy? date) => date?.millisecondsSinceEpoch;
}
