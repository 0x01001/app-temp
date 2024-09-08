import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

import '../../shared/index.dart';

enum AppListCellType { normal, button, customization }

enum AppListCellAccessoryType { none, checkmark, detail, switchOnOff, checkBox }

const Color kStaticBackgroundColor = Colors.transparent;
const double kStaticHeaderHeight = 56;
const double kStaticHeaderHeightNormal = 40;
const double kStaticHeaderTitleIntent = 15;
const double kStaticButtonHeight = 50;

class AppSectionData {
  const AppSectionData({
    this.headerTitle,
    this.headerTitleStyle,
    this.headerHeight,
    this.headerTitleIntent = kStaticHeaderTitleIntent,
    this.itemList,
    this.headerBackgroundColor = kStaticBackgroundColor,
  })  : assert(itemList != null && itemList.length > 0),
        super();

  final String? headerTitle;
  final TextStyle? headerTitleStyle;
  final double? headerHeight;
  final double? headerTitleIntent;
  final Color? headerBackgroundColor;
  final List<AppItemData>? itemList;
}

class AppItemData {
  AppItemData({
    this.cellType = AppListCellType.normal,
    this.leading,
    this.title,
    this.titleStyle,
    this.subtitle,
    this.subtitleStyle,
    this.accessoryType = AppListCellAccessoryType.none,
    this.accessoryString,
    this.customTrailing,
    this.cellColor,
    this.onTap,
    this.accItemValue = false,
    this.selected = false,
    this.onChanged,
    this.buttonTitle,
    this.buttonTitleColor,
    this.buttonColor,
    this.customizeContent,
  }) : assert(() {
          if (cellType == AppListCellType.normal && (leading == null && title == null && subtitle == null)) {
            throw AssertionError('List cell must have a leading or title or subtitle');
          }
          if (cellType == AppListCellType.customization && customizeContent == null) {
            throw AssertionError('Must specify the content when cells type is customization');
          }
          if (customTrailing != null && accessoryType != AppListCellAccessoryType.none) {
            throw AssertionError('Could not set trailing widget when accessory type != none');
          }
          if (accessoryString != null && accessoryType != AppListCellAccessoryType.detail) {
            throw AssertionError('Accessory string only can be shown when cell\'s accessory type is accDetail');
          }
          return true;
        }());

  final AppListCellType? cellType;

  final Widget? leading;
  final String? title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final AppListCellAccessoryType? accessoryType;
  final String? accessoryString;
  final Widget? customTrailing;
  final Color? cellColor;
  final VoidCallback? onTap;
  final bool? selected;
  final bool? accItemValue;
  final ValueChanged<bool?>? onChanged;

  final String? buttonTitle;
  final Color? buttonColor;
  final Color? buttonTitleColor;

  final Widget? customizeContent;
}

class AppListView extends StatelessWidget {
  const AppListView({
    required this.sections,
    super.key,
    this.shrinkWrap,
    this.padding,
    this.separatorBuilder,
  }) : assert(sections.length > 0);

  final bool? shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final IndexedWidgetBuilder? separatorBuilder;
  final List<AppSectionData> sections;

  int _preCalItemCount() {
    int count = sections.length;
    for (var i = 0; i < sections.length; i++) {
      final AppSectionData sectionData = sections[i];
      final int itemCount = sectionData.itemList?.length ?? 0;
      count += itemCount;
    }

    return count;
  }

