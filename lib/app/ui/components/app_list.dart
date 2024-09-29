import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/index.dart';
import '../../../shared/index.dart';
import '../../index.dart';

enum AppListViewType { none, separated }

class AppListView<T> extends ConsumerWidget {
  const AppListView({
    this.itemBuilder,
    super.key,
    this.type = AppListViewType.none,
    this.shrinkWrap,
    this.padding,
    this.separatorBuilder,
    this.items = const [],
    this.physics,
  });

  final AppListViewType? type;
  final bool? shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final IndexedWidgetBuilder? separatorBuilder;
  final List<T>? items;
  final IndexedWidgetBuilder? itemBuilder;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (items?.isEmpty == true) return const AppNoData();

    return ListView.separated(
      physics: physics,
      shrinkWrap: shrinkWrap ?? false,
      padding: padding,
      itemBuilder: itemBuilder ?? (_, __) => const SizedBox.shrink(),
      separatorBuilder: separatorBuilder ?? (_, __) => _SeparatorBuilder(type: type),
      itemCount: items?.length ?? 0,
    );
  }
}

class _SeparatorBuilder extends StatelessWidget {
  const _SeparatorBuilder({this.type});

  final AppListViewType? type;

  @override
  Widget build(BuildContext context) {
    return type == AppListViewType.separated ? Divider(color: context.theme.dividerColor, height: Constant.borderHeight) : const SizedBox.shrink();
  }
}

// enum CellType { normal, button, customization }

// enum CellAccessoryType { none, checkmark, detail, switchOnOff, checkBox }

// const Color kStaticBackgroundColor = Colors.transparent;
// const double kStaticHeaderHeight = 56;
// const double kStaticHeaderHeightNormal = 40;
// const double kStaticHeaderTitleIntent = 15;
// const double kStaticButtonHeight = 50;

// class SectionData {
//   const SectionData({
//     this.headerTitle,
//     this.headerTitleStyle,
//     this.headerHeight,
//     this.headerTitleIntent = kStaticHeaderTitleIntent,
//     this.items,
//     this.headerBackgroundColor = kStaticBackgroundColor,
//   })  : assert(items != null && items.length > 0),
//         super();

//   final String? headerTitle;
//   final TextStyle? headerTitleStyle;
//   final double? headerHeight;
//   final double? headerTitleIntent;
//   final Color? headerBackgroundColor;
//   final List<CellItemData>? items;
// }

// class CellItemData {
//   CellItemData({
//     this.type = CellType.normal,
//     this.leading,
//     this.title,
//     this.titleStyle,
//     this.subtitle,
//     this.subtitleStyle,
//     this.accessoryType = CellAccessoryType.none,
//     this.accessoryString,
//     this.customTrailing,
//     this.cellColor,
//     this.onTap,
//     this.accItemValue = false,
//     this.selected = false,
//     this.onChanged,
//     this.buttonTitle,
//     this.buttonTitleColor,
//     this.buttonColor,
//     this.customizeContent,
//   }) : assert(() {
//           if (type == CellType.normal && (leading == null && title == null && subtitle == null)) {
//             throw AssertionError('List cell must have a leading or title or subtitle');
//           }
//           if (type == CellType.customization && customizeContent == null) {
//             throw AssertionError('Must specify the content when cells type is customization');
//           }
//           if (customTrailing != null && accessoryType != CellAccessoryType.none) {
//             throw AssertionError('Could not set trailing widget when accessory type != none');
//           }
//           if (accessoryString != null && accessoryType != CellAccessoryType.detail) {
//             throw AssertionError('Accessory string only can be shown when cell\'s accessory type is accDetail');
//           }
//           return true;
//         }());

//   final CellType? type;

//   final Widget? leading;
//   final String? title;
//   final TextStyle? titleStyle;
//   final String? subtitle;
//   final TextStyle? subtitleStyle;
//   final CellAccessoryType? accessoryType;
//   final String? accessoryString;
//   final Widget? customTrailing;
//   final Color? cellColor;
//   final VoidCallback? onTap;
//   final bool? selected; // ListTile
//   final bool? accItemValue; // for Switch
//   final ValueChanged<bool?>? onChanged; // for Switch

//   final String? buttonTitle;
//   final Color? buttonColor;
//   final Color? buttonTitleColor;

//   final Widget? customizeContent;
// }

// class _BuildCells<T> extends StatelessWidget {
//   const _BuildCells({required this.sections, required this.items, required this.index, required this.ref});

//   final List<SectionData>? sections;
//   final List<T>? items;
//   final int index;
//   final WidgetRef ref;

//   @override
//   Widget build(BuildContext context) {
//     final List<Widget> cellList = [];

//     if (sections?.isNotEmpty ?? false) {
//       final sectionData = sections![index];
//       // add header
//       final Widget sectionHeader = _BuildSectionHeader(sectionData: sectionData);
//       cellList.add(sectionHeader);
//       // add section cells
//       for (CellItemData itemData in sectionData.items ?? []) {
//         final Widget? itemCell = _GetCell(item: itemData, ref: ref);
//         // add last cell's bottom divider
//         // if (sectionData == sections?.last && itemData == sectionData.items?.last) {
//         //   itemCell = _AppendCellSeparator(cell: itemCell);
//         // }
//         if (itemCell != null) cellList.add(itemCell);
//       }
//     }

//     if (items?.isNotEmpty ?? false) {
//       try {
//         final Widget? itemCell = _GetCell(item: items![index] as CellItemData, ref: ref);
//         if (itemCell != null) cellList.add(itemCell);
//       } catch (e) {
//         Log.e('AppListView > _BuildCells: $e');
//       }
//     }

//     return Column(children: cellList);
//   }
// }

// class _GetCell extends StatelessWidget {
//   const _GetCell({required this.item, required this.ref});

