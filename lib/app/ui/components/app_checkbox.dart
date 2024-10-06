import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../index.dart';

class AppCheckBox extends HookWidget {
  const AppCheckBox({this.title, this.value, this.onChanged, this.enabled, super.key});

  final Function(bool?)? onChanged;
  final String? title;
  final bool? value;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    final _data = useState(value);
    useValueChanged(value, (_, __) => _data.value = value); //like didUpdateWidget for StatefulWidget

    return CheckboxListTile(
      enabled: enabled,
      title: Transform.translate(offset: const Offset(-8, 0), child: AppText(title)),
      value: _data.value,
      onChanged: (bool? val) {
        _data.value = val;
        onChanged?.call(val);
      },
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: const EdgeInsets.symmetric(horizontal: 7),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    );
  }
}
