// import 'dart:async';
// import 'dart:developer';
//
// import 'package:easy_debounce/easy_debounce.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:get_it/get_it.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:truvideo_enterprise/core/colors.dart';
// import 'package:truvideo_enterprise/core/keyboard.dart';
// import 'package:truvideo_enterprise/main.dart';
// import 'package:truvideo_enterprise/model/message_member.dart';
// import 'package:truvideo_enterprise/riverpod/connectivity.dart';
// import 'package:truvideo_enterprise/riverpod/messaging_authentication_information.dart';
// import 'package:truvideo_enterprise/riverpod/voip_call_status.dart';
// import 'package:truvideo_enterprise/service/messaging/_interface.dart';
// import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
// import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
// import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
// import 'package:truvideo_enterprise/widget/common/app_bar_logged_user.dart';
// import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
// import 'package:truvideo_enterprise/widget/common/button_gradient/index.dart';
// import 'package:truvideo_enterprise/widget/common/dialog/index.dart';
// import 'package:truvideo_enterprise/widget/common/fading_edge_list/index.dart';
// import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
// import 'package:truvideo_enterprise/widget/common/list/indicator_error.dart';
// import 'package:truvideo_enterprise/widget/common/list/list.dart';
// import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';
// import 'package:truvideo_enterprise/widget/common/navigation_bar/index.dart';
// import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
// import 'package:truvideo_enterprise/widget/common/text_field/icon.dart';
// import 'package:truvideo_enterprise/widget/common/text_field/index.dart';
// import 'package:truvideo_enterprise/widget/dialog/user/profile_2/index.dart';
// import 'package:truvideo_enterprise/widget/mixin/back_button_exit.dart';
// import 'package:truvideo_enterprise/widget/screen/message_list/index.dart';
//
// import 'list_item.dart';
// import 'shimmer_list.dart';
//
// class ScreenMessageMemberList extends StatefulHookConsumerWidget {
//   static const String routeName = "/ScreenMessageMemberList";
//
//   const ScreenMessageMemberList({Key? key}) : super(key: key);
//
//   @override
//   _ScreenMessageMemberListState createState() => _ScreenMessageMemberListState();
// }
//
// class _ScreenMessageMemberListState extends ConsumerState<ScreenMessageMemberList> with BackButtonExitMixin {
//   var _selectedUuids = <String>[];
//   bool _selecting = false;
//   final _filterController = TextEditingController();
//
//   bool _canLoadMore = true;
//   bool _loading = true;
//   bool _filtering = false;
//   var _items = <MessageMemberModel>[];
//   dynamic _error;
//   int _page = 0;
//   final int _pageLength = 10;
//   bool _isInit = false;
//
//   Timer? _timerPolling;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _filterController.addListener(() {});
//     WidgetsBinding.instance?.addPostFrameCallback((timeStamp) => _init());
//   }
//
//   @override
//   void dispose() {
//     _timerPolling?.cancel();
//     EasyDebounce.cancel("search");
//     super.dispose();
//   }
//
//   _init() async {
//     final MessagingService service = GetIt.I.get();
//     final cached = await service.getCachedMembers();
//     if (cached.isNotEmpty) {
//       setState(() {
//         _loading = false;
//         _canLoadMore = false;
//         _error = null;
//         _items = cached;
//       });
//     }
//
//     setState(() => _isInit = true);
//     _refresh(loading: cached.isEmpty);
//
//     _timerPolling = Timer.periodic(const Duration(seconds: 10), (timer) {
//       log("Refresh member list");
//       _refresh(loading: false);
//     });
//   }
//
//   _refresh({bool loading = true}) {
//     _filterController.text = "";
//     setState(() => _page = 0);
//     _fetch(loading: loading);
//   }
//
//   _fetch({bool loading = true}) async {
//     EasyDebounce.cancel("search");
//
//     final connected = ref.read(connectivityPod);
//     if (!connected) {
//       setState(() {
//         _loading = false;
//         _error = null;
//       });
//       return;
//     }
//
//     try {
//       setState(() {
//         _loading = loading;
//         _error = null;
//       });
//
//       final messagingAuth = ref.read(messagingAuthenticationInformationPod);
//       final MessagingService service = GetIt.I.get();
//       final newItems = await service.getMembersPaginated(
//         accountUID: messagingAuth?.accountUID ?? "",
//         pageLength: _pageLength,
//         page: _page,
//       );
//       if (!mounted) return;
//
//       if (_page == 0) {
//         _items = [];
//       }
//
//       bool thereIsNewItems = false;
//       for (var element in newItems) {
//         if (!_items.any((e) => e.uid == element.uid)) {
//           thereIsNewItems = true;
//         }
//       }
//
//       final items = _appendList(_items, newItems);
//
//       setState(() {
//         _page = _page + 1;
//         _loading = false;
//         _filtering = false;
//         _items = items;
//         _canLoadMore = thereIsNewItems && newItems.length == _pageLength;
//       });
//     } catch (error) {
//       if (!mounted) return;
//
//       setState(() {
//         _loading = false;
//         _filtering = false;
//         _error = error;
//       });
//     }
//   }
//
//   _appendList(List<MessageMemberModel> oldData, List<MessageMemberModel> newData) {
//     var result = List<MessageMemberModel>.from(oldData);
//     result = result.map((item) {
//       final i = newData.where((newItem) => newItem.uid == item.uid).toList();
//       if (i.isEmpty) return item;
//       return i[0];
//     }).toList();
//
//     for (var element in newData) {
//       if (result.any((e) => e.uid == element.uid)) continue;
//       result.add(element);
//     }
//
//     return result;
//   }
//
//   Future<bool> _onWillPop() async {
//     if (_selecting) {
//       _cancelSelection();
//       return false;
//     }
//
//     return onButtonBackPressed();
//   }
//
//   _onButtonCreatePressed() {}
//
//   _cancelSelection() {
//     _selectedUuids = [];
//     _selecting = false;
//     setState(() {});
//   }
//
//   _onItemPressed(MessageMemberModel model) async {
//     if (_selecting) {
//       if (_selectedUuids.any((e) => e == model.uid)) {
//         _selectedUuids = _selectedUuids.where((e) => e != model.uid).toList();
//       } else {
//         _selectedUuids = [..._selectedUuids, model.uid];
//       }
//       _selecting = _selectedUuids.isNotEmpty;
//       setState(() {});
//       return;
//     }
//
//     await Navigator.of(context).pushNamed(
//       ScreenMessageList.routeName,
//       arguments: ScreenMessageListParams(
//         memberUID: model.uid,
//         channelUID: model.channelUid,
//         initialTitle: model.displayName,
//       ),
//     );
//     if (!mounted) return;
//     setState(() => _page = 0);
//     _fetch(loading: false);
//   }
//
//   _onItemLongPressed(MessageMemberModel model) {
//     if (_selectedUuids.any((e) => e == model.uid)) {
//       _selectedUuids = _selectedUuids.where((e) => e != model.uid).toList();
//     } else {
//       _selectedUuids = [..._selectedUuids, model.uid];
//     }
//     _selecting = _selectedUuids.isNotEmpty;
//     setState(() {});
//   }
//
//   _onButtonDeleteSelectionPressed() async {
//     if (_selectedUuids.isEmpty) {
//       _cancelSelection();
//       return;
//     }
//
//     await showCustomDialogRetry(
//       title: "Work in progress",
//       cancelButtonVisible: false,
//       retryButtonText: "Accept",
//     );
//
//     _cancelSelection();
//
//     // final deleted = await showCustomMessagingChannelDelete(_selectedUuids);
//     // if (deleted) {
//     //   _cancelSelection();
//     // }
//   }
//
//   _onButtonArchiveSelectionPressed() async {
//     if (_selectedUuids.isEmpty) {
//       _cancelSelection();
//       return;
//     }
//
//     await showCustomDialogRetry(
//       title: "Work in progress",
//       cancelButtonVisible: false,
//       retryButtonText: "Accept",
//     );
//
//     _cancelSelection();
//
//     // final deleted = await showCustomMessagingChannelMarkAsArchived(_selectedUuids, true);
//     // if (deleted) {
//     //   _cancelSelection();
//     // }
//   }
//
//   _onButtonMarkAsFavoriteSelectionPressed() {
//     _processFavoriteSelection(true);
//   }
//
//   _onButtonUnMarkAsFavoriteSelectionPressed() {
//     _processFavoriteSelection(false);
//   }
//
//   _processFavoriteSelection(bool value) async {
//     if (_selectedUuids.isEmpty) {
//       _cancelSelection();
//       return;
//     }
//
//     await showCustomDialogRetry(
//       title: "Work in progress",
//       cancelButtonVisible: false,
//       retryButtonText: "Accept",
//     );
//
//     _cancelSelection();
//
//     // final deleted = await showCustomMessagingChannelMarkAsFavorite(_selectedUuids, value);
//     // if (deleted) {
//     //   _cancelSelection();
//     // }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final callStatus = ref.watch(voipCallStatusPod);
//     final appBarIconColor = Theme.of(context).appBarTheme.backgroundColor?.contrast(context);
//     final filter = useValueListenable(_filterController);
//     final showButtonPin = useMemoized(
//       () {
//         if (!_selecting) return false;
//
//         final selected = _items.where((e) => _selectedUuids.contains(e.uid)).toList();
//         return !selected.any((e) => e.pinned);
//       },
//       [_items, _selectedUuids, _selecting],
//     );
//
//     final showButtonUnpin = useMemoized(
//       () {
//         if (!_selecting) return false;
//         final selected = _items.where((e) => _selectedUuids.contains(e.uid)).toList();
//         return !selected.any((e) => !e.pinned);
//       },
//       [_items, _selectedUuids, _selecting],
//     );
//
//     final searchVisible = !_selecting;
//     const renderSearchBar = false;
//     // final fabVisible = !_selecting && !_firstPageError && !_loadingFirstPage && !_noItemsFound;
//     const fabVisible = false;
//
//     return CustomScaffold(
//       onWillPop: _onWillPop,
//       appbar: CustomAppBar(
//         title: "Messages",
//         actionButtons: const [
//           CustomAppBarLoggedUser(
//             onPressed: showCustomDialogUserProfile,
//           ),
//         ],
//         overlay: CustomAnimatedFadeVisibility(
//           visible: _selecting,
//           child: CustomAppBar(
//             leading: CustomButtonIcon(
//               icon: Icons.clear,
//               tooltip: "Close",
//               backgroundColor: Colors.transparent,
//               iconColor: appBarIconColor,
//               onPressed: _cancelSelection,
//             ),
//             statusBar: false,
//             title: _selectedUuids.length.toString(),
//             actionButtons: [
//               if (showButtonPin)
//                 CustomButtonIcon(
//                   key: const ValueKey("pin"),
//                   tooltip: "Pin",
//                   icon: Icons.bookmark,
//                   backgroundColor: Colors.transparent,
//                   iconColor: appBarIconColor,
//                   onPressed: _onButtonMarkAsFavoriteSelectionPressed,
//                 ),
//               if (showButtonUnpin)
//                 CustomButtonIcon(
//                   key: const ValueKey("unpin"),
//                   tooltip: "Unpin",
//                   icon: Icons.bookmark_border,
//                   backgroundColor: Colors.transparent,
//                   iconColor: appBarIconColor,
//                   onPressed: _onButtonUnMarkAsFavoriteSelectionPressed,
//                 ),
//               CustomButtonIcon(
//                 key: const ValueKey("archive"),
//                 tooltip: "Archive",
//                 icon: Icons.archive_outlined,
//                 backgroundColor: Colors.transparent,
//                 iconColor: appBarIconColor,
//                 onPressed: _onButtonArchiveSelectionPressed,
//               ),
//               CustomButtonIcon(
//                 key: const ValueKey("delete"),
//                 tooltip: "Delete",
//                 icon: Icons.delete_outline,
//                 backgroundColor: Colors.transparent,
//                 iconColor: appBarIconColor,
//                 onPressed: _onButtonDeleteSelectionPressed,
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           CustomAnimatedCollapseVisibility(
//             visible: callStatus == VoipCallStatus.error,
//             child: CustomListTile(
//               titleText: "Error setting up the Voip Calls",
//               dense: true,
//               color: Colors.orange,
//               trailing: CustomBorderButton.small(
//                 text: "Retry",
//                 textColor: Colors.white,
//                 borderColor: Colors.white,
//                 highlightColor: Colors.white.withOpacity(0.2),
//                 splashColor: Colors.white.withOpacity(0.2),
//                 onPressed: () => appKey.currentState?.registerVoipCalls(),
//               ),
//             ),
//           ),
//           Expanded(
//             child: RefreshIndicator(
//               onRefresh: () async => _refresh(),
//               child: CustomFadingEdgeList(
//                 child: CustomList<MessageMemberModel>.separated(
//                   areItemsTheSame: (a, b) => a.uid == b.uid,
//                   headerVisibility: (status) {
//                     switch (status) {
//                       case CustomListStatus.loading:
//                         return _page != 0;
//                       case CustomListStatus.error:
//                         return false;
//                       case CustomListStatus.empty:
//                         return filter.text.trim().isNotEmpty;
//                       case CustomListStatus.data:
//                         return true;
//                     }
//                   },
//                   loading: _loading && _page == 0 && !_filtering,
//                   error: _page == 0 ? _error : null,
//                   data: _items,
//                   showLoadMore: _canLoadMore,
//                   loadMore: _fetch,
//                   loadingMoreError: _page != 0 ? _error : null,
//                   padding: const EdgeInsets.only(
//                     // bottom: _selecting ? 16.0 : 80.0,
//                     bottom: 16.0,
//                     // top: renderSearchBar ? 0.0 : 16.0,
//                   ),
//                   itemBuilder: (context, item) => MessageMemberListItem(
//                     key: ValueKey(item.uid),
//                     model: item,
//                     onPressed: _onItemPressed,
//                     onLongPressed: _onItemLongPressed,
//                     selected: _selectedUuids.contains(item.uid),
//                   ),
//                   loadingBuilder: (c) => _isInit ? const ScreenMessageMemberListShimmerList() : Container(),
//                   errorBuilder: (c, error) => CustomListIndicatorError(onButtonPressed: _refresh),
//                   header: renderSearchBar
//                       ? Column(
//                           children: [
//                             CustomAnimatedCollapseVisibility(
//                               visible: searchVisible,
//                               child: CustomTextField(
//                                 controller: _filterController,
//                                 margin: const EdgeInsets.all(16.0),
//                                 hintText: "Search",
//                                 prefix: const CustomTextFieldIconButton(icon: Icons.search),
//                                 textInputAction: TextInputAction.search,
//                                 suffixBuilder: (c, value) => Stack(
//                                   alignment: Alignment.center,
//                                   children: [
//                                     // Loading
//                                     CustomAnimatedFadeVisibility(
//                                       visible: _filtering,
//                                       child: const SizedBox(
//                                         width: 15,
//                                         height: 15,
//                                         child: CircularProgressIndicator(strokeWidth: 2),
//                                       ),
//                                     ),
//                                     // Clear
//                                     CustomAnimatedFadeVisibility(
//                                       visible: !_filtering && value.isNotEmpty,
//                                       child: CustomTextFieldIconButton(
//                                         icon: Icons.clear,
//                                         onPressed: () {
//                                           _filterController.text = "";
//                                           CustomKeyboardUtils.hide();
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 onChanged: (val) => EasyDebounce.debounce(
//                                   "search",
//                                   const Duration(milliseconds: 300),
//                                   () {
//                                     setState(() {
//                                       _filtering = true;
//                                       _page = 0;
//                                     });
//                                     _fetch();
//                                   },
//                                 ),
//                               ),
//                             ),
//                             AnimatedContainer(
//                               duration: const Duration(milliseconds: 300),
//                               height: _selecting ? 16.0 : 0.0,
//                             ),
//                           ],
//                         )
//                       : null,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: CustomAnimatedFadeVisibility(
//         visible: fabVisible,
//         child: CustomGradientButton(
//           borderRadius: 100,
//           elevation: 8,
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           gradient: CustomColorsUtils.gradient,
//           text: "CREATE",
//           onPressed: _onButtonCreatePressed,
//           icon: Icons.add,
//         ),
//       ),
//       // navigationBar: const CustomNavigationBar(value: 1),
//     );
//   }
// }
