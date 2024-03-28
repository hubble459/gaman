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
  Future<List<Uri>> parseImages(Uri url, {Document? doc}) async {
    doc ??= await HtmlScraper.fetch(url);

    final element = await fetchExternal(url, doc.documentElement!, config.images.fetchExternal);
    return selectUrls(url, element, config.images.image);
  }

  @override
  Future<Manga> parseManga(Uri url, {Document? doc}) async {
    doc ??= await HtmlScraper.fetch(url);
    final element = doc.documentElement!;

    final title = require(selectText(element, config.title), "Title is missing");
    final summary = selectText(element, config.summary) ?? "";
    final status = selectText(element, config.status) ?? "Unknown";
    final coverUrl = selectUrl(url, element, config.coverUrl);
    final authors = selectList(url, element, config.authors);
    final genres = selectList(url, element, config.genres);
    final alternativeTitles = selectList(url, element, config.alternativeTitles);
    final chapters = await selectChapters(url, element, config.chapters);

    return Manga(
      url: url,
      title: title,
      summary: summary,
      coverUrl: coverUrl,
      status: status,
      authors: authors,
      genres: genres,
      alternativeTitles: alternativeTitles,
      chapters: chapters,
    );
  }

  List<String> parseListSelectors(Uri url, Document doc, List<Selector> selectors) {
    throw UnimplementedError();
  }
}
