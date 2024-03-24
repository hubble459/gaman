import 'package:gaman/gaman.dart';
import 'package:gaman/src/scraper/base/config/parser_helper.dart';
import 'package:html/dom.dart';

class ConfigScraper extends HtmlScraper {
  final Config config;

  ConfigScraper(this.config);

  @override
  bool isSupported(Uri url) {
    final hostname = url.host;
    return config.support.hostnames.any((supportedHostname) => supportedHostname == hostname);
  }

  @override
  bool isSupportedDocument(Uri url, Document doc) {
    if (isSupported(url)) {
      return true;
    }

    for (final selector in config.support.selectors) {
      if (doc.querySelector(selector) != null) {
        return true;
      }
    }

    return false;
  }

  @override
  Future<List<Uri>> parseImages(Uri url, {Document? doc}) {
    // TODO: implement parseImages
    throw UnimplementedError();
  }

  @override
  Future<Manga> parseManga(Uri url, {Document? doc}) async {
    doc ??= await HtmlScraper.fetch(url);

    final title = require(selectText(url, doc, config.title), "Title is missing");
    final summary = selectText(url, doc, config.summary) ?? "";
    final status = selectText(url, doc, config.status) ?? "Unknown";
    final coverUrl = selectUrl(url, doc, config.coverUrl);
    final authors = selectList(url, doc, config.authors);
    final genres = selectList(url, doc, config.genres);
    final alternativeTitles = selectList(url, doc, config.alternativeTitles);

    return Manga(
      url: url,
      title: title,
      summary: summary,
      coverUrl: coverUrl,
      status: status,
      authors: authors,
      genres: genres,
      alternativeTitles: alternativeTitles,
    );
  }

  List<String> parseListSelectors(Uri url, Document doc, List<Selector> selectors) {
    throw UnimplementedError();
  }
}
