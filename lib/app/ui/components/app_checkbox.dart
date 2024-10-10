import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../index.dart';

class AppCheckBox extends HookWidget {
  const AppCheckBox({this.text, this.value, this.onChanged, this.enabled, super.key});

  final Function(bool?)? onChanged;
  final String? text;
  final bool? value;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    final _data = useState(value ?? false);
    useValueChanged(value, (_, __) => _data.value = value ?? false); //like didUpdateWidget for StatefulWidget

    return AppInkWell(
      onTap: enabled == true
          ? null
          : () {
              _data.value = !_data.value;
              onChanged?.call(_data.value);
            },
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          if (text != null)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(padding: const EdgeInsets.only(left: 33), child: AppText(text)),
            ),
          SizedBox(
            width: 36,
            height: 36,
            child: Checkbox(
              checkColor: Colors.white,
              activeColor: Colors.black,
              value: _data.value,
              onChanged: enabled == true
                  ? (value) {
                      onChanged?.call(value ?? false);
                      _data.value = !_data.value;
                    }
                  : null,
            ),
          ),
        ],
      ),
    );

    // return CheckboxListTile(
    //   enabled: enabled,
    //   title: Transform.translate(offset: const Offset(-8, 0), child: AppText(text)),
    //   value: _data.value,
    //   onChanged: (bool? val) {
    //     _data.value = val;
    //     onChanged?.call(val);
    //   },
    //   controlAffinity: ListTileControlAffinity.leading,
    //   contentPadding: const EdgeInsets.symmetric(horizontal: 7),
    //   shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    // );
  }
}
