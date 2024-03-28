import 'package:collection/collection.dart';
import 'package:gaman/gaman.dart';
import 'package:gaman/src/scraper/base/config/chapter_selector.dart';
import 'package:gaman/src/scraper/base/config/fetch_external.dart';
import 'package:gaman/src/scraper/base/config/list_selector.dart';
import 'package:gaman/src/scraper/base/parse_date.dart';
import 'package:html/dom.dart';
import 'package:jiffy/jiffy.dart';

T require<T>(T? data, String error) {
  if (data == null) {
    throw Exception(error);
  }
  return data;
}

Uri? selectUrl(Uri url, Element element, List<Selector> selectors) {
  final urlStr = selectText(element, selectors);
  return urlStr == null ? null : url.resolve(urlStr);
}

List<Uri> selectUrls(Uri url, Element element, List<Selector> selectors) {
  final urlStrings = selectTexts(element, selectors);
  return urlStrings.map((urlString) => url.resolve(urlString)).toList();
}

List<String> selectTexts(Element element, List<Selector> selectors) {
  for (final selector in selectors) {
    final elements = selector.selector.select(element);

    if (elements.isEmpty) {
      continue;
    }

    final texts = <String>[];

    for (var element in elements) {
      final text = _textFromElement(element, selector);

      if (text != null) {
        texts.add(text);
      }
    }

    if (texts.isNotEmpty) {
      return texts;
    }
  }

  return [];
}

String? selectText(Element element, List<Selector> selectors) {
  for (final selector in selectors) {
    final el = selector.selector.selectFirst(element);

    if (el == null) {
      continue;
    }

    final text = _textFromElement(el, selector);
    if (text != null) {
      return text;
    }
  }

  return null;
}

String? _textFromElement(Element element, dynamic selector) {
  if (selector is! Selector && selector is! ListSelector) {
    return null;
  }

  String? text;
  switch (selector.textType) {
    case TextType.allText:
      // TODO 16/03/2024: Use joinString to join all decendent text nodes
      text = element.text;
      break;
    case TextType.ownText:
      final ownText = element.nodes
          .where((element) => element.nodeType == Node.TEXT_NODE && element.text?.isNotEmpty == true)
          .fold("", (previousValue, element) => previousValue + selector.joinString + element.text!);
      if (ownText.isNotEmpty) text = ownText;
      break;
    case TextType.attribute:
      {
        for (var attr in selector.attributes) {
          final foundAttr = element.attributes[attr];
          if (foundAttr != null) {
            text = foundAttr;
            break;
          }
        }
      }
      break;
  }

  if (text == null || text.isEmpty) {
    return null;
  }

  if (selector.trim) {
    text = text.trim();
  }

  switch (selector.capitalize) {
    case Capitalize.title:
      text = text.toTitleCase();
      break;
    case Capitalize.paragraph:
      text = text.toCapitalized();
      break;
    case Capitalize.skip:
      break;
  }
  return text;
}

List<String> selectList(Uri url, Element element, List<ListSelector> selectors) {
  List<String> list = [];

  for (final selector in selectors) {
    Set<Element> elements = {};

    // Select elements
    if (selector.firstOnly) {
      final el = selector.selector.selectFirst(element);
      if (el != null) {
        elements.add(el);
      }
    } else {
      elements = selector.selector.select(element);
    }

    if (elements.isEmpty) {
      continue;
    }

    for (final element in elements) {
      final text = _textFromElement(element, selector);

      if (text == null || text.isEmpty) {
        // TODO 16/03/2024: Should this throw an error?
        print("Empty element in list selection: ${selector.selector}");
        continue;
      }

      // Split text
      if (selector.splitString != null) {
        final parts = text.split(selector.splitString!);

        for (var i = 0; i < parts.length; i++) {
          String part = parts[i];
          if (selector.trim) {
            part = part.trim();
          }

          switch (selector.capitalize) {
            case Capitalize.title:
              part = part.toTitleCase();
              break;
            case Capitalize.paragraph:
              part = part.toCapitalized();
              break;
            case Capitalize.skip:
              break;
          }
          parts[i] = part;
        }
        list.addAll(parts);
      } else {
        list.add(text);
      }
    }
  }

  return list;
}

Jiffy? selectDate(Element element, List<Selector> selectors, List<String> dateFormats) {
  final text = selectText(element, selectors);

  if (text == null) {
    return null;
  }

  return parseDate(text, dateFormats);
}

Future<Element> fetchExternal(Uri rootUrl, Element element, List<FetchExternal> fetchExternal) async {
  print('[EXTERNAL] Trying to fetch external in ${rootUrl.host}');

  for (final external in fetchExternal) {
    final id = selectText(element, external.id);
    if (id == null) {
      continue;
    }
    print('[EXTERNAL] Found ID: $id');
    final groups = external.regex.allMatches(id);
    if (groups.isEmpty) {
      continue;
    }
    print('[EXTERNAL] Found matches: ${groups.map((e) => [e.groupNames])}');
    String url = external.url.replaceAll(RegExp(r'{host}'), rootUrl.host);
    url = url.replaceAllMapped(
      RegExp(r'{(\w+)}'),
      (match) => groups.firstWhereOrNull((m) => m.groupNames.contains(match[1]!))?.namedGroup(match[1]!) ?? '',
    );

    print('[EXTERNAL] Made url: $url');

    try {
      final uri = rootUrl.resolve(url);
      return (await HtmlScraper.fetch(uri, method: external.method)).documentElement!;
    } catch (e) {
      // Ignored
      // TODO 28/03/2024: add proper logging
    }
  }
  return element;
}

Future<List<Chapter>> selectChapters(Uri url, Element element, ChapterSelector selector) async {
  element = await fetchExternal(url, element, selector.fetchExternal);

  var elements = <Element>{};

  for (final base in selector.base) {
    final nodes = base.selector.select(element);
    if (nodes.isNotEmpty) {
      elements = nodes;
      break;
    }
  }

  if (elements.isEmpty) {
    return [];
  }

  final chapters = <Chapter>[];
  var index = 1.0;
  for (final element in elements) {
    final chapterUrl = require(selectUrl(url, element, selector.url), 'Chapter url is missing');
    final numberStr = selectText(element, selector.number) ?? index.toString();
    var number = double.tryParse(numberStr) ?? index;
    final title = selectText(element, selector.title) ?? 'Chapter $number';
    final date = selectDate(element, selector.date, selector.dateFormats);

    chapters.add(Chapter(
      url: chapterUrl,
      title: title,
      number: number,
      date: date,
    ));

    number += 1;
  }

  return chapters;
}
