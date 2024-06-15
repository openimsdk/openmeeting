extension StringExt on String {
  String splitStringEveryNChars({int n = 3, String separator = ' '}) {
    RegExp regExp = RegExp('.{1,$n}');
    Iterable<Match> matches = regExp.allMatches(this);
    List<String> parts = matches.map((match) => match.group(0)!).toList();

    return parts.join(separator);
  }
}

extension DateTimeExt on DateTime {
  int get secondsSinceEpoch => millisecondsSinceEpoch ~/ 1000;
}
