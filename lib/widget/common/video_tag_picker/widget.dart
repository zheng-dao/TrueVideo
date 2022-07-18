import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/hook/video_tags.dart';
import 'package:truvideo_enterprise/model/video_tag_model.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/fading_edge_list/index.dart';
import 'package:truvideo_enterprise/widget/common/list/list.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';

class ScreenVideoTagPicker extends StatefulHookConsumerWidget {
  const ScreenVideoTagPicker({Key? key}) : super(key: key);

  @override
  VideoTagState createState() => VideoTagState();
}

class VideoTagState extends ConsumerState<ScreenVideoTagPicker> {
  _close({dynamic result}) async {
    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    final appBarColor = Theme.of(context).scaffoldBackgroundColor;
    final appBarIconColor = appBarColor.contrast(context);
    final data = useVideoTags(ref);

    return CustomScaffold(
      appbar: CustomAppBar(
        backgroundColor: appBarColor,
        title: "Select Video Tag",
        titleColor: appBarIconColor,
        actionButtons: [
          CustomButtonIcon(
            icon: Icons.clear,
            backgroundColor: Colors.transparent,
            iconColor: appBarIconColor,
            onPressed: _close,
          ),
        ],
      ),
      body: CustomFadingEdgeList(
        child: CustomList<VideoTagModel>.separated(
          padding: EdgeInsets.only(
            bottom: 16.0 + MediaQuery.of(context).padding.bottom,
            top: 16.0,
          ),
          data: data,
          loading: false,
          areItemsTheSame: (a, b) => a.key == b.key,
          itemBuilder: (_, item) => CustomListTile(
            titleText: item.displayName,
            onPressed: () => _close(result: item),
          ),
        ),
      ),
    );
  }
}
