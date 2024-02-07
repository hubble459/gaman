import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gaman/src/model/chapter.dart';

part 'manga.freezed.dart';
part 'manga.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class Manga with _$Manga {
  const factory Manga({
    required Uri url,
    required String title,
    required String summary,
    required Uri? coverUrl,
    required String? status,
    @Default([]) List<String> authors,
    @Default([]) List<String> genres,
    @Default([]) List<String> alternativeTitles,
    @Default([]) List<Chapter> chapters,
  }) = _Manga;

  factory Manga.fromJson(Map<String, Object?> json) => _$MangaFromJson(json);
}
