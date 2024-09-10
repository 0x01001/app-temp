import 'dart:convert';

extension MapExt on Map<dynamic, dynamic> {
  String get prettyJSON {
    const encoder = JsonEncoder.withIndent('     ');
    return encoder.convert(this);
  }
}

extension ListExt on List<dynamic> {
  String get prettyJSON {
    const encoder = JsonEncoder.withIndent('     ');
    return encoder.convert(this);
  }

  List<dynamic> removeDuplicate() {
    return toSet().toList();
  }

  bool containsSubList(List<dynamic> subList) {
    for (var item in subList) {
      if (contains(item) == false) return false;
    }
    return true;
  }
}
