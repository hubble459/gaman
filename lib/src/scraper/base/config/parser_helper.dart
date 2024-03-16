import 'package:gaman/gaman.dart';
import 'package:html/dom.dart';

String selectRequiredText(Uri url, Document doc, List<Selector> selectors, String error) {
  final text = selectText(url, doc, selectors);
  if (text == null) {
    throw Exception(error);
  }
  return text;
}

String? selectText(Uri url, Document doc, List<Selector> selectors) {
  String? text;

  for (final selector in selectors) {
    final element = doc.querySelector(selector.selector);
    if (element != null) {
      switch (selector.textType) {
        case TextType.allText:
          text = element.text;
          break;
        case TextType.ownText:
          text = element.text;
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
      if (text != null) {
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
        break;
      }
    }
  }

  return text;
}
