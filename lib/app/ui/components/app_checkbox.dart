import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../resources/index.dart';
import '../../index.dart';

class AppCheckBox extends HookWidget {
  const AppCheckBox({this.text, this.value, this.onChanged, this.enabled, this.splashColor, this.padding, this.contentPadding = 0.0, super.key});

  final Function(bool?)? onChanged;
  final String? text;
  final bool? value;
  final bool? enabled;
  final Color? splashColor;
  final EdgeInsetsGeometry? padding;
  final double contentPadding;

  @override
  Widget build(BuildContext context) {
    final _data = useState(value ?? false);
    useValueChanged(value, (_, __) => _data.value = value ?? false); //note: like didUpdateWidget for StatefulWidget !important

    return AppInkWell(
      splashColor: splashColor,
      onTap: enabled == true
          ? null
          : () {
              _data.value = !_data.value;
              onChanged?.call(_data.value);
            },
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            if (text != null)
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(padding: EdgeInsets.only(left: 33 + contentPadding, right: contentPadding), child: AppText(text, maxLines: 2)),
              ),
            SizedBox(
              width: 36,
              height: 36,
              child: Checkbox(
                checkColor: Colors.white,
                activeColor: context.colors.surface,
                fillColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
                  if (states.contains(WidgetState.disabled)) {
                    if (states.contains(WidgetState.selected)) {
                      return context.colors.primary;
                    }
                    return Colors.transparent;
                  }
                  if (states.contains(WidgetState.selected)) {
                    return context.colors.primary;
                  }
                  return Colors.transparent;
                }),
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
