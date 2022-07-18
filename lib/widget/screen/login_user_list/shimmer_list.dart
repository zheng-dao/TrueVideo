import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/widget/common/list/shimmer_list.dart';
import 'package:truvideo_enterprise/widget/common/list/shimmer_search_bar.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/image.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';

class ScreenLoginUserListShimmerList extends StatelessWidget {
  const ScreenLoginUserListShimmerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomShimmerSearchBar(),
        Expanded(
          child: CustomShimmerList(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            length: 10,
            separatorBuilder: (c) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: const Divider(
                height: 1,
              ),
            ),
            itemBuilder: (context, index) => CustomListTile(
              leading: const CustomListTileImage(
                color: Colors.white,
              ),
              title: Row(
                children: [
                  Container(
                    width: 250,
                    color: Colors.white,
                    child: const Text("Title"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
