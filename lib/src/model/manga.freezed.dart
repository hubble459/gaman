// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manga.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Manga _$MangaFromJson(Map<String, dynamic> json) {
  return _Manga.fromJson(json);
}

/// @nodoc
mixin _$Manga {
  Uri get url => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get summary => throw _privateConstructorUsedError;
  Uri? get coverUrl => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  List<String> get authors => throw _privateConstructorUsedError;
  List<String> get genres => throw _privateConstructorUsedError;
  List<String> get alternativeTitles => throw _privateConstructorUsedError;
  List<Chapter> get chapters => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MangaCopyWith<Manga> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MangaCopyWith<$Res> {
  factory $MangaCopyWith(Manga value, $Res Function(Manga) then) =
      _$MangaCopyWithImpl<$Res, Manga>;
  @useResult
  $Res call(
      {Uri url,
      String title,
      String summary,
      Uri? coverUrl,
      String? status,
      List<String> authors,
      List<String> genres,
      List<String> alternativeTitles,
      List<Chapter> chapters});
}

/// @nodoc
class _$MangaCopyWithImpl<$Res, $Val extends Manga>
    implements $MangaCopyWith<$Res> {
  _$MangaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? title = null,
    Object? summary = null,
    Object? coverUrl = freezed,
    Object? status = freezed,
    Object? authors = null,
    Object? genres = null,
    Object? alternativeTitles = null,
    Object? chapters = null,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as Uri,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      coverUrl: freezed == coverUrl
          ? _value.coverUrl
          : coverUrl // ignore: cast_nullable_to_non_nullable
              as Uri?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      authors: null == authors
          ? _value.authors
          : authors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      genres: null == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>,
      alternativeTitles: null == alternativeTitles
          ? _value.alternativeTitles
          : alternativeTitles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      chapters: null == chapters
          ? _value.chapters
          : chapters // ignore: cast_nullable_to_non_nullable
              as List<Chapter>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MangaImplCopyWith<$Res> implements $MangaCopyWith<$Res> {
  factory _$$MangaImplCopyWith(
          _$MangaImpl value, $Res Function(_$MangaImpl) then) =
      __$$MangaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Uri url,
      String title,
      String summary,
      Uri? coverUrl,
      String? status,
      List<String> authors,
      List<String> genres,
      List<String> alternativeTitles,
      List<Chapter> chapters});
}

/// @nodoc
class __$$MangaImplCopyWithImpl<$Res>
    extends _$MangaCopyWithImpl<$Res, _$MangaImpl>
    implements _$$MangaImplCopyWith<$Res> {
  __$$MangaImplCopyWithImpl(
      _$MangaImpl _value, $Res Function(_$MangaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? title = null,
    Object? summary = null,
    Object? coverUrl = freezed,
    Object? status = freezed,
    Object? authors = null,
    Object? genres = null,
    Object? alternativeTitles = null,
    Object? chapters = null,
  }) {
    return _then(_$MangaImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as Uri,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      coverUrl: freezed == coverUrl
          ? _value.coverUrl
          : coverUrl // ignore: cast_nullable_to_non_nullable
              as Uri?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      authors: null == authors
          ? _value.authors
          : authors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      genres: null == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>,
      alternativeTitles: null == alternativeTitles
          ? _value.alternativeTitles
          : alternativeTitles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      chapters: null == chapters
          ? _value.chapters
          : chapters // ignore: cast_nullable_to_non_nullable
              as List<Chapter>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MangaImpl implements _Manga {
  const _$MangaImpl(
      {required this.url,
      required this.title,
      required this.summary,
      required this.coverUrl,
      required this.status,
      this.authors = const [],
      this.genres = const [],
      this.alternativeTitles = const [],
      this.chapters = const []});

  factory _$MangaImpl.fromJson(Map<String, dynamic> json) =>
      _$$MangaImplFromJson(json);

  @override
  final Uri url;
  @override
  final String title;
  @override
  final String summary;
  @override
  final Uri? coverUrl;
  @override
  final String? status;
  @override
  @JsonKey()
  final List<String> authors;
  @override
  @JsonKey()
  final List<String> genres;
  @override
  @JsonKey()
  final List<String> alternativeTitles;
  @override
  @JsonKey()
  final List<Chapter> chapters;

  @override
  String toString() {
    return 'Manga(url: $url, title: $title, summary: $summary, coverUrl: $coverUrl, status: $status, authors: $authors, genres: $genres, alternativeTitles: $alternativeTitles, chapters: $chapters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MangaImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.coverUrl, coverUrl) ||
                other.coverUrl == coverUrl) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.authors, authors) &&
            const DeepCollectionEquality().equals(other.genres, genres) &&
            const DeepCollectionEquality()
                .equals(other.alternativeTitles, alternativeTitles) &&
            const DeepCollectionEquality().equals(other.chapters, chapters));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      url,
      title,
      summary,
      coverUrl,
      status,
      const DeepCollectionEquality().hash(authors),
      const DeepCollectionEquality().hash(genres),
      const DeepCollectionEquality().hash(alternativeTitles),
      const DeepCollectionEquality().hash(chapters));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MangaImplCopyWith<_$MangaImpl> get copyWith =>
      __$$MangaImplCopyWithImpl<_$MangaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MangaImplToJson(
      this,
    );
  }
}

abstract class _Manga implements Manga {
  const factory _Manga(
      {required final Uri url,
      required final String title,
      required final String summary,
      required final Uri? coverUrl,
      required final String? status,
      final List<String> authors,
      final List<String> genres,
      final List<String> alternativeTitles,
      final List<Chapter> chapters}) = _$MangaImpl;

  factory _Manga.fromJson(Map<String, dynamic> json) = _$MangaImpl.fromJson;

  @override
  Uri get url;
  @override
  String get title;
  @override
  String get summary;
  @override
  Uri? get coverUrl;
  @override
  String? get status;
  @override
  List<String> get authors;
  @override
  List<String> get genres;
  @override
  List<String> get alternativeTitles;
  @override
  List<Chapter> get chapters;
  @override
  @JsonKey(ignore: true)
  _$$MangaImplCopyWith<_$MangaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
