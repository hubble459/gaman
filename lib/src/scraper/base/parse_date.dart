import 'package:jiffy/jiffy.dart';

Jiffy? parseDate(String postedString, List<String> dateFormats) {
  Jiffy? updated;
  postedString = postedString.trim().replaceFirst(RegExp(r"^updated *[:=\-~\n\r\t]* *", caseSensitive: false), '').trim();
  final epoch = int.tryParse(postedString);
  if (epoch != null) {
    updated = Jiffy.parseFromMicrosecondsSinceEpoch(epoch);
  } else {
    if (dateFormats.isNotEmpty) {
      for (final format in dateFormats) {
        try {
          updated = Jiffy.parse(postedString, pattern: format);
          break;
        } catch (e) {
          // ignored
        }
      }
    } else {
      try {
        updated = Jiffy.parse(postedString);
      } catch (e) {
        // ignored
      }
    }
    updated ??= parseScuffedDate(postedString);
  }

  return updated;
}

Jiffy? parseScuffedDate(String postedString) {
  postedString = postedString
      // Trim
      .trim()
      .replaceAll(RegExp("^(an?|one)", caseSensitive: false), '1')
      .replaceAll(RegExp(r"[ \t\n\r]+"), '');

  if (RegExp("n(o|e)w|hot", caseSensitive: false).hasMatch(postedString)) {
    return Jiffy.now();
  }

  const number = r'(\d+(\.\d+)?)';
  int ms = 0;
  RegExpMatch? m;
  int n;

  if ((m = RegExp('${number}y', caseSensitive: false).firstMatch(postedString)) != null) {
    n = int.parse(m!.group(1)!);
    ms = n * 31540000000;
  } else if ((m = RegExp('${number}mo', caseSensitive: false).firstMatch(postedString)) != null) {
    n = int.parse(m!.group(1)!);
    ms = n * 2628000000;
  } else if ((m = RegExp('${number}w', caseSensitive: false).firstMatch(postedString)) != null) {
    n = int.parse(m!.group(1)!);

    ms = n * 604800000;
  } else if ((m = RegExp('${number}d', caseSensitive: false).firstMatch(postedString)) != null) {
    n = int.parse(m!.group(1)!);

    ms = n * 86400000;
  } else if ((m = RegExp('${number}h', caseSensitive: false).firstMatch(postedString)) != null) {
    n = int.parse(m!.group(1)!);

    ms = n * 3600000;
  } else if ((m = RegExp('${number}m', caseSensitive: false).firstMatch(postedString)) != null) {
    n = int.parse(m!.group(1)!);

    ms = n * 60000;
  } else if ((m = RegExp('${number}s', caseSensitive: false).firstMatch(postedString)) != null) {
    n = int.parse(m!.group(1)!);
    ms = n * 1000;
  }

  if (ms != 0) {
    return Jiffy.now().subtract(milliseconds: ms);
  } else {
    return null;
  }
}
