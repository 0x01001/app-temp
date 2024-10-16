import 'package:flutter/material.dart';

import '../../resources/index.dart';

class L {
  L._(); // Private constructor
  static late final L _instance = L._(); // Lazy initialization
  static L get instance => _instance; // Getter to access the instance

  static BuildContext? _context;
  void init(BuildContext context) {
    _context = context;
  }

  static S get current => S.of(_context!);
}