//   final CellItemData item;
//   final WidgetRef ref;

//   @override
//   Widget build(BuildContext context) {
//     if (item.type == CellType.normal) {
//       return _BuildItemCell(itemData: item, ref: ref);
//     } else if (item.type == CellType.button) {
//       return _BuildButtonCell(itemData: item, ref: ref);
//     } else {
//       return item.customizeContent ?? const SizedBox.shrink();
//     }
//   }
// }

// class _BuildButtonCell extends StatelessWidget {
//   const _BuildButtonCell({required this.itemData, required this.ref});

//   final CellItemData itemData;
//   final WidgetRef ref;

//   @override
//   Widget build(BuildContext context) {
//     // final _isDarkMode = ref.watch(isDarkModeProvider) ?? false;
//     return Material(
//       color: itemData.cellColor ?? context.theme.colorScheme.surface, // (_isDarkMode ? context.theme.colorScheme.surface : Colors.white),
//       child: InkWell(
//         onTap: itemData.onTap,
//         child: SizedBox(
//           height: kStaticButtonHeight,
//           child: Flex(
//             direction: Axis.horizontal,
//             children: <Widget>[
//               Expanded(
//                 child: Text(
//                   itemData.buttonTitle ?? '',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: itemData.buttonTitleColor, fontSize: context.theme.textTheme.bodyMedium?.fontSize, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _BuildItemCell extends StatelessWidget {
//   const _BuildItemCell({required this.itemData, required this.ref});

//   final CellItemData itemData;
//   final WidgetRef ref;

//   @override
//   Widget build(BuildContext context) {
//     // final _isDarkMode = ref.watch(isDarkModeProvider) ?? false;
//     final ThemeData themeData = context.theme;
//     final titleText = itemData.title == null ? null : Text(itemData.title ?? '', style: itemData.titleStyle);
//     final subtitleText = itemData.subtitle == null ? null : Text(itemData.subtitle ?? '', style: itemData.subtitleStyle);
//     final Widget? accesssoryWidget = _GetAccessoryWidget(itemData: itemData);
//     final Widget? trailingWidget = accesssoryWidget ?? itemData.customTrailing;
//     return Material(
//       color: itemData.cellColor ?? themeData.colorScheme.surface, // (_isDarkMode ? themeData.colorScheme.surface : Colors.white),
//       child: InkWell(
//         onTap: itemData.onTap,
//         child: ListTile(
//           leading: itemData.leading,
//           title: titleText,
//           subtitle: subtitleText,
//           trailing: trailingWidget,
//           selected: itemData.selected ?? false,
//           titleTextStyle: themeData.textTheme.bodyMedium,
//           subtitleTextStyle: themeData.textTheme.labelMedium,
//           selectedColor: themeData.colorScheme.secondary,
//         ),
//       ),
//     );
//   }
// }

// class _AppendCellSeparator extends StatelessWidget {
//   const _AppendCellSeparator({this.cell});

//   final Widget? cell;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         cell ?? const SizedBox.shrink(),
//         if (cell != null) Divider(color: context.theme.dividerColor, height: Constant.borderHeight),
//       ],
//     );
//   }
// }

// class _GetAccessoryWidget extends StatelessWidget {
//   const _GetAccessoryWidget({required this.itemData});

//   final CellItemData itemData;

//   @override
//   Widget build(BuildContext context) {
//     switch (itemData.accessoryType) {
//       case CellAccessoryType.checkmark:
//         return const Row(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[Icon(Icons.check), SizedBox(width: 6)], // align right side
//         );
//       case CellAccessoryType.detail:
//         {
//           final icon = Container(
//             padding: const EdgeInsets.only(top: 4), // fix not align with accessory text
//             child: const Icon(Icons.navigate_next),
//           );
//           if (itemData.accessoryString != null && itemData.accessoryString!.isNotEmpty) {
//             return Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Text(itemData.accessoryString ?? '', style: TextStyle(color: Colors.grey, fontSize: context.theme.textTheme.bodyMedium?.fontSize)),
//                 icon,
//               ],
//             );
//           }
//           return icon;
//         }
//       case CellAccessoryType.switchOnOff:
//         return Switch(
//           value: itemData.accItemValue ?? false,
//           onChanged: itemData.onChanged,
//           activeTrackColor: context.colors.secondary,
//         );
//       case CellAccessoryType.checkBox:
//         return Checkbox(
//           value: itemData.accItemValue,
//           onChanged: itemData.onChanged,
//         );
//       case CellAccessoryType.none:
//       default:
//         return const SizedBox.shrink();
//     }
//   }
// }

// class _BuildSectionHeader extends StatelessWidget {
//   const _BuildSectionHeader({required this.sectionData});

//   final SectionData sectionData;

//   @override
//   Widget build(BuildContext context) {
//     final isRtl = Directionality.of(context) == TextDirection.rtl;
//     final Widget? titleWidget = sectionData.headerTitle == null
//         ? null
//         : Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [AppText(sectionData.headerTitle ?? '', type: TextType.title, color: Colors.grey)],
//           );
//     final EdgeInsetsGeometry padding = sectionData.headerTitleIntent != null ? (isRtl ? EdgeInsets.only(right: sectionData.headerTitleIntent ?? 0) : EdgeInsets.only(left: sectionData.headerTitleIntent ?? 0)) : EdgeInsets.zero;
//     final headerHeight = sectionData.headerHeight ?? (sectionData.headerTitle != null ? kStaticHeaderHeight : kStaticHeaderHeightNormal);
//     return Container(
//       alignment: Alignment.centerLeft,
//       color: sectionData.headerBackgroundColor,
//       height: headerHeight,
//       padding: padding,
//       child: titleWidget,
//     );
//   }
// }
