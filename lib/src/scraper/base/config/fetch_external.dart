import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gaman/gaman.dart';
import 'package:gaman/src/json_converter/list_converter.dart';
import 'package:gaman/src/json_converter/regex_converter.dart';

part 'fetch_external.freezed.dart';
part 'fetch_external.g.dart';

@freezed
class FetchExternal with _$FetchExternal {
  const factory FetchExternal({
    @ListConverter() required List<Selector> id,
    @RegexConverter() required RegExp regex,
    required String url,
    @Default(Method.get) Method method,
  }) = _FetchExternal;

  factory FetchExternal.fromJson(Map<String, Object?> json) => _$FetchExternalFromJson(json);
}
