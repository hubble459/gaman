import 'package:gaman/src/scraper/base/base_scraper.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart';

abstract class HtmlScraper extends BaseScraper {
  static Future<Document> fetch(Uri url, {Method method = Method.get}) async {
    final String html = await BaseScraper.fetch(url, method: method);

    return html_parser.parse(html, sourceUrl: url.toString());
  }

  bool isSupportedDocument(Uri url, Document doc) {
    return isSupported(url);
  }
}
