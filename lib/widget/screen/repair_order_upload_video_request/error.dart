import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_status.dart';
import 'package:truvideo_enterprise/model/ro/upload_video_request.dart';
import 'package:truvideo_enterprise/service/repair_order/_interface.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';

class ScreenRepairOrderUploadVideoRequestError extends StatefulWidget {
  final RepairOrderUploadVideoRequestModel request;
  final OfflineEnqueueItemModel? offlineItem;
  final EdgeInsets? margin;

  const ScreenRepairOrderUploadVideoRequestError({
    Key? key,
    required this.request,
    this.offlineItem,
    this.margin,
  }) : super(key: key);

  @override
  State<ScreenRepairOrderUploadVideoRequestError> createState() => _ScreenRepairOrderUploadVideoRequestErrorState();
}

class _ScreenRepairOrderUploadVideoRequestErrorState extends State<ScreenRepairOrderUploadVideoRequestError> {
  _askRetryUpload() async {
    final retry = await showCustomDialogRetry(
      title: "Retry upload",
      message: "Are you sure?",
      retryButtonText: "Yes",
      cancelButtonText: "Cancel",
    );
    if (!mounted) return;
    if (!retry) return;

    _retryUpload();
  }

  _retryUpload() async {
    try {
      RepairOrderService repairOrderService = GetIt.I.get();
      await repairOrderService.retryVideoUploadRequest(widget.request.uid);
    } catch (error, stack) {
      log("Error retry upload", error: error, stackTrace: stack);
      if (!mounted) return;
      final retry = await showCustomDialogRetry(error: error);
      if (retry) {
        _retryUpload();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final visible = widget.request.offlineEnqueueStatus == OfflineEnqueueItemStatus.error;
    String errorMessage = "";
    if ((widget.offlineItem?.errorMessage.trim() ?? "").isNotEmpty) {
      errorMessage = widget.offlineItem?.errorMessage.trim() ?? "";
    }

    return CustomAnimatedCollapseVisibility(
      visible: visible,
      child: Container(
        margin: widget.margin,
        padding: const EdgeInsets.all(32.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).dividerColor,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                MdiIcons.exclamationThick,
                color: CustomColorsUtils.delete,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              "Error uploading the video",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            CustomAnimatedCollapseVisibility(
              visible: errorMessage.trim().isNotEmpty,
              child: Text(errorMessage),
            ),
            CustomBorderButton.small(
              margin: const EdgeInsets.only(top: 16),
              text: "Retry",
              fillColor: Colors.white,
              borderColor: Colors.white,
              onPressed: _askRetryUpload,
            ),
          ],
        ),
      ),
    );
  }
}
