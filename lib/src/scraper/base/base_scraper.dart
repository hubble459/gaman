import 'dart:io';

import 'package:gaman/src/model/manga.dart';
import 'package:gaman/src/model/search_manga.dart';
import 'package:gio/gio.dart' as gio;

import 'dart:convert';
import 'package:crypto/crypto.dart';

enum Method {
  get,
  post,
  put,
  patch,
  head,
  delete,
}

abstract class BaseScraper {
  static Future<dynamic> fetch(Uri url, {Method method = Method.get}) async {
    final filename = md5.convert(utf8.encode(url.toString())).toString();
    final file = File('.cache/$filename');
    if (await file.exists()) {
      return file.readAsString(encoding: utf8);
    }
    final urlString = url.toString();
    final response = switch (method) {
      Method.get => await gio.get(urlString),
      Method.post => await gio.post(urlString),
      Method.put => await gio.put(urlString),
      Method.patch => await gio.patch(urlString),
      Method.head => await gio.head(urlString),
      Method.delete => await gio.delete(urlString),
    };
    final body = response.body;
    await file.writeAsString(body);
    return body;
  }

  bool isSupported(Uri url);
  Future<Manga> parseManga(Uri url);
  Future<List<Uri>> parseImages(Uri url);
  Future<List<SearchManga>> search(String keyword, {List<String> hostnames = const []}) async {
    return [];
  }
}
