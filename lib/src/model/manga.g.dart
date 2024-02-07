// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MangaImpl _$$MangaImplFromJson(Map<String, dynamic> json) => _$MangaImpl(
      url: Uri.parse(json['url'] as String),
      title: json['title'] as String,
      summary: json['summary'] as String,
      coverUrl: json['coverUrl'] == null
          ? null
          : Uri.parse(json['coverUrl'] as String),
      status: json['status'] as String?,
      authors: (json['authors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      genres: (json['genres'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      alternativeTitles: (json['alternativeTitles'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      chapters: (json['chapters'] as List<dynamic>?)
              ?.map((e) => Chapter.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$MangaImplToJson(_$MangaImpl instance) =>
    <String, dynamic>{
      'url': instance.url.toString(),
      'title': instance.title,
      'summary': instance.summary,
      'coverUrl': instance.coverUrl?.toString(),
      'status': instance.status,
      'authors': instance.authors,
      'genres': instance.genres,
      'alternativeTitles': instance.alternativeTitles,
      'chapters': instance.chapters,
    };
