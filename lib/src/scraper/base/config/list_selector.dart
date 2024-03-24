import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gaman/gaman.dart';
import 'package:gaman/src/json_converter/pseudom_converter.dart';
import 'package:pseudom/pseudom.dart' as pseudom;

part 'list_selector.freezed.dart';
part 'list_selector.g.dart';

@freezed
class ListSelector with _$ListSelector {
  const factory ListSelector({
    @PseudomConverter() required pseudom.SelectorGroups selector,
    @Default(Capitalize.skip) Capitalize capitalize,
    @JsonKey(name: "text_type") @Default(TextType.ownText) TextType textType,
    // Used when TextType is allText to join multiple text nodes into one
    @JsonKey(name: "join_string") @Default("\n") String joinString,
    // Used when ListType is split to split text nodes into items
    @JsonKey(name: "split_string") String? splitString,
    @JsonKey(name: "first_only") @Default(false) bool firstOnly,
    @Default([]) List<String> attributes,
    @Default(true) bool trim,
  }) = _ListSelector;

  factory ListSelector.fromJson(Map<String, Object?> json) => _$ListSelectorFromJson(json);
}
