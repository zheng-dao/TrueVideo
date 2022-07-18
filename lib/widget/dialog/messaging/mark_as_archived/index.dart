import 'package:get_it/get_it.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/service/messaging/_interface.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/button_gradient/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';

Future<bool> showCustomMessagingChannelMarkAsArchived(List<String> uuids, bool archived) async {
  String title;
  String message;
  if (uuids.length == 1) {
    if (archived) {
      title = "Archive channel";
      message = "Are you your you want to archive the channel?";
    } else {
      title = "Unarchive channel";
      message = "Are you your you want to unarchive the channel?";
    }
  } else {
    if (archived) {
      title = "Archive channels";
      message = "Are you sure you want to archive ${uuids.length} channels?";
    } else {
      title = "Unarchive channels";
      message = "Are you sure you want to unarchive ${uuids.length} channels?";
    }
  }
  bool result = false;
  await showCustomDialog(
    title: title,
    message: message,
    buttonsBuilder: (context, controller) => [
      CustomBorderButton.small(
        text: "Cancel",
        onPressed: () async {
          result = false;
          controller.close();
        },
      ),
      CustomGradientButton.small(
        gradient: CustomColorsUtils.gradient,
        text: "Yes",
        onPressed: () async {
          controller.setLoading(true);
          final deleted = await _process(uuids, archived);
          if (deleted) {
            result = true;
            controller.close();
          } else {
            result = false;
            controller.setLoading(false);
          }
        },
      ),
    ],
  );
  return result;
}

Future<bool> _process(List<String> uuids, bool archive) async {
  try {
    final MessagingService service = GetIt.I.get();
    await service.markAsArchived(uuids, archive);
    return true;
  } catch (error) {
    return false;
  }
}