  Widget _buildSectionHeader(AppSectionData sectionData, BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final Widget? titleWidget = sectionData.headerTitle == null
        ? null
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[Text(sectionData.headerTitle ?? '', style: sectionData.headerTitleStyle ?? TextStyle(color: Colors.grey, fontSize: themeData.textTheme.titleMedium?.fontSize))],
          );
    final EdgeInsetsGeometry padding = sectionData.headerTitleIntent != null ? (isRtl ? EdgeInsets.only(right: sectionData.headerTitleIntent ?? 0) : EdgeInsets.only(left: sectionData.headerTitleIntent ?? 0)) : EdgeInsets.zero;
    final headerHeight = sectionData.headerHeight ?? (sectionData.headerTitle != null ? kStaticHeaderHeight : kStaticHeaderHeightNormal);
    return Container(
      color: sectionData.headerBackgroundColor,
      height: headerHeight,
      padding: padding,
      child: titleWidget,
    );
  }

  Widget _buildItemCell(AppItemData itemData, BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final titleText = itemData.title == null ? null : Text(itemData.title ?? '', style: itemData.titleStyle);
    final subtitleText = itemData.subtitle == null ? null : Text(itemData.subtitle ?? '', style: itemData.subtitleStyle);
    final Widget? accesssoryWidget = _getAccessoryWidget(itemData, context);
    final Widget? trailingWidget = accesssoryWidget ?? itemData.customTrailing;
    return Material(
        color: itemData.cellColor ?? (AdaptiveTheme.of(context).mode.isDark ? themeData.colorScheme.surface : Colors.white),
        child: InkWell(
          onTap: itemData.onTap,
          child: ListTile(
            leading: itemData.leading,
            title: titleText,
            subtitle: subtitleText,
            trailing: trailingWidget,
            selected: itemData.selected ?? false,
            titleTextStyle: themeData.textTheme.bodyMedium,
            subtitleTextStyle: themeData.textTheme.labelMedium,
            selectedColor: themeData.colorScheme.secondary,
          ),
        ));
  }

  Widget _buildButtonCell(AppItemData itemData, BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Material(
      color: itemData.cellColor ?? (AdaptiveTheme.of(context).mode.isDark ? themeData.colorScheme.surface : Colors.white),
      child: InkWell(
        onTap: itemData.onTap,
        child: SizedBox(
          height: kStaticButtonHeight,
          child: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                child: Text(
                  itemData.buttonTitle ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: itemData.buttonTitleColor, fontSize: themeData.textTheme.bodyMedium?.fontSize, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget? _getAccessoryWidget(AppItemData itemData, BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    switch (itemData.accessoryType) {
      case AppListCellAccessoryType.checkmark:
        return const Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[Icon(Icons.check), SizedBox(width: 6)], // align right side
        );
      case AppListCellAccessoryType.detail:
        {
          final icon = Container(
            padding: const EdgeInsets.only(top: 4), // fix not align with accessory text
            child: const Icon(Icons.navigate_next),
          );
          if (itemData.accessoryString != null && itemData.accessoryString!.isNotEmpty) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(itemData.accessoryString ?? '', style: TextStyle(color: Colors.grey, fontSize: themeData.textTheme.bodyMedium?.fontSize)),
                icon,
              ],
            );
          }
          return icon;
        }
      case AppListCellAccessoryType.switchOnOff:
        return Switch(
          value: itemData.accItemValue ?? false,
          onChanged: itemData.onChanged,
          activeTrackColor: themeData.colorScheme.secondary,
        );
      case AppListCellAccessoryType.checkBox:
        return Checkbox(
          value: itemData.accItemValue,
          onChanged: itemData.onChanged,
        );
      case AppListCellAccessoryType.none:
      default:
        return null;
    }
  }

  Widget _appendCellSeparator(Widget? cell, BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        cell ?? const SizedBox.shrink(),
        if (cell != null) Divider(color: themeData.dividerColor, height: Constant.borderHeight),
      ],
    );
  }

  List<Widget> _buildCells(BuildContext context) {
    final List<Widget> cellList = [];
    for (AppSectionData sectionData in sections) {
      // add header
      final Widget sectionHeader = _buildSectionHeader(sectionData, context);
      cellList.add(sectionHeader);
      // add section cells
      for (AppItemData itemData in sectionData.itemList ?? []) {
        Widget? itemCell;
        if (itemData.cellType == AppListCellType.normal) {
          itemCell = _buildItemCell(itemData, context);
        } else if (itemData.cellType == AppListCellType.button) {
          itemCell = _buildButtonCell(itemData, context);
        } else {
          // customization
          itemCell = itemData.customizeContent;
        }
        // add last cell's bottom divider
        if (sectionData == sections.last && itemData == sectionData.itemList?.last) {
          itemCell = _appendCellSeparator(itemCell, context);
        }
        if (itemCell != null) {
          cellList.add(itemCell);
        }
      }
    }
    return cellList;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final IndexedWidgetBuilder sepBuilder = separatorBuilder ??
        (BuildContext context, int index) {
          return Divider(color: themeData.dividerColor, height: Constant.borderHeight);
        };
    final List<Widget> cells = _buildCells(context);
    return Container(
      color: kStaticBackgroundColor,
      child: ListView.separated(
          shrinkWrap: shrinkWrap ?? false,
          padding: padding,
          itemBuilder: (BuildContext context, int index) {
            return cells[index];
          },
          separatorBuilder: sepBuilder,
          itemCount: _preCalItemCount()),
    );
  }
}
