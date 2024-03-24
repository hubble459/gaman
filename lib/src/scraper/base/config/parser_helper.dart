import 'package:gaman/gaman.dart';
import 'package:gaman/src/scraper/base/config/list_selector.dart';
import 'package:html/dom.dart';

T require<T>(T? data, String error) {
  if (data == null) {
    throw Exception(error);
  }
  return data;
}

Uri? selectUrl(Uri url, Document doc, List<Selector> selectors) {
  final urlStr = selectText(url, doc, selectors);
  return urlStr == null ? null : url.resolve(urlStr);
}

String? selectText(Uri url, Document doc, List<Selector> selectors) {
  for (final selector in selectors) {
    final element = selector.selector.selectFirst(doc.documentElement!);

    if (element == null) {
      continue;
    }

    final text = _textFromElement(element, selector);
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

List<String> selectList(Uri url, Document doc, List<ListSelector> selectors) {
  List<String> list = [];

  for (final selector in selectors) {
    Set<Element> elements = {};

    // Select elements
    if (selector.firstOnly) {
      final element = selector.selector.selectFirst(doc.documentElement!);
      if (element != null) {
        elements.add(element);
      }
    } else {
      elements = selector.selector.select(doc.documentElement!);
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
