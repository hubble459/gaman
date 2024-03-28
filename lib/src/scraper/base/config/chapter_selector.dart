import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gaman/gaman.dart';
import 'package:gaman/src/json_converter/list_converter.dart';
import 'package:gaman/src/scraper/base/config/fetch_external.dart';

part 'chapter_selector.freezed.dart';
part 'chapter_selector.g.dart';

@freezed
class ChapterSelector with _$ChapterSelector {
  const factory ChapterSelector({
    @ListConverter() required List<Selector> base,
    @ListConverter() required List<Selector> url,
    @ListConverter() @Default([]) List<Selector> title,
    @ListConverter() @Default([]) List<Selector> number,
    @ListConverter() @Default([]) List<Selector> date,
    @ListConverter() @JsonKey(name: "fetch_external") @Default([]) List<FetchExternal> fetchExternal,
    @JsonKey(name: "date_formats") @Default([]) List<String> dateFormats,
  }) = _ChapterSelector;

  factory ChapterSelector.fromJson(Map<String, Object?> json) => _$ChapterSelectorFromJson(json);
}
