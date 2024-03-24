import 'dart:io';

import 'package:gaman/src/model/manga.dart';
import 'package:gio/gio.dart' as gio;

import 'dart:convert';
import 'package:crypto/crypto.dart';

Future<dynamic> getOrCache(Uri uri) async {}

abstract class BaseScraper {
  static Future<dynamic> fetch(Uri url) async {
    final filename = md5.convert(utf8.encode(url.toString())).toString();
    final file = File('.cache/$filename');
    if (await file.exists()) {
      return file.readAsString(encoding: utf8);
    }
    final body = (await gio.get(url.toString())).body;
    await file.writeAsString(body);
    return body;
  }

  bool isSupported(Uri url);
  Future<Manga> parseManga(Uri url);
  Future<List<Uri>> parseImages(Uri url);
}
