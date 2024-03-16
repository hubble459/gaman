import 'package:gaman/src/model/manga.dart';
import 'package:gaman/src/scraper/base/json_scraper.dart';

class MangadexScraper extends JSONScraper {
  @override
  bool isSupported(Uri url) {
    // TODO: implement isSupported
    throw UnimplementedError();
  }

  @override
  Future<Manga> parseManga(Uri url) async {
    final doc = await JSONScraper.fetch(url);
    // TODO: implement parseManga
    throw UnimplementedError();
  }

  @override
  Future<List<Uri>> parseImages(Uri url) async {
    final doc = await JSONScraper.fetch(url);
    // TODO: implement parseImages
    throw UnimplementedError();
  }
}
