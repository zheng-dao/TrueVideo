import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/hook/video_tag_enabled.dart';
import 'package:truvideo_enterprise/hook/video_tags.dart';
import 'package:truvideo_enterprise/hook/video_types.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_ro_video_upload.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_status.dart';
import 'package:truvideo_enterprise/model/ro/upload_video_request.dart';
import 'package:truvideo_enterprise/service/date/_interface.dart';
import 'package:truvideo_enterprise/service/repair_order/_interface.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/text_field/icon.dart';
import 'package:truvideo_enterprise/widget/common/text_field/index.dart';
import 'package:truvideo_enterprise/widget/common/video_tag_picker/index.dart';
import 'package:truvideo_enterprise/widget/common/video_type_picker/index.dart';
import 'package:truvideo_enterprise/widget/screen/repair_order/video_upload_request_status_button.dart';
import 'package:truvideo_enterprise/widget/screen/repair_order_upload_video_request/status.dart';

import 'error.dart';

class ScreenRepairOrderUploadVideoRequestHeader extends StatefulHookConsumerWidget {
  final EdgeInsets? margin;
  final RepairOrderUploadVideoRequestModel request;
  final OfflineEnqueueItemModel? offlineItem;
  final OfflineEnqueueItemRepairOrderVideoUploadModel? offlineData;
  final bool canEdit;

  const ScreenRepairOrderUploadVideoRequestHeader({
    Key? key,
    this.margin,
    required this.request,
    this.offlineItem,
    this.offlineData,
    this.canEdit = false,
  }) : super(key: key);

  @override
  ConsumerState<ScreenRepairOrderUploadVideoRequestHeader> createState() => _ScreenRepairOrderUploadVideoRequestHeaderState();
}

class _ScreenRepairOrderUploadVideoRequestHeaderState extends ConsumerState<ScreenRepairOrderUploadVideoRequestHeader> {
  @override
  void dispose() {
    EasyDebounce.cancel("description");
    super.dispose();
  }

  _pickTag() async {
    final model = await showCustomVideoTagPicker();
    if (model == null) return;

    try {
      final RepairOrderService repairOrderService = GetIt.I.get();
      await repairOrderService.updateVideoUploadRequest(
        widget.request.copyWith(
          videoTagID: model.key,
          updateDate: DateTime.now(),
        ),
      );
    } catch (_) {}
  }

  _pickType() async {
    final model = await showCustomVideoTypePicker();
    if (model == null) return;

    try {
      final RepairOrderService repairOrderService = GetIt.I.get();
      await repairOrderService.updateVideoUploadRequest(
        widget.request.copyWith(
          videoTypeID: model.id,
          updateDate: DateTime.now(),
        ),
      );
    } catch (_) {}
  }

  _changeDescription(String value) async {
    try {
      final RepairOrderService repairOrderService = GetIt.I.get();
      await repairOrderService.updateVideoUploadRequest(
        widget.request.copyWith(
          videoDescription: value,
          updateDate: DateTime.now(),
        ),
      );
    } catch (_) {}
  }

  bool get _buttonStatusVisible {
    if (widget.request.offlineEnqueueStatus == null) return true;
    if (widget.request.offlineEnqueueStatus == OfflineEnqueueItemStatus.processing) return false;
    if (widget.request.offlineEnqueueStatus == OfflineEnqueueItemStatus.error) return false;
    if (widget.request.offlineEnqueueStatus == OfflineEnqueueItemStatus.done) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final DateService dateService = GetIt.I.get();

    final videoTags = useVideoTags(ref);
    final videoTypes = useVideoTypes(ref);
    final isVideoTagEnabled = useIsVideoTagEnabled(ref);
    final isRepairOrder = widget.request.orderType == "REPAIR_ORDER";
    final isSalesOrder = widget.request.orderType == "SALES_ORDER";

    final tagController = useTextEditingController();
    useEffect(
      () {
        if (!isVideoTagEnabled) return () {};

        final tag = videoTags.firstWhereOrNull((e) => e.key == widget.request.videoTagID);
        if (tag == null) {
          tagController.text = "";
        } else {
          tagController.text = tag.displayName;
        }
        return () {};
      },
      [widget.request.videoTagID, isVideoTagEnabled, videoTags],
    );

    final typeController = useTextEditingController();
    useEffect(
      () {
        final type = videoTypes.firstWhereOrNull((e) => e.id == widget.request.videoTypeID);
        if (type == null) {
          typeController.text = "";
        } else {
          typeController.text = type.description;
        }

        return () {};
      },
      [widget.request.videoTypeID, isVideoTagEnabled, videoTypes],
    );

    final descriptionController = useTextEditingController();
    useEffect(
      () {
        descriptionController.text = widget.request.videoDescription;
        return () {};
      },
      [],
    );

    return Container(
      margin: widget.margin,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  direction: Axis.vertical,
                  spacing: 8.0,
                  children: [
                    if (widget.request.creationDate != null)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Created at", style: Theme.of(context).textTheme.bodySmall),
                          Text(dateService.formatDateTime(widget.request.creationDate!)),
                        ],
                      ),
                  ],
                ),
              ),
              CustomAnimatedFadeVisibility(
                visible: _buttonStatusVisible,
                child: RepairOrderVideoUploadRequestStatus(
                  uid: widget.request.uid,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          ScreenRepairOrderUploadVideoRequestError(
            margin: const EdgeInsets.only(bottom: 32),
            request: widget.request,
            offlineItem: widget.offlineItem,
          ),
          ScreenRepairOrderUploadVideoRequestStatus(
            margin: const EdgeInsets.only(bottom: 32),
            request: widget.request,
            offlineItem: widget.offlineItem,
            offlineData: widget.offlineData,
          ),
          if (isVideoTagEnabled && isRepairOrder)
            CustomTextField(
              enabled: widget.canEdit,
              onPressed: _pickTag,
              labelText: "Tag",
              margin: const EdgeInsets.only(bottom: 16),
              controller: tagController,
              suffix: const CustomTextFieldIconButton(
                icon: Icons.chevron_right,
              ),
            ),
          if (isSalesOrder)
            CustomTextField(
              labelText: "Type",
              enabled: widget.canEdit,
              onPressed: _pickType,
              margin: const EdgeInsets.only(bottom: 16),
              controller: typeController,
              suffix: const CustomTextFieldIconButton(
                icon: Icons.chevron_right,
              ),
            ),
          CustomTextField(
            enabled: widget.canEdit,
            labelText: "Description",
            controller: descriptionController,
            minLines: 3,
            maxLines: null,
            onChanged: (value) => EasyDebounce.debounce(
              "description",
              const Duration(milliseconds: 100),
              () => _changeDescription(value),
            ),
          ),
        ],
      ),
    );
  }
}
