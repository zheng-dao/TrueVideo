import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_ro_video_upload.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_status.dart';
import 'package:truvideo_enterprise/model/ro/upload_video_request.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/_interface.dart';
import 'package:truvideo_enterprise/service/repair_order/_interface.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/button_gradient/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';
import 'package:truvideo_enterprise/widget/screen/repair_order/status_text.dart';

class RepairOrderVideoUploadRequestStatus extends StatefulHookConsumerWidget {
  final String uid;
  final bool showStatus;

  const RepairOrderVideoUploadRequestStatus({
    Key? key,
    required this.uid,
    this.showStatus = false,
  }) : super(key: key);

  @override
  ConsumerState<RepairOrderVideoUploadRequestStatus> createState() => _RepairOrderVideoUploadRequestStatusState();
}

class _RepairOrderVideoUploadRequestStatusState extends ConsumerState<RepairOrderVideoUploadRequestStatus> {
  bool _enabled = true;

  _onButtonStatusPressed(OfflineEnqueueItemModel? model) {
    if (model == null) {
      _startUpload();
      return;
    }

    switch (model.status) {
      case OfflineEnqueueItemStatus.pending:
        break;
      case OfflineEnqueueItemStatus.processing:
        break;
      case OfflineEnqueueItemStatus.done:
        break;
      case OfflineEnqueueItemStatus.error:
        _askRetryUpload();
        break;
    }
  }

  _startUpload() async {
    try {
      setState(() => _enabled = false);

      RepairOrderService repairOrderService = GetIt.I.get();
      await repairOrderService.startVideoUploadRequest(widget.uid);
      if (!mounted) return;

      setState(() => _enabled = true);
    } catch (error, stack) {
      log("Error starting video upload", error: error, stackTrace: stack);
      if (!mounted) return;
      setState(() => _enabled = true);

      bool retry;
      if (error is CustomException) {
        retry = await showCustomDialogRetry(message: "${error.message}");
      } else {
        retry = await showCustomDialogRetry();
      }
      if (retry) {
        _startUpload();
      }
    }
  }

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
      setState(() => _enabled = false);

      RepairOrderService repairOrderService = GetIt.I.get();
      await repairOrderService.retryVideoUploadRequest(widget.uid);
      if (!mounted) return;

      setState(() => _enabled = true);
    } catch (error, stack) {
      log("Error retry upload", error: error, stackTrace: stack);
      if (!mounted) return;
      setState(() => _enabled = true);

      bool retry;
      if (error is CustomException) {
        retry = await showCustomDialogRetry(message: "${error.message}");
      } else {
        retry = await showCustomDialogRetry();
      }
      if (retry) {
        _retryUpload();
      }
    }
  }

  Widget _buildChild(
    BuildContext context, {
    required OfflineEnqueueItemModel? offlineEnqueue,
    required RepairOrderUploadVideoRequestModel? request,
    required OfflineEnqueueItemRepairOrderVideoUploadModel? offlineData,
    bool loading = false,
  }) {
    if (loading) {
      return Container(key: const ValueKey("loading"));
    }

    if (offlineEnqueue == null) {
      return CustomGradientButton.small(
        key: const ValueKey("upload"),
        gradient: CustomColorsUtils.gradient,
        text: "Upload",
        icon: Icons.cloud_upload,
        onPressed: () => _onButtonStatusPressed(offlineEnqueue),
      );
    }

    switch (offlineEnqueue.status) {
      case OfflineEnqueueItemStatus.pending:
        {
          return const CustomBorderButton.small(
            key: ValueKey("pending"),
            text: "Pending",
          );
        }

      case OfflineEnqueueItemStatus.processing:
        {
          if (widget.showStatus) {
            return UploadStatusText(
              request: request,
              offlineItem: offlineEnqueue,
              offlineData: offlineData,
            );
          }

          return CustomBorderButton.small(
            key: const ValueKey("uploading"),
            text: "Uploading",
            iconWidget: Container(
              margin: const EdgeInsets.only(right: 4.0, left: 4.0),
              width: 10,
              height: 10,
              child: const CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        }

      case OfflineEnqueueItemStatus.done:
        {
          return const CustomBorderButton.small(
            key: ValueKey("uploaded"),
            text: "Uploaded",
            borderColor: Colors.transparent,
            icon: Icons.check,
            iconColor: Colors.white,
            textColor: Colors.white,
            fillColor: Colors.green,
          );
        }

      case OfflineEnqueueItemStatus.error:
        {
          return CustomBorderButton.small(
            key: const ValueKey("error"),
            text: "Error",
            borderColor: Colors.transparent,
            icon: MdiIcons.exclamationThick,
            iconColor: Colors.white,
            textColor: Colors.white,
            fillColor: CustomColorsUtils.delete,
            onPressed: () => _onButtonStatusPressed(offlineEnqueue),
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final RepairOrderService service = GetIt.I.get();
    final OfflineEnqueueService offlineEnqueueService = GetIt.I.get();
    final snapshotModel = useStream(useMemoized(() => service.streamVideoUploadRequestByUID(widget.uid), [widget.uid]));
    final model = snapshotModel.data;

    final snapshotOfflineEnqueue = useStream(
      useMemoized(
        () => offlineEnqueueService.streamByUID(model?.offlineEnqueueUID ?? ""),
        [model?.offlineEnqueueUID],
      ),
    );
    final offlineItem = snapshotOfflineEnqueue.data;
    final offlineData = useMemoized(
      () {
        if (offlineItem == null || offlineItem.data == null) return null;
        try {
          return OfflineEnqueueItemRepairOrderVideoUploadModel.fromJson(offlineItem.data!);
        } catch (error) {
          log("Error parsing OfflineEnqueueItemRepairOrderVideoUploadModel", error: error);
          return null;
        }
      },
      [offlineItem],
    );
    final offlineEnqueue = snapshotOfflineEnqueue.data;

    final loading = snapshotModel.connectionState == ConnectionState.waiting || snapshotOfflineEnqueue.connectionState == ConnectionState.waiting;

    return CustomAnimatedFadeVisibility(
      visible: _enabled,
      minOpacity: 0.5,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        layoutBuilder: (current, prev) => Stack(
          alignment: Alignment.centerRight,
          children: [...prev, if (current != null) current],
        ),
        child: _buildChild(
          context,
          offlineEnqueue: offlineEnqueue,
          request: model,
          offlineData: offlineData,
          loading: loading,
        ),
      ),
    );
  }
}
