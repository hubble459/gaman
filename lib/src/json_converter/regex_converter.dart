import 'package:freezed_annotation/freezed_annotation.dart';

class RegexConverter implements JsonConverter<RegExp, String> {
  const RegexConverter();

  @override
  RegExp fromJson(String regex) => RegExp(regex);

  @override
  String toJson(RegExp regex) => regex.pattern;
}
