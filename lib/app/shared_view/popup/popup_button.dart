import 'package:freezed_annotation/freezed_annotation.dart';

part 'popup_button.freezed.dart';

@freezed
class PopupButton with _$PopupButton {
  const PopupButton._();

  const factory PopupButton({
    String? text,
    void Function()? onPressed,
    @Default(false) bool isDefault,
  }) = _PopupButton;
}
