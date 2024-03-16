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

    final title = selectRequiredText(url, doc, config.title, "Title is missing");
    final summary = selectText(url, doc, config.summary) ?? "";
    final status = selectText(url, doc, config.status) ?? "Unknown";

    final coverUrlStr = selectText(url, doc, config.coverUrl);
    final coverUrl = coverUrlStr == null ? null : url.resolve(coverUrlStr);

    print(title);
    print(summary);
    print(coverUrl);

    return Manga(url: url, title: title, summary: summary, coverUrl: coverUrl, status: status);
  }

  List<String> parseListSelectors(Uri url, Document doc, List<Selector> selectors) {
    throw UnimplementedError();
  }
}
