import 'package:get_it/get_it.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/service/messaging/_interface.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/button_gradient/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';

Future<bool> showCustomMessagingChannelMarkAsFavorite(List<String> uuids, bool favorite) async {
  String title;
  String message;
  if (uuids.length == 1) {
    if (favorite) {
      title = "Mark as favorite";
      message = "Are you your you want to mark as favorite the channel?";
    } else {
      title = "UnMark as favorite";
      message = "Are you your you want to unmark as favorite the channel?";
    }
  } else {
    if (favorite) {
      title = "Mark as favorite";
      message = "Are you sure you want to mark as favorite ${uuids.length} channels?";
    } else {
      title = "UnMark as favorite";
      message = "Are you sure you want to unmark as favorite ${uuids.length} channels?";
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
          final deleted = await _process(uuids, favorite);
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

Future<bool> _process(List<String> uuids, bool favorite) async {
  try {
    final MessagingService service = GetIt.I.get();
    await service.markAsFavorite(uuids, favorite);
    return true;
  } catch (error) {
    return false;
  }
}
