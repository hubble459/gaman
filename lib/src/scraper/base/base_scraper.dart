import 'package:gaman/src/model/manga.dart';
import 'package:gio/gio.dart' as gio;

abstract class BaseScraper {
  static Future<dynamic> fetch(Uri url) async {
    return (await gio.get(url.toString())).body;
  }

  bool isSupported(Uri url);
  Future<Manga> parseManga(Uri url);
  Future<List<Uri>> parseImages(Uri url);
}
