import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/index.dart';
import '../../../shared/index.dart';
import '../../index.dart';

enum LeadingIcon { back, close, hambuger, none }

enum AppBarTitle { logo, text, none }

class AppTopBar extends HookConsumerWidget implements PreferredSizeWidget {
  AppTopBar({
    super.key,
    this.text,
    this.onTitlePressed,
    this.leadingIcon,
    this.titleType = AppBarTitle.text,
    this.title,
    this.centerTitle = true,
    this.enableSearchBar = false,
    this.elevation = 1.0,
    this.actions,
    this.height,
    this.automaticallyImplyLeading = false,
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
    this.onSearchBarChanged,
  }) : preferredSize = Size.fromHeight(height ?? AppBar().preferredSize.height);

  final String? text;
  final VoidCallback? onTitlePressed;
  final LeadingIcon? leadingIcon;
  final AppBarTitle titleType;
  final Widget? title;
  final bool? centerTitle;
  final bool? enableSearchBar;
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
  final Function(String?)? onSearchBarChanged;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _enableSearchBar = useState(false);
    final _showLeading = useState(true);
    final _animation = useAnimationController(duration: 400.ms);
    final _textController = useTextEditingController();
    final _focusNode = useFocusNode();
    final _currentPath = context.router.current.path;
    // Log.d('Appbar: ${ref.nav.canPop} - ${context.router.current.parent?.path} > ${context.router.current.path}');

    Widget _buildPrefixIcon() {
      return IconButton(
        onPressed: () {
          FocusScope.of(context).requestFocus(_focusNode);
          _enableSearchBar.value = !_enableSearchBar.value;
        },
        icon: const Icon(Icons.search, size: 24),
      );
    }

    Widget _buildSuffixIcon() {
      return AnimatedBuilder(
        builder: (context, widget) => Transform.rotate(angle: _animation.value * 2.0 * pi, child: widget),
        animation: _animation,
        child: AnimatedOpacity(
          opacity: _enableSearchBar.value ? 1.0 : 0.0,
          duration: 200.ms,
          child: IconButton(
            onPressed: () {
              _textController.clear();
              final FocusScopeNode currentScope = FocusScope.of(context);
              if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
              _enableSearchBar.value = !_enableSearchBar.value;
              _showLeading.value = true;
              _animation.status == AnimationStatus.completed ? _animation.reverse() : _animation.forward();
            },
            icon: const Icon(Icons.close, size: 24),
          ),
        ),
      );
    }

    Widget _buildInputSearchBar() {
      return Stack(
        alignment: Alignment.center,
        children: [
          AnimatedOpacity(
            opacity: _enableSearchBar.value ? 0.0 : 1.0,
            duration: _enableSearchBar.value ? 200.ms : 400.ms,
            child: Center(
              child: Transform.translate(
                offset: Offset(_currentPath.isNotEmpty ? -34 : 0, 0),
                child: _BuildTitle(titleType: titleType, text: text, titleTextStyle: titleTextStyle, leadingIconColor: leadingIconColor),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: AnimatedContainer(
              duration: 400.ms,
              width: _enableSearchBar.value ? AppSize.screenWidth : 48,
              curve: Curves.easeOut,
              child: AppInput(
                controller: _textController,
                focusNode: _focusNode,
                prefixIcon: _buildPrefixIcon(),
                suffixIcon: _buildSuffixIcon(),
                hintText: L.current.searching,
                enableBackgroundColor: false,
                enableBorder: false,
                onChanged: onSearchBarChanged,
              ),
            ),
          ),
        ],
      );
    }

    Widget _buildLeading() {
      return AnimatedOpacity(
        opacity: !_enableSearchBar.value ? 1.0 : 0.0,
        duration: 200.ms,
        onEnd: () => _showLeading.value = _enableSearchBar.value == true ? false : true,
        child: AppInkWell(
          onTap: () => ref.nav.pop(),
          child: Padding(
            padding: EdgeInsets.only(left: leadingIcon == LeadingIcon.close ? 0 : 10),
            child: leadingIcon == LeadingIcon.close ? const Icon(Icons.close, size: 24) : const Icon(Icons.arrow_back_ios, size: 24),
          ),
        ),
      );
    }

    return AppBar(
      surfaceTintColor: Colors.transparent,
      toolbarHeight: preferredSize.height,
      automaticallyImplyLeading: automaticallyImplyLeading,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      shadowColor: shadowColor,
      shape: shape ?? Border(bottom: BorderSide(color: context.theme.dividerColor, width: 1)),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      primary: primary,
      excludeHeaderSemantics: excludeHeaderSemantics,
      titleSpacing: leadingIcon == null && enableSearchBar == false ? 16 : titleSpacing,
      toolbarOpacity: toolbarOpacity,
      bottomOpacity: bottomOpacity,
      leadingWidth: leadingWidth,
      systemOverlayStyle: systemOverlayStyle ?? (MediaQuery.platformBrightnessOf(context) == Brightness.dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark),
      leading: leading ?? (_currentPath.isNotEmpty && _showLeading.value ? _buildLeading() : null),
      centerTitle: centerTitle,
      title: title ?? (enableSearchBar == true ? _buildInputSearchBar() : _BuildTitle(titleType: titleType, text: text, titleTextStyle: titleTextStyle, leadingIconColor: leadingIconColor, onTitlePressed: onTitlePressed)),
      actions: actions,
      elevation: elevation,
    );
  }
}

class _BuildTitle extends StatelessWidget {
  const _BuildTitle({this.titleType, this.text, this.titleTextStyle, this.leadingIconColor, this.onTitlePressed});

  final AppBarTitle? titleType;
  final String? text;
  final TextStyle? titleTextStyle;
  final Color? leadingIconColor;
  final VoidCallback? onTitlePressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTitlePressed,
        behavior: HitTestBehavior.translucent,
        child: titleType == AppBarTitle.text
            ? AppText(text ?? '', textStyle: titleTextStyle, type: TextType.header)
            : titleType == AppBarTitle.logo
                ? Assets.images.logo.svg(colorFilter: ColorFilter.mode(leadingIconColor ?? Colors.transparent, BlendMode.srcIn), width: 10, height: 10)
                : null);
  }
}
