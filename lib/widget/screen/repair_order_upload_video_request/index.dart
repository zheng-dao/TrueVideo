import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/core/router/router.dart';
import 'package:truvideo_enterprise/hook/is_debug.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_ro_video_upload.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_status.dart';
import 'package:truvideo_enterprise/model/ro/upload_video_request.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/_interface.dart';
import 'package:truvideo_enterprise/service/repair_order/_interface.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';
import 'package:truvideo_enterprise/widget/common/fading_edge_list/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/json_viewer/index.dart';
import 'package:truvideo_enterprise/widget/common/list/divider.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';

import 'header.dart';
import 'pictures.dart';
import 'video_preview.dart';

class ScreenRepairOrderVideoUploadRequestParams {
  final String videoRequestUID;
  CustomRouteType? routeType;

  ScreenRepairOrderVideoUploadRequestParams({required this.videoRequestUID, this.routeType});
}

class ScreenRepairOrderVideoUploadRequest extends StatefulHookConsumerWidget {
  static const String routeName = "/ScreenRepairOrderDetailVideo";

  final ScreenRepairOrderVideoUploadRequestParams params;

  const ScreenRepairOrderVideoUploadRequest({
    Key? key,
    required this.params,
  }) : super(key: key);

  @override
  ConsumerState<ScreenRepairOrderVideoUploadRequest> createState() => _ScreenRepairOrderVideoUploadRequestState();
}

class _ScreenRepairOrderVideoUploadRequestState extends ConsumerState<ScreenRepairOrderVideoUploadRequest> {
  _askDeleteUpload() async {
    final delete = await showCustomDialogRetry(
      title: "Delete video upload",
      message: "Are you sure?",
      retryButtonText: "Yes",
      cancelButtonText: "Cancel",
    );
    if (!mounted) return;
    if (!delete) return;

    _deleteUpload();
  }

  _deleteUpload() async {
    try {
      final RepairOrderService service = GetIt.I.get();
      await service.deleteVideoUploadRequest(widget.params.videoRequestUID);
      if (!mounted) return;

      Navigator.of(context).pop();
    } catch (error, stack) {
      log("Error delete upload", error: error, stackTrace: stack);
      if (!mounted) return;

      bool retry;
      if (error is CustomException) {
        retry = await showCustomDialogRetry(message: "${error.message}");
      } else {
        retry = await showCustomDialogRetry();
      }
      if (retry) {
        _deleteUpload();
      }
    }
  }

  _close() {
    Navigator.of(context).pop();
  }

