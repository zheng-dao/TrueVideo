// import 'package:flutter/material.dart';
// import 'package:truvideo_enterprise/widget/common/list/shimmer_list.dart';
// import 'package:truvideo_enterprise/widget/common/list_tile/image.dart';
// import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';
//
//
// class ScreenMessageMemberListShimmerList extends StatelessWidget {
//   const ScreenMessageMemberListShimmerList({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // const CustomShimmerSearchBar(),
//         Expanded(
//           child: CustomShimmerList(
//             padding: const EdgeInsets.symmetric(vertical: 16.0),
//             length: 10,
//             itemBuilder: (context, index) => CustomListTile(
//               leading: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: const [CustomListTileImage(color: Colors.white)],
//               ),
//               title: Row(
//                 children: [
//                   Container(
//                     width: 100,
//                     color: Colors.white,
//                     child: const Text("  "),
//                   ),
//                 ],
//               ),
//               subtitle: Container(
//                 margin: const EdgeInsets.only(top: 4.0),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 120,
//                       color: Colors.white,
//                       child: const Text("  "),
//                     ),
//                   ],
//                 ),
//               ),
//               trailing: Container(
//                 width: 90,
//                 color: Colors.white,
//                 child: const Text("  "),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
