import 'dart:convert';
import 'dart:io';

import 'package:gaman/gaman.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() {
  final yamlFiles = ["./example/madara.yaml"];
  final List<dynamic> configFiles = [];

  for (var yamlFilePath in yamlFiles) {
    final configFile = File(yamlFilePath);
    final configYaml = loadYaml(configFile.readAsStringSync());
    final configJson = json.decode(json.encode(configYaml));
    configFiles.add(configJson);
  }

  final manager = ConfigManager(configFiles);

  group('madara', () => testMadara(manager));
}

void testMadara(ConfigManager manager) {
  test('mangarockteam', testManga(manager, "https://mangarockteam.com/manga/above-ten-thousand-people/"));
  test('mangakik', testManga(manager, "https://mangakik.net/manga/magic-emperor1/"));
  test('manhuaus', testManga(manager, "https://manhuaus.com/manga/magic-emperor/"));
  test('mangaweebs', testManga(manager, "https://mangaweebs.in/manga/i-raised-the-beast-well/"));
  test('isekaiscanmanga', testManga(manager, "https://isekaiscanmanga.com/manga/990k-ex-life-hunter/"));
  test('isekaiscan', testManga(manager, "https://isekaiscan.top/manga/100-year-old-top-chef"));
  test('manhuaplus', testManga(manager, "https://manhuaplus.com/manga/demon-magic-emperor01/"));
  test('mangasushi', testManga(manager, "https://mangasushi.org/manga/lonely-attack-on-the-different-world/"));
  test('mangafoxfull', testManga(manager, "https://mangafoxfull.com/manga/magic-emperor/"));
  test('s2manga', testManga(manager, "https://s2manga.com/manga/under-the-oak-tree/"));
  // TODO 28/03/2024: ajax-admin.php
  // test('manhwatop', testManga(manager, "https://manhwatop.com/manga/magic-emperor-series/"));
  test('manga347', testManga(manager, "https://manga347.com/manga/magic-emperor/"));
  test('mixedmanga', testManga(manager, "https://mixedmanga.com/manga/the-eunuchs-consort-rules-the-world/"));
  test('mangachill', testManga(manager, "https://mangachill.com/manga/the-eunuchs-consort-rules-the-world/"));
  test('mangarockteam', testManga(manager, "https://mangarockteam.com/manga/the-eunuchs-consort-rules-the-world/"));
  test('mangazukiteam', testManga(manager, "https://mangazukiteam.com/manga/the-eunuchs-consort-rules-the-world/"));
  test('topmanhua', testManga(manager, "https://topmanhua.com/manhua/i-became-the-tutor-of-the-royal-twins/", authors: false));
  test('mangafunny', testManga(manager, "https://mangafunny.com/manga/past-lives-of-the-thunder-god/"));
  test('mangatx', testManga(manager, "https://mangatx.com/manga/lightning-degree/"));
  //https://todaymic.com/
}

Function() testManga(
  ConfigManager manager,
  String urlString, {
  bool updated = true,
  bool altTitles = true,
  bool authors = true,
  bool genres = true,
  bool summary = true,
}) {
  return () async {
    final url = Uri.parse(urlString);
    final doc = await HtmlScraper.fetch(url);
    if (manager.isSupportedDocument(url, doc)) {
      final manga = await manager.parseManga(url, doc: doc);
      await expectCompleteManga(
        manga,
        updated: updated,
        altTitles: altTitles,
        authors: authors,
        genres: genres,
        summary: summary,
      );
      final images = await manager.parseImages(manga.chapters.first.url);
      expect(images.length, greaterThan(0), reason: "images: ${manga.chapters.first.url}");
      // await testSearch(manager, manga.url.host);
    }
  };
}

Future<void> expectCompleteManga(
  Manga manga, {
  bool updated = true,
  bool altTitles = true,
  bool authors = true,
  bool genres = true,
  bool summary = true,
}) async {
  expect(manga.title, isNotEmpty, reason: "title: ${manga.url.toString()}");
  expect(manga.coverUrl, isNotNull, reason: "cover: ${manga.url.toString()}");
  if (summary) {
    expect(manga.summary, isNotEmpty, reason: "summary: ${manga.url.toString()}");
  }
  if (genres) {
    expect(manga.genres.length, greaterThan(0), reason: "genres: ${manga.url.toString()}");
  }
  if (authors) {
    expect(manga.authors.length, greaterThan(0), reason: "authors: ${manga.url.toString()}");
  }
  if (altTitles) {
    expect(manga.alternativeTitles.length, greaterThan(0), reason: "altTitles: ${manga.url.toString()}");
  }
  expect(manga.chapters.length, greaterThan(0), reason: "chapters: ${manga.url.toString()}");

  for (final chapter in manga.chapters) {
    expect(chapter.url, isNotNull, reason: "ch_url: ${manga.url.toString()}");
    expect(chapter.title, isNotNull, reason: "ch_title: ${manga.url.toString()}");
    expect(chapter.number, isNotNull, reason: "ch_number: ${manga.url.toString()}");
    if (updated) {
      expect(chapter.date, isNotNull, reason: "ch_posted: ${manga.url.toString()}");
    }
  }
}

Future<void> testSearch(ConfigManager manager, String hostname) async {
  final url = Uri.parse("https://$hostname.com");
  final thisScraper = manager.findWithoutDoc(url);

  expect(thisScraper, isNotNull, reason: "scraper: $hostname");

  final search = await thisScraper!.search("dungeon", hostnames: [hostname]);
  expect(search.length, greaterThan(0), reason: "search_results: $hostname");
  for (final result in search) {
    expect(result.url, isNotNull, reason: "sr_url: $hostname");
    expect(result.title, isNotNull, reason: "sr_title: $hostname");
  }
}
