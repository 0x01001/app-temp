import 'dart:convert';

extension MapExt on Map {
  String get prettyJSON {
    const encoder = JsonEncoder.withIndent('     ');
    return encoder.convert(this);
  }
}

extension ListExt on List {
  String get prettyJSON {
    const encoder = JsonEncoder.withIndent('     ');
    return encoder.convert(this);
  }

  List removeDuplicate() {
    return toSet().toList();
  }

  bool containsSubList(List subList) {
    for (var item in subList) {
      if (contains(item) == false) return false;
    }
    return true;
  }
}
