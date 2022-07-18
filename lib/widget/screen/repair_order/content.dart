import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/model/camera/video_session.dart';
import 'package:truvideo_enterprise/model/repair_order_detail.dart';
import 'package:truvideo_enterprise/widget/common/list/divider.dart';
import 'package:truvideo_enterprise/widget/screen/repair_order/checklist_button.dart';
import 'package:truvideo_enterprise/widget/screen/repair_order/content_technician.dart';
import 'package:truvideo_enterprise/widget/screen/repair_order/video_gallery/index.dart';

import 'content_customer.dart';
import 'content_header.dart';
import 'content_owner.dart';
import 'content_vehicle.dart';
import 'content_video_session.dart';

class ScreenRepairOrderDetailContent extends HookConsumerWidget {
  final RepairOrderDetailModel model;
  final Function(VideoSessionModel model)? resumeVideo;

  const ScreenRepairOrderDetailContent({
    Key? key,
    required this.model,
    this.resumeVideo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ScreenRepairOrderHeader(model: model),
          const CustomDivider(),

          // Checklist button (Only RO)
          if (model.isRepairOrder) ChecklistButton(model: model),
          if (model.isRepairOrder) const CustomDivider(),

          // Customer
          ScreenRepairOrderDetailCustomer(model: model),
          const CustomDivider(),

          ScreenRepairOrderDetailOwner(model: model),
          const CustomDivider(),

          if (model.isRepairOrder) ScreenRepairOrderDetailTechnician(model: model),
          if (model.isRepairOrder) const CustomDivider(),

          // Vehicle (Only SO)
          if (!model.isRepairOrder) ScreenRepairOrderDetailVehicle(model: model),
          if (!model.isRepairOrder) const CustomDivider(),

          // Video session
          ScreenRepairOrderDetailVideoSession(
            model: model,
            onResumePressed: resumeVideo,
          ),

          // Gallery
          ScreenRepairOrderDetailVideoGallery(model: model),
        ],
      ),
    );
  }
}
