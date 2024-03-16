import 'package:freezed_annotation/freezed_annotation.dart';

class ListConverter implements JsonConverter<List<dynamic>, dynamic> {
  const ListConverter();

  @override
  List<dynamic> fromJson(dynamic object) => (object is List ? object : List.from([object]));

  @override
  dynamic toJson(List<dynamic> list) => list;
}
