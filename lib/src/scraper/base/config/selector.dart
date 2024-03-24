import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gaman/src/json_converter/pseudom_converter.dart';
import 'package:pseudom/pseudom.dart' as pseudom;

part 'selector.freezed.dart';
part 'selector.g.dart';

enum TextType {
  @JsonValue("all-text")
  allText,
  @JsonValue("own-text")
  ownText,
  @JsonValue("attribute")
  attribute,
}

enum Capitalize {
  title,
  paragraph,
  skip,
}

@freezed
class Selector with _$Selector {
  const factory Selector({
    @PseudomConverter() required pseudom.SelectorGroups selector,
    @Default(Capitalize.skip) Capitalize capitalize,
    @JsonKey(name: "text_type") @Default(TextType.allText) TextType textType,
    // Used when TextType is allText to join multiple text nodes into one
    @JsonKey(name: "join_string") @Default("\n") String joinString,
    @Default([]) List<String> attributes,
    @Default(true) bool trim,
  }) = _Selector;

  factory Selector.fromJson(Map<String, Object?> json) => _$SelectorFromJson(json);
}
