// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:get_it/get_it.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:truvideo_enterprise/core/keyboard.dart';
// import 'package:truvideo_enterprise/model/message_member.dart';
// import 'package:truvideo_enterprise/service/messaging/_interface.dart';
// import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/message_list_item_model.dart';
// import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/message_list_item_model.dart';
// import 'package:truvideo_enterprise/widget/common/app_bar/message_list_item_model.dart';
// import 'package:truvideo_enterprise/widget/common/icon_button/message_list_item_model.dart';
// import 'package:truvideo_enterprise/widget/common/list/indicator_empty.dart';
// import 'package:truvideo_enterprise/widget/common/list/list.dart';
// import 'package:truvideo_enterprise/widget/common/scaffold/message_list_item_model.dart';
// import 'package:truvideo_enterprise/core/colors.dart';
// import 'package:truvideo_enterprise/widget/common/text_field/icon.dart';
// import 'package:truvideo_enterprise/widget/common/text_field/message_list_item_model.dart';
// import 'package:truvideo_enterprise/widget/dialog/messaging/delete_channel/message_list_item_model.dart';
// import 'package:truvideo_enterprise/widget/dialog/messaging/mark_as_archived/message_list_item_model.dart';
// import 'package:truvideo_enterprise/widget/dialog/messaging/mark_as_favorite/message_list_item_model.dart';
// import 'package:truvideo_enterprise/widget/mixin/back_button_exit.dart';
// import 'package:truvideo_enterprise/widget/screen/message_channel_list/list_item.dart';
//
// class ScreenMessageChannelArchivedList extends StatefulHookConsumerWidget {
//   static const String routeName = "/ScreenMessageChannelArchivedList";
//
//   const ScreenMessageChannelArchivedList({Key? key}) : super(key: key);
//
//   @override
//   _ScreenMessageChannelArchivedListState createState() => _ScreenMessageChannelArchivedListState();
// }
//
// class _ScreenMessageChannelArchivedListState extends ConsumerState<ScreenMessageChannelArchivedList> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   Future<bool> _onWillPop() async {
//     return false;
//     // if (_selecting) {
//     //   _cancelSelection();
//     //   return false;
//     // }
//     //
//     // return true;
//   }
//
//   _cancelSelection() {
//     // _selectedUuids = [];
//     // _selecting = false;
//     // setState(() {});
//   }
//
//   _close() {
//     Navigator.of(context).pop();
//   }
//
//   // _onPressed(MessagingChannelModel model) {
//   //   if (_selecting) {
//   //     if (_selectedUuids.any((e) => e == model.uuid)) {
//   //       _selectedUuids = _selectedUuids.where((e) => e != model.uuid).toList();
//   //     } else {
//   //       _selectedUuids = [..._selectedUuids, model.uuid];
//   //     }
//   //     _selecting = _selectedUuids.isNotEmpty;
//   //     setState(() {});
//   //     return;
//   //   }
//   // }
//   //
//   // _onLongPressed(MessagingChannelModel model) {
//   //   if (_selectedUuids.any((e) => e == model.uuid)) {
//   //     _selectedUuids = _selectedUuids.where((e) => e != model.uuid).toList();
//   //   } else {
//   //     _selectedUuids = [..._selectedUuids, model.uuid];
//   //   }
//   //   _selecting = _selectedUuids.isNotEmpty;
//   //   setState(() {});
//   // }
//   //
//   // bool get _isSearchVisible {
//   //   if (_selecting) return false;
//   //   if (_loadingItems) return false;
//   //   if (_error != null) return false;
//   //   if (_items.isEmpty) return false;
//   //   return true;
//   // }
//   //
//   // bool get _isFabVisible {
//   //   if (_selecting) return false;
//   //   if (_loadingItems) return false;
//   //   if (_error != null) return false;
//   //   if (_items.isEmpty) return false;
//   //   return true;
//   // }
//   //
//   // _onButtonDeleteSelectionPressed() async {
//   //   if (_selectedUuids.isEmpty) {
//   //     _cancelSelection();
//   //     return;
//   //   }
//   //
//   //   final deleted = await showCustomMessagingChannelDelete(_selectedUuids);
//   //   if (deleted) {
//   //     _cancelSelection();
//   //   }
//   // }
//   //
//   // _onButtonUnArchiveSelectionPressed() async {
//   //   if (_selectedUuids.isEmpty) {
//   //     _cancelSelection();
//   //     return;
//   //   }
//   //
//   //   final deleted = await showCustomMessagingChannelMarkAsArchived(_selectedUuids, false);
//   //   if (deleted) {
//   //     _cancelSelection();
//   //   }
//   // }
//   //
//   // _onButtonMarkAsFavoriteSelectionPressed() {
//   //   _processFavoriteSelection(true);
//   // }
//   //
//   // _onButtonUnMarkAsFavoriteSelectionPressed() {
//   //   _processFavoriteSelection(false);
//   // }
//   //
//   // _processFavoriteSelection(bool value) async {
//   //   if (_selectedUuids.isEmpty) {
//   //     _cancelSelection();
//   //     return;
//   //   }
//   //
//   //   final deleted = await showCustomMessagingChannelMarkAsFavorite(_selectedUuids, value);
//   //   if (deleted) {
//   //     _cancelSelection();
//   //   }
//   // }
//   //
//   // _onButtonArchivedConversationsPressed() {
//   //   Navigator.of(context).pushNamed(ScreenMessageChannelArchivedList.routeName);
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     final appBarIconColor = Theme.of(context).appBarTheme.backgroundColor?.contrast(context);
//
//     return Container();
//     //
//     // return CustomScaffold(
//     //   onWillPop: _selecting ? () => _cancelSelection() : null,
//     //   appbar: CustomAppBar(
//     //     title: "Messages",
//     //     actionButtons: [],
//     //     leading: CustomIconButton(
//     //       icon: Icons.arrow_back_ios,
//     //       iconColor: appBarIconColor,
//     //       backgroundColor: Colors.transparent,
//     //       onPressed: _close,
//     //     ),
//     //     overlay: CustomAnimatedFadeVisibility(
//     //       visible: _selecting,
//     //       child: CustomAppBar(
//     //         leading: CustomIconButton(
//     //           icon: Icons.clear,
//     //           tooltip: "Close",
//     //           backgroundColor: Colors.transparent,
//     //           iconColor: appBarIconColor,
//     //           onPressed: _cancelSelection,
//     //         ),
//     //         statusBar: false,
//     //         title: _selectedUuids.length.toString(),
//     //         actionButtons: [
//     //           if (showButtonMarkAsFavorite)
//     //             CustomIconButton(
//     //               key: const ValueKey("mark-favorite"),
//     //               tooltip: "Mark as favorite",
//     //               icon: Icons.bookmark,
//     //               backgroundColor: Colors.transparent,
//     //               iconColor: appBarIconColor,
//     //               onPressed: _onButtonMarkAsFavoriteSelectionPressed,
//     //             ),
//     //           if (showButtonUnMarkAsFavorite)
//     //             CustomIconButton(
//     //               key: const ValueKey("unmark-favorite"),
//     //               tooltip: "UnMark as favorite",
//     //               icon: Icons.bookmark_border,
//     //               backgroundColor: Colors.transparent,
//     //               iconColor: appBarIconColor,
//     //               onPressed: _onButtonUnMarkAsFavoriteSelectionPressed,
//     //             ),
//     //           CustomIconButton(
//     //             key: const ValueKey("archive"),
//     //             tooltip: "Unarchive",
//     //             icon: Icons.archive_outlined,
//     //             backgroundColor: Colors.transparent,
//     //             iconColor: appBarIconColor,
//     //             onPressed: _onButtonUnArchiveSelectionPressed,
//     //           ),
//     //           CustomIconButton(
//     //             key: const ValueKey("delete"),
//     //             tooltip: "Delete",
//     //             icon: Icons.delete_outline,
//     //             backgroundColor: Colors.transparent,
//     //             iconColor: appBarIconColor,
//     //             onPressed: _onButtonDeleteSelectionPressed,
//     //           ),
//     //         ],
//     //       ),
//     //     ),
//     //   ),
//     //   body: Column(
//     //     children: [
//     //       CustomAnimatedCollapseVisibility(
//     //         visible: _isSearchVisible,
//     //         child: CustomTextField(
//     //           controller: _filterController,
//     //           margin: const EdgeInsets.all(16.0),
//     //           hintText: "Search",
//     //           prefix: const CustomTextFieldIconButton(icon: Icons.search),
//     //           textInputAction: TextInputAction.search,
//     //           suffixBuilder: (c, value) => CustomAnimatedFadeVisibility(
//     //             visible: value.isNotEmpty,
//     //             child: CustomTextFieldIconButton(
//     //               icon: Icons.clear,
//     //               onPressed: () {
//     //                 _filterController.text = "";
//     //                 CustomKeyboardUtils.hide();
//     //               },
//     //             ),
//     //           ),
//     //         ),
//     //       ),
//     //       Expanded(
//     //         child: CustomList<MessagingChannelModel>(
//     //           padding: const EdgeInsets.all(16.0).copyWith(bottom: 80),
//     //           loading: _loadingItems,
//     //           error: _error,
//     //           data: filteredItems,
//     //           isEmpty: (items) => items.where((e) => e.uuid != "archived").isEmpty,
//     //           emptyBuilder: (context) => CustomListIndicatorEmpty(
//     //             message: filtering ? "Try another filter" : "",
//     //           ),
//     //           itemBuilder: (context, item, index, isLastItem) => MessageMemberListItem(
//     //             key: ValueKey(item.uuid),
//     //             model: item,
//     //             separator: !isLastItem,
//     //             onPressed: _onPressed,
//     //             onLongPressed: _onLongPressed,
//     //             selected: _selectedUuids.contains(item.uuid),
//     //           ),
//     //         ),
//     //       ),
//     //     ],
//     //   ),
//     // );
//   }
// }
