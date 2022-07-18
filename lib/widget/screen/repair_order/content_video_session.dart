import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/core/video.dart';
import 'package:truvideo_enterprise/model/camera/video_session.dart';
import 'package:truvideo_enterprise/model/repair_order_detail.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/service/date/_interface.dart';
import 'package:truvideo_enterprise/service/video_session/_interface.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';
import 'package:truvideo_enterprise/widget/common/list/divider.dart';

class ScreenRepairOrderDetailVideoSession extends StatefulHookConsumerWidget {
  final RepairOrderDetailModel model;
  final Function(VideoSessionModel model)? onResumePressed;

  const ScreenRepairOrderDetailVideoSession({
    Key? key,
    required this.model,
    this.onResumePressed,
  }) : super(key: key);

  @override
  ConsumerState<ScreenRepairOrderDetailVideoSession> createState() => _ScreenRepairOrderDetailVideoSessionState();
}

class _ScreenRepairOrderDetailVideoSessionState extends ConsumerState<ScreenRepairOrderDetailVideoSession> {
  _askDelete(VideoSessionModel model) async {
    final delete = await showCustomDialogRetry(
      title: "Discard video",
      message: "Are you sure?",
      cancelButtonText: "No",
      retryButtonText: "Yes",
    );

    if (!delete) return;

    final VideoSessionService videoSessionService = GetIt.I.get();
    videoSessionService.deleteByUID(model.uid);
  }

  Future<Duration> _calculateVideoDuration(VideoSessionModel model) async {
    Duration duration = Duration.zero;
    for (var element in model.videos) {
      try {
        final info = await CustomVideoUtils.getInfo(element.path);
        duration += Duration(milliseconds: info.durationMillis);
      } catch (error) {
        log("Error getting video duration");
      }
    }

    return duration;
  }

  @override
  Widget build(BuildContext context) {
    final AuthService authService = GetIt.I.get();
    final DateService dateService = GetIt.I.get();
    final VideoSessionService videoSessionService = GetIt.I.get();
    final snapshot = useStream(
      useMemoized(
        () => videoSessionService.streamByTag(widget.model.id.toString()),
        [authService.sub ?? "", widget.model.id],
      ),
    );

    final video = snapshot.data;

    final videoDurationSnapshot = useFuture(
      useMemoized(
        () {
          if (video == null) return Future.value(Duration.zero);
          return _calculateVideoDuration(video);
        },
        [video],
      ),
    );

    String videoDuration = "No video";
    if (video != null && video.videos.isNotEmpty) {
      videoDuration = dateService.duration(videoDurationSnapshot.data ?? Duration.zero, forceHour: false);
    }

    String picturesCount = "No pictures";
    if (video != null) {
      if (video.pictures.isNotEmpty) {
        if (video.pictures.length == 1) {
          picturesCount = "1 picture";
        } else {
          picturesCount = "${video.pictures.length} pictures";
        }
      }
    }

    return CustomAnimatedCollapseVisibility(
      visible: video != null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 16.0, right: 16, top: 16, bottom: 16),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.yellow.shade100,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Video in progress",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8.0),
                Text(videoDuration),
                Text(picturesCount),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Spacer(),
                    CustomBorderButton.small(
                      text: "Delete",
                      borderColor: Colors.red,
                      textColor: Colors.red,
                      icon: Icons.delete_outline,
                      onPressed: () => _askDelete(video!),
                    ),
                    const SizedBox(width: 8.0),
                    CustomBorderButton.small(
                      text: "Resume",
                      fillColor: Colors.white,
                      borderColor: Colors.black.withOpacity(0.8),
                      onPressed: () => widget.onResumePressed?.call(video!),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const CustomDivider(),
        ],
      ),
    );
  }
}
