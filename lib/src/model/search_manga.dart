import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_manga.freezed.dart';
part 'search_manga.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class SearchManga with _$SearchManga {
  const factory SearchManga({
    required Uri url,
    required String title,
    required String? summary,
    required Uri? coverUrl,
    required String? status,
  }) = _SearchManga;

  factory SearchManga.fromJson(Map<String, Object?> json) => _$SearchMangaFromJson(json);
}
