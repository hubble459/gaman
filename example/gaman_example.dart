import 'dart:convert';
import 'dart:io';

import 'package:gaman/gaman.dart';
import 'package:yaml/yaml.dart';

void main() async {
  final yamlFiles = ["./example/madara.yaml"];
  final List<dynamic> configFiles = [];

  for (var yamlFilePath in yamlFiles) {
    final configFile = File(yamlFilePath);
    final configYaml = loadYaml(configFile.readAsStringSync());
    final configJson = json.decode(json.encode(configYaml));
    configFiles.add(configJson);
  }

  final manager = ConfigManager(configFiles);

  final url = Uri.parse("https://isekaiscan.top/manga/100-year-old-top-chef");
  final doc = await HtmlScraper.fetch(url);
  if (manager.isSupportedDocument(url, doc)) {
    final manga = await manager.parseManga(url, doc: doc);
    print(manga);
  }
}
