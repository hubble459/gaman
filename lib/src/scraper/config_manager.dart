import 'package:collection/collection.dart';
import 'package:gaman/gaman.dart';
import 'package:html/dom.dart';

class ConfigManager extends HtmlScraper {
  final List<ConfigScraper> scrapers = [];
  Document? cachedDoc;

  ConfigManager(List<dynamic> configFiles) {
    for (final config in configFiles) {
      scrapers.add(ConfigScraper(Config.fromJson(config)));
    }
  }

  @override
  bool isSupported(Uri url) {
    return scrapers.any((scraper) => scraper.isSupported(url));
  }

  @override
  bool isSupportedDocument(Uri url, Document doc) {
    return (find(url, doc)) != null;
  }

  ConfigScraper? find(Uri url, Document doc) {
    cachedDoc = doc;

    final found = findWithoutDoc(url);
    if (found != null) {
      return found;
    }

    for (final scraper in scrapers) {
      if (scraper.isSupportedDocument(url, doc)) {
        return scraper;
      }
    }

    return null;
  }

  ConfigScraper? findWithoutDoc(Uri url) {
    return scrapers.firstWhereOrNull((scraper) => scraper.isSupported(url));
  }

  @override
  Future<List<Uri>> parseImages(Uri url) async {
    Document doc;
    if (cachedDoc?.sourceSpan?.sourceUrl == url) {
      doc = cachedDoc!;
    } else {
      doc = await HtmlScraper.fetch(url);
    }

    final scraper = find(url, doc);

    if (scraper == null) {
      throw UnimplementedError();
    }

    return scraper.parseImages(url);
  }

  @override
  Future<Manga> parseManga(Uri url, {Document? doc}) async {
    if (doc == null) {
      if (cachedDoc?.sourceSpan?.sourceUrl == url) {
        doc = cachedDoc!;
      } else {
        doc = await HtmlScraper.fetch(url);
      }
    }

    final scraper = find(url, doc);

    if (scraper == null) {
      throw UnimplementedError();
    }

    return scraper.parseManga(url, doc: doc);
  }
}
