import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pseudom/pseudom.dart';

class PseudomConverter implements JsonConverter<SelectorGroups, String> {
  const PseudomConverter();

  @override
  SelectorGroups fromJson(String selector) => parse(selector);

  @override
  String toJson(SelectorGroups selectorGroup) => selectorGroup.rawSelector;
}
