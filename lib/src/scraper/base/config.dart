import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gaman/src/json_converter/list_converter.dart';
import 'package:gaman/src/scraper/base/selector.dart';

part 'config.freezed.dart';
part 'config.g.dart';

@freezed
class Support with _$Support {
  const factory Support({
    @Default([]) List<String> hostnames,
    @Default([]) List<String> selectors,
  }) = _Support;

  factory Support.fromJson(Map<String, Object?> json) => _$SupportFromJson(json);
}

@freezed
class Config with _$Config {
  const factory Config({
    required Support support,
    @ListConverter() required List<Selector> title,
    @ListConverter() required List<Selector> summary,
    @JsonKey(name: "cover_url") @ListConverter() required List<Selector> coverUrl,
  }) = _Config;

  factory Config.fromJson(Map<String, Object?> json) => _$ConfigFromJson(json);
}
