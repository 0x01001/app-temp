import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class UiHelper {
  bool useIsFocused(FocusNode node) {
    final isFocused = useState(node.hasFocus);

    useEffect(
      () {
        void listener() {
          isFocused.value = node.hasFocus;
        }

        node.addListener(listener);
        return () => node.removeListener(listener);
      },
      [node],
    );

    return isFocused.value;
  }
}
