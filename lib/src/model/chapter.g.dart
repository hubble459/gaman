// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChapterImpl _$$ChapterImplFromJson(Map<String, dynamic> json) =>
    _$ChapterImpl(
      url: Uri.parse(json['url'] as String),
      title: json['title'] as String,
      number: (json['number'] as num).toDouble(),
      date: const NullableJiffyConverter().fromJson(json['date'] as int?),
    );

Map<String, dynamic> _$$ChapterImplToJson(_$ChapterImpl instance) =>
    <String, dynamic>{
      'url': instance.url.toString(),
      'title': instance.title,
      'number': instance.number,
      'date': const NullableJiffyConverter().toJson(instance.date),
    };
