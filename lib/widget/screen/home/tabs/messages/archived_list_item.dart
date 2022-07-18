// import 'package:flutter/material.dart';
// import 'package:truvideo_enterprise/widget/common/list_tile/image.dart';
//
// class MessagingArchivedListItem extends StatelessWidget {
//   final int count;
//   final Function()? onPressed;
//   final bool separator;
//
//   const MessagingArchivedListItem({Key? key, required this.count, this.onPressed, this.separator = false}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             color: Theme.of(context).dividerColor,
//             borderRadius: BorderRadius.circular(4.0),
//           ),
//           clipBehavior: Clip.hardEdge,
//           child: ListTile(
//             onTap: onPressed,
//             title: const Text(
//               "Archived conversations",
//             ),
//             leading: const CustomListTileImage(
//               icon: Icons.archive_outlined,
//             ),
//             trailing: Text(
//               count.toString(),
//             ),
//           ),
//         ),
//         if (separator) const Divider(height: 1),
//       ],
//     );
//   }
// }
