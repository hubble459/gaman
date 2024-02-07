import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gaman/src/json_converter/nullable_jiffy_converter.dart';
import 'package:jiffy/jiffy.dart';

part 'chapter.freezed.dart';
part 'chapter.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class Chapter with _$Chapter {
  const factory Chapter({
    required Uri url,
    required String title,
    required double number,
    @NullableJiffyConverter() Jiffy? date,
  }) = _Chapter;

  factory Chapter.fromJson(Map<String, Object?> json) => _$ChapterFromJson(json);
}
