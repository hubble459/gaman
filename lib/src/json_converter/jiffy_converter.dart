import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jiffy/jiffy.dart';

class JiffyConverter implements JsonConverter<Jiffy, int> {
  const JiffyConverter();

  @override
  Jiffy fromJson(int timestamp) => Jiffy.parseFromMillisecondsSinceEpoch(timestamp);

  @override
  int toJson(Jiffy date) => date.millisecondsSinceEpoch;
}
