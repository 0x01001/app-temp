import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../resources/index.dart';
import '../../shared/index.dart';
import '../index.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  AppTopBar({
    super.key,
    this.text,
    this.onTitlePressed,
    this.leadingIcon,
    this.titleType = AppBarTitle.text,
    this.centerTitle = true,
    this.elevation = 1.0,
    this.actions,
    this.height,
    this.automaticallyImplyLeading = true,
    this.flexibleSpace,
    this.bottom,
    this.shadowColor,
    this.shape,
    this.backgroundColor,
    this.foregroundColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.excludeHeaderSemantics = false,
    this.titleSpacing = 0.0,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.leadingWidth,
    this.titleTextStyle,
    this.systemOverlayStyle,
    this.leadingIconColor,
    this.leading,
  }) : preferredSize = Size.fromHeight(
          height ?? 56,
        );

  final String? text;
  final VoidCallback? onTitlePressed;
  final LeadingIcon? leadingIcon;
  final AppBarTitle titleType;
  final bool? centerTitle;
  final double? elevation;
  final List<Widget>? actions;
  final double? height;
  final bool automaticallyImplyLeading;
  final Widget? flexibleSpace;
  final Widget? leading;
  final PreferredSizeWidget? bottom;
  final Color? shadowColor;
  final ShapeBorder? shape;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;
  final bool primary;
  final bool excludeHeaderSemantics;
  final double? titleSpacing;
  final double toolbarOpacity;
  final double bottomOpacity;
  final double? leadingWidth;
  final TextStyle? titleTextStyle;
  final Color? leadingIconColor;
  final SystemUiOverlayStyle? systemOverlayStyle;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    final _nav = getIt.get<AppNavigator>();
    return AppBar(
      surfaceTintColor: Colors.transparent,
      toolbarHeight: preferredSize.height,
      automaticallyImplyLeading: automaticallyImplyLeading,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      shadowColor: shadowColor,
      shape: shape ?? Border(bottom: BorderSide(color: Theme.of(context).dividerColor, width: 1)),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      primary: primary,
      excludeHeaderSemantics: excludeHeaderSemantics,
      titleSpacing: leadingIcon == null ? 15 : titleSpacing,
      toolbarOpacity: toolbarOpacity,
      bottomOpacity: bottomOpacity,
      leadingWidth: leadingWidth,
      systemOverlayStyle: systemOverlayStyle ?? (MediaQuery.platformBrightnessOf(context) == Brightness.dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark),
      leading: leading ??
          (_nav.canPop
              ? GestureDetector(
                  onTap: () => _nav.pop(),
                  child: Padding(
                    padding: EdgeInsets.only(left: leadingIcon == LeadingIcon.close ? 0 : 10),
                    child: leadingIcon == LeadingIcon.close ? const Icon(Icons.close, size: 24) : const Icon(Icons.arrow_back_ios, size: 24),
                  ),
                )
              : null),
      centerTitle: centerTitle,
      title: GestureDetector(
        onTap: onTitlePressed,
        behavior: HitTestBehavior.translucent,
        child: titleType == AppBarTitle.text
            ? AppText(text ?? '', textStyle: titleTextStyle, type: TextType.header)
            : titleType == AppBarTitle.logo
                ? _buildIcon(Assets.images.logo)
                : null,
      ),
      actions: actions,
      elevation: elevation,
    );
  }

  Widget _buildIcon(SvgGenImage svg) {
    return svg.svg(color: leadingIconColor, width: 10, height: 10);
  }
}

enum LeadingIcon { back, close, hambuger, none }

enum AppBarTitle { logo, text, none }
