import 'package:get_it/get_it.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/service/messaging/_interface.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/button_gradient/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';

Future<bool> showCustomMessagesDelete(List<String> uuids) async {
  String title;
  String message;
  if (uuids.length == 1) {
    title = "Delete message";
    message = "Are you your you want to delete the message?";
  } else {
    title = "Delete messages";
    message = "Are you sure you want to delete ${uuids.length} messages?";
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
        gradient: CustomColorsUtils.deleteGradient,
        text: "Delete",
        onPressed: () async {
          controller.setLoading(true);
          final deleted = await _delete(uuids);
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

Future<bool> _delete(List<String> uuids) async {
  try {
    final MessagingService service = GetIt.I.get();
    await service.deleteMessages(uuids);
    return true;
  } catch (error) {
    return false;
  }
}