  Widget _buildChild({
    OfflineEnqueueItemModel? offlineItem,
    OfflineEnqueueItemRepairOrderVideoUploadModel? offlineData,
    RepairOrderUploadVideoRequestModel? request,
  }) {
    Widget child;
    if (request == null) {
      child = const SizedBox(
        key: ValueKey("loading"),
        height: double.infinity,
        width: double.infinity,
      );
    } else {
      final validStatusToEdit = [
        OfflineEnqueueItemStatus.pending,
        OfflineEnqueueItemStatus.error,
      ];

      final canEdit = request.offlineEnqueueStatus == null || validStatusToEdit.contains(request.offlineEnqueueStatus);

      child = SizedBox(
        key: const ValueKey("content"),
        width: double.infinity,
        height: double.infinity,
        child: CustomFadingEdgeList(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16.0).copyWith(bottom: 16.0 + MediaQuery.of(context).viewPadding.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                ScreenRepairOrderUploadVideoRequestHeader(
                  margin: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 32,
                  ),
                  canEdit: canEdit,
                  request: request,
                  offlineData: offlineData,
                  offlineItem: offlineItem,
                ),

                // Video preview
                ScreenRepairOrderVideoUploadRequestVideoPreview(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  request: request,
                  offlineData: offlineData,
                  offlineItem: offlineItem,
                ),

                // Pictures
                ScreenRepairOrderVideoUploadRequestPictures(
                  request: request,
                  offlineItem: offlineItem,
                  offlineData: offlineData,
                  margin: const EdgeInsets.only(top: 32.0),
                ),

                // Delete button
                CustomAnimatedCollapseVisibility(
                  visible: canEdit,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: CustomBorderButton.small(
                      margin: const EdgeInsets.only(top: 32.0, left: 16.0, right: 16.0),
                      text: "Delete",
                      icon: Icons.delete_outline,
                      textColor: CustomColorsUtils.delete,
                      borderColor: CustomColorsUtils.delete,
                      onPressed: _askDeleteUpload,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: child,
    );
  }

  _onButtonInfoPressed({
    RepairOrderUploadVideoRequestModel? request,
    OfflineEnqueueItemModel? offlineItem,
    OfflineEnqueueItemRepairOrderVideoUploadModel? offlineData,
  }) {
    showCustomDialog(
      title: "Debug info",
      childPadding: EdgeInsets.zero,
      builder: (context, controller) => Column(
        children: [
          CustomListTile(
            dense: true,
            titleText: "Request",
            onPressed: () {
              if (request == null) return;
              showCustomDialog(
                title: "Request",
                childPadding: EdgeInsets.zero,
                builder: (context, controller) => CustomJsonViewer(
                  json: request.toJson(),
                ),
                buttonsBuilder: (context, controller) => [
                  CustomBorderButton.small(
                    text: "Accept",
                    onPressed: controller.close,
                  )
                ],
              );
            },
          ),
          const CustomDivider(),
          CustomListTile(
            dense: true,
            titleText: "Item",
            onPressed: () {
              if (offlineItem == null) return;
              showCustomDialog(
                title: "Item",
                childPadding: EdgeInsets.zero,
                builder: (context, controller) => CustomJsonViewer(
                  json: offlineItem.toJson(),
                ),
                buttonsBuilder: (context, controller) => [
                  CustomBorderButton.small(
                    text: "Accept",
                    onPressed: controller.close,
                  )
                ],
              );
            },
          ),
          const CustomDivider(),
          CustomListTile(
            dense: true,
            titleText: "Item data",
            onPressed: () {
              if (offlineData == null) return;
              showCustomDialog(
                title: "Item",
                childPadding: EdgeInsets.zero,
                builder: (context, controller) => CustomJsonViewer(
                  json: offlineData.toJson(),
                ),
                buttonsBuilder: (context, controller) => [
                  CustomBorderButton.small(
                    text: "Accept",
                    onPressed: controller.close,
                  )
                ],
              );
            },
          ),
        ],
      ),
      buttonsBuilder: (context, controller) => [
        CustomBorderButton.small(
          text: "Accept",
          onPressed: controller.close,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appbarIconColor = Theme.of(context).appBarTheme.backgroundColor?.contrast(context);
    final RepairOrderService service = GetIt.I.get();
    final OfflineEnqueueService offlineEnqueueService = GetIt.I.get();
    final isDebug = useIsDebug(ref);

    final snapshot = useStream(
      useMemoized(
        () => service.streamVideoUploadRequestByUID(widget.params.videoRequestUID),
        [widget.params.videoRequestUID],
      ),
    );

    final request = snapshot.data;

    final snapshotOfflineEnqueue = useStream(
      useMemoized(
        () => offlineEnqueueService.streamByUID(request?.offlineEnqueueUID ?? ""),
        [request?.offlineEnqueueUID],
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

    String title = "";
    if (request != null) {
      if (request.offlineEnqueueStatus == OfflineEnqueueItemStatus.done) {
        title = "Video";
      } else {
        title = "Video upload request";
      }
    }

    return CustomScaffold(
      appbar: CustomAppBar(
        leading: CustomButtonIcon(
          icon: Icons.arrow_back_ios,
          backgroundColor: Colors.transparent,
          iconColor: appbarIconColor,
          onPressed: _close,
        ),
        actionButtons: [
          if (isDebug)
            CustomButtonIcon(
              backgroundColor: Colors.transparent,
              iconColor: appbarIconColor,
              icon: Icons.info_outline,
              onPressed: () => _onButtonInfoPressed(
                request: request,
                offlineItem: offlineItem,
                offlineData: offlineData,
              ),
            ),
        ],
        title: title,
      ),
      body: _buildChild(
        request: request,
        offlineItem: offlineItem,
        offlineData: offlineData,
      ),
    );
  }
}
