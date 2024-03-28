import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gaman/src/json_converter/list_converter.dart';
import 'package:gaman/src/scraper/base/config/chapter_selector.dart';
import 'package:gaman/src/scraper/base/config/fetch_external.dart';
import 'package:gaman/src/scraper/base/config/list_selector.dart';
import 'package:gaman/src/scraper/base/config/selector.dart';

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
class Images with _$Images {
  const factory Images({
    @Default([]) List<Selector> image,
    @ListConverter() @JsonKey(name: "fetch_external") @Default([]) List<FetchExternal> fetchExternal,
  }) = _Images;

  factory Images.fromJson(Map<String, Object?> json) => _$ImagesFromJson(json);
}

@freezed
class Config with _$Config {
  const factory Config({
    required Support support,
    required Images images,
    required ChapterSelector chapters,
    @ListConverter() required List<Selector> title,
    @ListConverter() required List<Selector> summary,
    @ListConverter() @Default([]) List<Selector> status,
    @JsonKey(name: "cover_url") @ListConverter() @Default([]) List<Selector> coverUrl,
    @ListConverter() @Default([]) List<ListSelector> authors,
    @ListConverter() @Default([]) List<ListSelector> genres,
    @JsonKey(name: "alternative_titles") @ListConverter() @Default([]) List<ListSelector> alternativeTitles,
  }) = _Config;

  factory Config.fromJson(Map<String, Object?> json) => _$ConfigFromJson(json);
}
