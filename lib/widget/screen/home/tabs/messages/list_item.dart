// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:truvideo_enterprise/model/message_member.dart';
// import 'package:truvideo_enterprise/service/date/_interface.dart';
// import 'package:truvideo_enterprise/widget/common/list_tile/image.dart';
// import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';
//
// class MessageMemberListItem extends StatelessWidget {
//   final MessageMemberModel model;
//   final bool selected;
//   final Function(MessageMemberModel model)? onPressed;
//   final Function(MessageMemberModel model)? onLongPressed;
//
//   const MessageMemberListItem({
//     Key? key,
//     required this.model,
//     this.selected = false,
//     this.onPressed,
//     this.onLongPressed,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final DateService dateService = GetIt.I.get();
//
//     return CustomListTile(
//       onPressed: onPressed == null ? null : () => onPressed!(model),
//       onLongPressed: onLongPressed == null ? null : () => onLongPressed!(model),
//       selected: selected,
//       leading: const CustomListTileImage(
//         icon: Icons.person_outline,
//       ),
//       titleText: model.displayName,
//       subtitleText: model.lastMessage?.body ?? "",
//       trailing: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           if (model.lastMessage?.createdAt != null) Text(dateService.timeAgo(model.lastMessage!.createdAt!)),
//           if (model.pinned)
//             Container(
//               margin: const EdgeInsets.only(top: 4.0),
//               child: Icon(
//                 Icons.bookmark,
//                 size: 12,
//                 color: Theme.of(context).colorScheme.secondary,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
