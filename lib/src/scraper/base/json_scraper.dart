import 'dart:convert';

import 'package:gaman/src/scraper/base/base_scraper.dart';

abstract class JSONScraper extends BaseScraper {
  static Future<dynamic> fetch(Uri url) async {
    final String json = await BaseScraper.fetch(url);
    return jsonDecode(json);
  }
}
