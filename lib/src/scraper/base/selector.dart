import 'package:freezed_annotation/freezed_annotation.dart';

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
    required String selector,
    @Default(Capitalize.skip) Capitalize capitalize,
    @JsonValue("text_type") @Default(TextType.allText) TextType textType,
    // Used when TextType is allText to join multiple text nodes into one
    @Default("\n") String joinString,
    @Default([]) List<String> attributes,
    @Default(true) bool trim,
  }) = _Selector;

  factory Selector.fromJson(Map<String, Object?> json) => _$SelectorFromJson(json);
}
