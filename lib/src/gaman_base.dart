// TODO: Put public facing types in this file.
import 'package:gio/gio.dart' as gio;

export 'package:gaman/src/scraper/base/config.dart';
export 'package:gaman/src/scraper/base/selector.dart';
export 'package:gaman/src/scraper/base/config_scraper.dart';
export 'package:gaman/src/scraper/base/html_scraper.dart';
export 'package:gaman/src/scraper/base/base_scraper.dart';
export 'package:gaman/src/scraper/config_manager.dart';
export 'package:gaman/src/model/manga.dart';
export 'package:gaman/src/model/chapter.dart';

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}

void init() {
  gio.Gio.option = gio.GioOption(
    enableLog: true,
  );
}
